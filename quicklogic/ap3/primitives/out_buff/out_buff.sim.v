`include "../vpr_pad/vpr_opad.sim.v"

module out_buff (
	A,
	Q
);

	input wire A;
	output wire Q;

	(* pack="Q_TO_OPAD" *)
	wire out_pad;

    assign Q = A;
	
	(* keep *)
	VPR_OPAD opad_inst(out_pad);

endmodule
