`timescale 1ns/10ps
(* MODEL_NAME="OUT_BUFF" *)
(* whitebox *)
module OUT_BUFF (
	A,
	Q
    );

    input wire A;
	(* DELAY_CONST_A="1e-10" *)
    output wire Q;

    assign Q = A;

endmodule
