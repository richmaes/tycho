// Single Clock FIFO with parameters

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module scfifo_param 
# (
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 16,
    parameter DEVICE_FAMILY="Agilex 7"

) (
	clock,
	data,
	rdreq,
	wrreq,
	empty,
	full,
	q,
	usedw);

    localparam  USEDW = $clog2(DEPTH);

	input	  clock;
	input	[DATA_WIDTH-1:0]  data;
	input	  rdreq;
	input	  wrreq;
	output	  empty;
	output	  full;
	output	[DATA_WIDTH-1:0]  q;
	output	[USEDW-1:0]  usedw;

	wire  sub_wire0;
	wire  sub_wire1;
	wire [DATA_WIDTH-1:0] sub_wire2;
	wire [USEDW-1:0] sub_wire3;
	wire  empty = sub_wire0;
	wire  full = sub_wire1;
	wire [DATA_WIDTH-1:0] q = sub_wire2[DATA_WIDTH-1:0];
	wire [USEDW-1:0] usedw = sub_wire3[USEDW-1:0];

	scfifo	scfifo_component (
				.clock (clock),
				.data (data),
				.rdreq (rdreq),
				.wrreq (wrreq),
				.empty (sub_wire0),
				.full (sub_wire1),
				.q (sub_wire2),
				.usedw (sub_wire3),
				.aclr (),
				.almost_empty (),
				.almost_full (),
				.eccstatus (),
				.sclr ());
	defparam
		scfifo_component.add_ram_output_register = "OFF",
		scfifo_component.intended_device_family = DEVICE_FAMILY,
		scfifo_component.lpm_numwords = DEPTH,
		scfifo_component.lpm_showahead = "OFF",
		scfifo_component.lpm_type = "scfifo",
		scfifo_component.lpm_width = DATA_WIDTH,
		scfifo_component.lpm_widthu = USEDW,
		scfifo_component.overflow_checking = "ON",
		scfifo_component.underflow_checking = "ON",
		scfifo_component.use_eab = "ON";


endmodule
