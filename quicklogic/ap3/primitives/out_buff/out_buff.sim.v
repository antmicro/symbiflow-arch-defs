`include "../vpr_pad/vpr_ipad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="" *)
(* whitebox *)
module OUT_BUFF (
	A,
	Q
    );

    input wire A;
    output wire Q;

    (* pack="IPAD_TO_Q" *)
    wire in_pad;

    assign Q = A;

    (* keep *)
    VPR_IPAD inpad(in_pad);

endmodule
