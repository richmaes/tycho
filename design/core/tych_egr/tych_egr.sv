module tych_egr (
input logic clk,
input logic rst,

input core_avl_t core_avl_in,
output logic core_avl_in_ready,

output core_avl_t core_avl_out,
input logic core_avl_out_ready

);

endmodule