`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="ff" *)
(* whitebox *)
module ff (QCK, D, QEN, QST, QRT, CQZ);

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire QCK;

	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
	(* HOLD="QCK 1e-10" *) (* NO_COMB *)
    input  wire D;

	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QST;

	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QRT;

	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QEN;

    //(* CLK_TO_Q = "QCK {iopath_QCK_CQZ}" *)
    (* CLK_TO_Q = "QCK 1e-10" *)
    output reg CQZ;

    (* ASSOC_CLOCK="QCK" *)
    always @(posedge QCK or posedge QRT or posedge QST)
        if (QRT)
            CQZ <= 1'b0;
        else if (QST)
            CQZ <= 1'b1;
        else if (QEN)
            CQZ <= D;

endmodule
