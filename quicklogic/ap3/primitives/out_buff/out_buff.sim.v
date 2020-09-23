`include "../vpr_pad/vpr_ipad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="OUT_BUFF" *)
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
