`include "../common/structs/mac_avl_structures.sv"
`include "../common/structs/core_structures.sv"

module tych_ing (

input wire clk,
input wire rst,

// MAC RX interface input
input  mac_avlrx_t    mac_rx,

output core_avl_t     core_avl_out,
input  wire           core_avl_out_ready,

output core_ingmeta_t core_ingmeta_out
);

// Internal core_avl signal after MAC RX conversion
core_avl_t core_avl_in;

module tych_ing_m2c_avl (
    .clk(),
    .rst(),
    
    // MAC RX interface input
    .mac_rx(mac_rx),
    
    // Core AVL interface output
    .core_avl(core_avl_out)
);


// TODO: Add ingress processing logic here
// For now, pass through the converted data

assign core_ingmeta_out = '0;  // Default metadata output

endmodule