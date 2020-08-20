`include "mux.sim.v"
`include "../gnd/gnd.sim.v"
`include "../vcc/vcc.sim.v"

`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module D_BUFF_CELL(F2A_DEF);

    output wire F2A_DEF;

    wire GND, VCC;
    GND inst_gnd(GND);
    VCC inst_vcc(VCC);
    MUX dsel_mux (
        .I0(GND),
        .I1(VCC),
        .O(F2A_DEF)
    );

endmodule
