`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="LUT4" *)
(* whitebox *)
module LUT4 (
        I0,
        I1,
        I2,
        I3,
        O);

    parameter [15:0] INIT = 16'h0;
    
    input wire I0, I1, I2, I3;

    (* DELAY_CONST_I0="1e-10" *)
    (* DELAY_CONST_I1="1e-10" *)
    (* DELAY_CONST_I2="1e-10" *)
    (* DELAY_CONST_I3="1e-10" *)
    output wire O;

    wire [7:0] s3 = I3 ? INIT[15:8] : INIT[7:0];
	wire [3:0] s2 = I2 ?       s3[ 7:4] :       s3[3:0];
	wire [1:0] s1 = I1 ?       s2[ 3:2] :       s2[1:0];
	assign O = I0 ? s1[1] : s1[0];

endmodule

