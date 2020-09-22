`include "mux.sim.v"
`include "../gnd/gnd.sim.v"
`include "../vcc/vcc.sim.v"

module d_buff (
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
