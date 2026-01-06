`include "../common/structs/core_structures.sv"

//
//  Signal Flow Diagram:
//
//                         +--------------------+
//                         |                    |
//    core_avl_in -------> |  tych_ing_frm_buf  |
//   (core_avl_t)          |                    |
//   core_avl_in_ready <-- |  Virtual FIFO      |
//                         |  Write Side        |
//   core_ingmeta_in ----> |                    |
//   (core_ingmeta_t)      |  (FIFO selected    |
//                         |   by rcos/vs from  |
//    rd_ptr_update -----> |   metadata)        |
//   (remote read ptr)     |                    |
//                         |                    |
//                         +--------------------+
//

module tych_ing_frm_buf (

input wire clk,
input wire rst,

// Write side - Core AVL input stream
input  core_avl_t     core_avl_in,
output logic          core_avl_in_ready,

// Write side - Core ingress metadata (for FIFO selection)
input  core_ingmeta_t core_ingmeta_in,

// Read side pointer update interface (remote)
// Allows remote read pointer updates per virtual FIFO
input  logic        rd_ptr_update_valid,
input  logic [3:0]  rd_ptr_vs,          // Virtual Switch ID
input  logic [1:0]  rd_ptr_rcos,        // Relative CoS
input  logic [15:0] rd_ptr_value,       // Read pointer value
output logic        rd_ptr_update_ready,

// RAM write interface
output logic        ram_wr_en,          // Write enable
output logic [15:0] ram_wr_addr,        // Write address
output logic [511:0] ram_wr_data,       // Write data (512-bit)
output logic [5:0]  ram_wr_empty,       // Byte empty count
output logic        ram_wr_sop,         // Start of packet
output logic        ram_wr_eop,         // End of packet
output logic        ram_wr_error        // Error flag

);

// Virtual FIFO parameters
// Number of virtual FIFOs = VS (16) x RCOS (4) = 64 FIFOs
localparam NUM_VS = 16;
localparam NUM_RCOS = 4;
localparam NUM_FIFOS = NUM_VS * NUM_RCOS;
localparam NUM_FIFOS_WIDTH = $clog2(NUM_FIFOS);

// FIFO depth and pointer width
localparam FIFO_DEPTH = 1024;  // Depth per virtual FIFO
localparam PTR_WIDTH = 16;     // Pointer width

// Write pointers for each virtual FIFO
logic [PTR_WIDTH-1:0] wr_ptr [NUM_FIFOS-1:0];

// Read pointers for each virtual FIFO (updated remotely)
logic [PTR_WIDTH-1:0] rd_ptr [NUM_FIFOS-1:0];

// Extract FIFO selection from incoming metadata
logic [3:0] fifo_vs;
logic [1:0] fifo_rcos;
logic [NUM_FIFOS_WIDTH-1:0] fifo_idx;  // Combined index: {vs[3:0], rcos[1:0]}

// Extract vs and rcos from core_ingmeta_in
assign fifo_vs = core_ingmeta_in.vs;
assign fifo_rcos = core_ingmeta_in.rcos;

assign fifo_idx = {fifo_vs, fifo_rcos};

// Calculate FIFO occupancy for backpressure
logic [PTR_WIDTH-1:0] fifo_occupancy;
logic fifo_full;
logic fifo_almost_full;

assign fifo_occupancy = wr_ptr[fifo_idx] - rd_ptr[fifo_idx];
assign fifo_almost_full = (fifo_occupancy >= (FIFO_DEPTH - 8));  // Almost full threshold
assign fifo_full = (fifo_occupancy >= FIFO_DEPTH);

// Ready signal generation
// Ready when FIFO is not almost full and no reset
assign core_avl_in_ready = !fifo_almost_full && !rst;

// Write pointer update logic
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        for (int i = 0; i < NUM_FIFOS; i++) begin
            wr_ptr[i] <= '0;
        end
    end else begin
        // Increment write pointer when valid data is accepted
        if (core_avl_in.valid && core_avl_in_ready) begin
            wr_ptr[fifo_idx] <= wr_ptr[fifo_idx] + 1'b1;
        end
    end
end

// Read pointer update logic (remote interface)
logic [5:0] rd_update_idx;
assign rd_update_idx = {rd_ptr_vs, rd_ptr_rcos};

// Ready for read pointer updates (always ready in this simple implementation)
assign rd_ptr_update_ready = 1'b1;

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        for (int i = 0; i < NUM_FIFOS; i++) begin
            rd_ptr[i] <= '0;
        end
    end else begin
        // Update read pointer when valid update arrives
        if (rd_ptr_update_valid && rd_ptr_update_ready) begin
            rd_ptr[rd_update_idx] <= rd_ptr_value;
        end
    end
end

// RAM write interface logic
// Write to RAM when valid data is accepted
assign ram_wr_en = core_avl_in.valid && core_avl_in_ready;
assign ram_wr_addr = wr_ptr[fifo_idx];
assign ram_wr_data = core_avl_in.data;
assign ram_wr_empty = core_avl_in.empty;
assign ram_wr_sop = core_avl_in.sop;
assign ram_wr_eop = core_avl_in.eop;
assign ram_wr_error = core_avl_in.error;

endmodule
