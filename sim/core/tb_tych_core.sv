module tb_tych_core;

  // Clock and reset signals
  logic clk;
  logic rst;

  // MAC interface signals
  mac_avltx_t mac_0_tx;
  logic        mac_0_tx_ready;
  mac_avlrx_t mac_0_rx;

  // Instantiate the DUT
  tych_core dut (
    .clk(clk),
    .rst(rst),
    .mac_0_tx(mac_0_tx),
    .mac_0_tx_ready(mac_0_tx_ready),
    .mac_0_rx(mac_0_rx)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock
  end

  // Reset generation
  initial begin
    rst = 1;
    #20;
    rst = 0;
  end

  // Testbench stimulus
  initial begin
    // Initialize inputs
    mac_0_tx_ready = 1'b1;
    mac_0_rx.data = 512'b0;
    mac_0_rx.sop = 1'b0;
    mac_0_rx.eop = 1'b0;
    mac_0_rx.valid = 1'b0;
    mac_0_rx.errors = 6'b0;

    // Wait for reset deassertion
    @(negedge rst);

    // Add your test cases here

    // Finish simulation after some time
    #1000;
    $finish;
  end

endmodule