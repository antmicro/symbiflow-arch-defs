`include "../vpr_pad/vpr_opad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="" *)
(* whitebox *)
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
