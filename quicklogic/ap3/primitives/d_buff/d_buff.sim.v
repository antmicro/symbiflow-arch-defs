`include "mux.sim.v"
`include "../gnd/gnd.sim.v"
`include "../vcc/vcc.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="D_BUFF" *)
(* whitebox *)
module D_BUFF (
	Q
);

	output wire Q;

    wire GND, VCC;
    GND inst_gnd(GND);
    VCC inst_vcc(VCC);

    MUX dsel_mux (
        .I0(GND),
        .I1(VCC),
        .O(Q)
	);

endmodule
