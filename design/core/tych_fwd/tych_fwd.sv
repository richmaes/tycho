`include "../common/structs/core_structures.sv"

module tych_fwd #(
    NUM_PORTS = 2
) (
input  wire            clk,
input  wire            rst,
input  wire core_avl_t [NUM_PORTS-1:0] core_avl_in ,
output wire            [NUM_PORTS-1:0] core_avl_in_ready,
output core_avl_t      [NUM_PORTS-1:0] core_avl_out,
input  wire            [NUM_PORTS-1:0] core_avl_out_ready
);

// Generate block to create bridge for each port
genvar i;
generate
    for (i = 0; i < NUM_PORTS; i = i + 1) begin : PORT_BRIDGE
        // Bridge core_avl_in to core_avl_out
        assign core_avl_out[i].valid      = core_avl_in[i].valid;
        assign core_avl_out[i].data       = core_avl_in[i].data;
        assign core_avl_out[i].sop        = core_avl_in[i].sop;
        assign core_avl_out[i].eop        = core_avl_in[i].eop;
        assign core_avl_out[i].empty      = core_avl_in[i].empty;
        assign core_avl_out[i].error      = core_avl_in[i].error;
        assign core_avl_out[i].frm_dbg_id = core_avl_in[i].frm_dbg_id;
        
        // Bridge ready signal (assuming always ready for now)
        assign core_avl_in_ready[i] = core_avl_out_ready[i];
    end
endgenerate

endmodule