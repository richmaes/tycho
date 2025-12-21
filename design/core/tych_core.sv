`include "mac_types.sv"

module tych_core (
input clk,
input rst,

mac_avltx_t mac_0_tx,
input       mac_0_tx_ready,
mac_avlrx_t mac_0_rx,

);