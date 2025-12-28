`include "../common/structs/mac_avl_structures.sv"
`include "../common/structs/core_structures.sv"

module tych_ing_m2c_avl (
    input  wire        clk,
    input  wire        rst,
    
    // MAC RX interface input
    input  mac_avlrx_t mac_rx,
    
    // Core AVL interface output
    output core_avl_t  core_avl
);

logic [11:0] dbg_id;

always @(posedge clk) begin
    if (rst) begin
        dbg_id <= 12'h000;
    end else begin
        dbg_id <= mac_rx.eop & mac_rx.valid ? dbg_id + 1 : dbg_id;
    end
end 

// Convert MAC RX structure to Core AVL structure
assign core_avl.valid      = mac_rx.valid;
assign core_avl.data       = mac_rx.data;
assign core_avl.sop        = mac_rx.sop;
assign core_avl.eop        = mac_rx.eop;
assign core_avl.empty      = mac_rx.empty;
assign core_avl.error      = |mac_rx.errors;  // OR all error bits into single error flag
assign core_avl.frm_dbg_id = dbg_id;         // Default debug ID (can be parameterized)

endmodule
