`include "../d_buff/d_buff.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* whitebox *)
module CONST_PAD (
	F2A_DEF
);

    output wire F2A_DEF;

    D_BUFF d_inst(F2A_DEF);

endmodule
