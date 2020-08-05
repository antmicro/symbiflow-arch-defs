`include "mux.sim.v"

`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module D_BUFF_CELL(F2A_DEF);

    output wire F2A_DEF;

    MUX dsel_mux (
        .I0(1'b0),
        .I1(1'b1),
        .O(F2A_DEF)
    );

endmodule
