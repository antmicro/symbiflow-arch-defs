`include "mux.sim.v"
`include "dff.sim.v"

`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module OUT_REG_CELL(IQC, QRT, OQI, F2A);

    input wire OQI;

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire IQC;

    input wire QRT;

    //(* CLK_TO_Q = "IQC {iopath_IQC_F2A}" *)
    (* CLK_TO_Q = "IQC 1e-10" *)
    output wire F2A;

    wire osel_mux_op;

    wire f2a_reg;

    specify
        (IQC => F2A) = "";
        $setup(QRT, posedge IQC, "");
        $hold(posedge IQC, QRT, "");
        $setup(OQI, posedge IQC, "");
        $hold(posedge IQC, OQI, "");
    endspecify

    DFF dff_inst (
        .D(OQI),
        .CLK(IQC),
        .RST(QRT),
        .Q(f2a_reg),
    );

    MUX osel_mux (
        .I0(f2a_reg),
        .I1(OQI),
        .O(F2A)
    );

endmodule
