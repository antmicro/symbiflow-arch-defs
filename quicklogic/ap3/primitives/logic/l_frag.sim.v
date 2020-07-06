`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="L_FRAG" *)
(* whitebox *)
module L_FRAG (
        fragBitInfo, 
        I0, 
        I1, 
        I2, 
        I3, 
        LUTOutput,
        CarryOut);

input [15:0] fragBitInfo; 
input I0, I1, I2, I3;
output LUTOutput; 
output CarryOut;

wire stage0_op0, stage0_op1, stage0_op2, stage0_op3, stage0_op4, stage0_op5, stage0_op6, stage0_op7; 
wire stage1_op0, stage1_op1, stage1_op2, stage1_op3;
wire stage2_op0, stage2_op1;


assign stage0_op0 = I0 ? fragBitInfo[1] : fragBitInfo[0];
assign stage0_op1 = I0 ? fragBitInfo[3] : fragBitInfo[2];
assign stage0_op2 = I0 ? fragBitInfo[5] : fragBitInfo[4];
assign stage0_op3 = I0 ? fragBitInfo[7] : fragBitInfo[6];
assign stage0_op4 = I0 ? fragBitInfo[9] : fragBitInfo[8];
assign stage0_op5 = I0 ? fragBitInfo[11] : fragBitInfo[10];
assign stage0_op6 = I0 ? fragBitInfo[13] : fragBitInfo[12];
assign stage0_op7 = I0 ? fragBitInfo[15] : fragBitInfo[14];


assign stage1_op0 = I1 ? stage0_op1 : stage0_op0; 
assign stage1_op1 = I1 ? stage0_op3 : stage0_op2;
assign stage1_op2 = I1 ? stage0_op5 : stage0_op4;
assign stage1_op3 = I1 ? stage0_op7 : stage0_op6;


assign stage2_op0 = I2 ? stage1_op1 : stage1_op0;
assign stage2_op1 = I2 ? stage1_op3 : stage1_op2;


assign LUTOutput = I3 ? stage2_op1 : stage2_op0;
assign CarryOut = stage2_op1;

endmodule

