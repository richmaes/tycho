`include "./common/structs/mac_avl_structures.sv"

//import mac_avl_structures_sv_unit::*;

module tych_core (
input  wire        clk,
input  wire        rst,

output mac_avltx_t mac_0_tx,
input  wire        mac_0_tx_ready,
input  wire mac_avlrx_t mac_0_rx

);

assign mac_0_tx.data = 512'b0; //assigning default value to
assign mac_0_tx.sop = 1'b0; //assigning default value to s
assign mac_0_tx.eop = 1'b0; //assigning default value to
assign mac_0_tx.valid = 1'b0; //assigning default value to valid
assign mac_0_tx.error = 1'b0; //assigning default value to error
assign mac_0_tx.skip_crc = 1'b0; //assigning default value to skip_crc

endmodule