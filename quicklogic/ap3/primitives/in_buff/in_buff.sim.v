`include "../vpr_pad/vpr_ipad.sim.v"

module in_buff (
	A,
	Q
);

	input wire A;
	output wire Q;

	(* pack="IPAD_TO_A" *)
	wire in_pad;

    assign Q = A;
	
	(* keep *)
	VPR_IPAD ipad_inst(in_pad);

endmodule
