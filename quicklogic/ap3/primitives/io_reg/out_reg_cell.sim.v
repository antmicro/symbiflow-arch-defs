`include "mux.sim.v"
`include "dff.sim.v"

`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module OUT_REG_CELL(IQC, QRT, OQI, F2A);

    (* SETUP="IQC {setup_IQC_OQI_$inp}" *) (* NO_COMB *)
    (* HOLD="IQC {hold_IQC_OQI_$inp}" *) (* NO_COMB *)
    input wire OQI;

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire IQC;

    (* SETUP="IQC 1e-10" *) (* NO_COMB *)
    input wire QRT;

    (* CLK_TO_Q = "IQC {iopath_IQC_F2A_$out}" *)
    output wire F2A;

    wire osel_mux_op;

    wire f2a_reg;

    specify
        (IQC => QZ) = "";
        $setup(QRT, posedge IQC, "");
        $hold(posedge IQC, QRT, "");
        $setup(OQI_$inp, posedge IQC, "");
        $hold(posedge IQC, OQI, "");
        $setup(OSEL_$inp, posedge IQC, "");
        $hold(posedge IQC, OSEL, "");
    endspecify

    DFF dff_inst (
        .D(OQI),
        .Q(f2a_reg),
        .CLK(IQC),
        .RST(QRT)
    );

    MUX osel_mux (
        .I0(f2a_reg),
        .I1(OQI),
        .O(F2A)
    );

endmodule
