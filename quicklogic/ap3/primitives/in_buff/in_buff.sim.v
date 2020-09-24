`include "../vpr_pad/vpr_opad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="IN_BUFF" *)
(* whitebox *)
module IN_BUFF (
	A,
	Q
    );

    input wire A;
	(* 
	DELAY_CONST_A="1e-10" *)
    output wire Q;

    /*(* pack="A_TO_OPAD" *)
    wire out_pad;

    (* keep *)
    VPR_OPAD opad_inst(out_pad);*/
    
    assign Q = A;

endmodule
