`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="full_adder" *)
(* whitebox *)
module full_adder (
        A,
        B,
        CI,
        S,
        CO);

    parameter [15:0] INIT = 16'h0;
    
    input wire A, B, CI;

    (* DELAY_CONST_A="1e-10" *)
    (* DELAY_CONST_B="1e-10" *)
    (* DELAY_CONST_CI="1e-10" *)
    output wire S;

    (* DELAY_CONST_A="1e-10" *)
    (* DELAY_CONST_B="1e-10" *)
    (* DELAY_CONST_CI="1e-10" *)
    output wire CO;

   assign {CO, S} = A + B + CI;

endmodule

