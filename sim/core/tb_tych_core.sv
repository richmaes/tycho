module tb_tych_core;
  localparam NUM_PORTS = 2;
  localparam MPI_AWIDTH = 32;
  localparam MPI_DWIDTH = 32;
  // Clock and reset signals
  logic clk;
  logic rst;

  // Microprocessor downstream interface
  logic [MPI_AWIDTH-1:0] mpi_if_address;
  logic [MPI_DWIDTH-1:0] mpi_if_wr_data;
  logic [MPI_DWIDTH-1:0] mpi_if_rd_data;
  logic                  mpi_if_wr_req;
  logic                  mpi_if_rd_req;
  logic [3:0]            mpi_if_wr_strb;
  logic                  mpi_if_enable;
  logic                  mpi_if_ack;
  logic                  mpi_if_error;
  // MAC interface signals
  mac_avltx_t    [0:NUM_PORTS-1] mac_0_tx;
  reg            [0:NUM_PORTS-1] mac_0_tx_ready;
  mac_avlrx_t    [0:NUM_PORTS-1] mac_0_rx;

  // Instantiate the DUT
  tych_core #(
    .NUM_PORTS(2)
    ) dut (
    .clk(clk),
    .rst(rst),

    // Microprocessor downstream interface
    .mpi_if_address(mpi_if_address),
    .mpi_if_wr_data(mpi_if_wr_data),
    .mpi_if_rd_data(mpi_if_rd_data),
    .mpi_if_wr_req (mpi_if_wr_req),
    .mpi_if_rd_req (mpi_if_rd_req),
    .mpi_if_wr_strb(mpi_if_wr_strb),
    .mpi_if_enable (mpi_if_enable),
    .mpi_if_ack    (mpi_if_ack),
    .mpi_if_error  (mpi_if_error),

    // MAC interfaces
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
    mac_0_tx_ready[0] = 1'b1;
    mac_0_rx[0].data = 512'b0;
    mac_0_rx[0].sop = 1'b0;
    mac_0_rx[0].eop = 1'b0;
    mac_0_rx[0].valid = 1'b0;
    mac_0_rx[0].errors = 6'b0;
    mac_0_tx_ready[1] = 1'b1;
    mac_0_rx[1].data = 512'b0;
    mac_0_rx[1].sop = 1'b0;
    mac_0_rx[1].eop = 1'b0;
    mac_0_rx[1].valid = 1'b0;
    mac_0_rx[1].errors = 6'b0;

    mpi_if_address = '0;
    mpi_if_wr_data = '0;
    mpi_if_rd_req = 1'b0;
    mpi_if_wr_req = 1'b0;
    mpi_if_wr_strb = 4'b0;
    mpi_if_enable = 1'b0;

    // Wait for reset deassertion
    @(negedge rst);

    // Add your test cases here

    // Finish simulation after some time
    #1000;
    $finish;
  end

endmodule