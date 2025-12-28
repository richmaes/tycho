`include "./common/structs/mac_avl_structures.sv"
`include "./common/structs/core_structures.sv"
//import mac_avl_structures_sv_unit::*;

module tych_core #(
   NUM_PORTS = 2,
   MPI_AWIDTH = 32,
   MPI_DWIDTH = 32
) (
input  wire        clk,
input  wire        rst,

// Microprocessor downstream interface
input [MPI_AWIDTH-1:0]  mpi_if_address,
input [MPI_DWIDTH-1:0]  mpi_if_wr_data,
output [MPI_DWIDTH-1:0] mpi_if_rd_data,
input                   mpi_if_wr_req,
input                   mpi_if_rd_req,
input [3:0]             mpi_if_wr_strb,
input                   mpi_if_enable,
output                  mpi_if_ack,
output                  mpi_if_error,

output mac_avltx_t      [0:NUM_PORTS-1] mac_0_tx,
input  wire             [0:NUM_PORTS-1] mac_0_tx_ready,
input  wire mac_avlrx_t [0:NUM_PORTS-1] mac_0_rx

);

core_avl_t [0:NUM_PORTS-1] ing_fwd_avl ;
wire       [0:NUM_PORTS-1] ing_fwd_avl_ready ;
core_avl_t [0:NUM_PORTS-1] fwd_egr_avl ;
wire       [0:NUM_PORTS-1] fwd_egr_avl_ready ;

genvar iport, eport;

// Ingress processing modules
for (iport = 0; iport < NUM_PORTS; iport = iport + 1) begin : ING_LOGIC
    tych_ing u_tych_ing (
        .clk               (clk),
        .rst               (rst),
        .mac_rx            (mac_0_rx[iport]),
        .core_avl_out      (ing_fwd_avl[iport]),
        .core_avl_out_ready(ing_fwd_avl_ready[iport]),
        .core_ingmeta_out  ()  // Leave unconnected for now
    );
end

// Data path forwarding decision module
    tych_fwd #(
        .NUM_PORTS(NUM_PORTS)
        ) u_tych_fwd (
        .clk                (clk),
        .rst                (rst),
        .core_avl_in        (ing_fwd_avl),
        .core_avl_in_ready  (ing_fwd_avl_ready), // Not connected
        .core_avl_out       (fwd_egr_avl),
        .core_avl_out_ready (fwd_egr_avl_ready) // Not connected
    );

// Egress processing modules
for (eport = 0; eport < NUM_PORTS; eport = eport + 1) begin : EGR_LOGIC
    tych_egr u_tych_egr (
        .clk                (clk),
        .rst               (rst),
        .core_avl_in        (fwd_egr_avl[eport]),
        .core_avl_in_ready  (fwd_egr_avl_ready[eport]),
        .core_avl_out       (mac_0_tx[eport]),
        .core_avl_out_ready (mac_0_tx_ready[eport])
    );
end


endmodule