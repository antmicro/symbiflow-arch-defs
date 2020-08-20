`include "mux.sim.v"
`include "delay.sim.v"
`include "dff.sim.v"

`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module IN_REG_CELL(IQC, QRT, A2F, IQZ);

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire IQC;

    input wire QRT;

    input wire A2F;

    (* CLK_TO_Q = "IQC {iopath_IQC_IQZ}" *)
    output wire IQZ;

    wire A2F_delayed;
    wire fixhold_mux_op;

    reg iqz_reg;

    specify
        (IQC => QZ) = "";
        $setup(QRT, posedge IQC, "");
        $hold(posedge IQC, QRT, "");
        $setup(A2F, posedge IQC, "");
        $hold(posedge IQC, A2F, "");
    endspecify

    DELAY delay_inst (
        .IN(A2F),
        .OUT(A2F_delayed)
    );

    MUX fixhold_mux (
        .I0(A2F),
        .I1(A2F_delayed),
        .O(fixhold_mux_op)
    );

    DFF dff_inst (
        .D(fixhold_mux_op),
        .Q(iqz_reg),
        .CLK(IQC),
        .RST(QRT)
    );

    MUX isel_mux (
        .I0(iqz_reg),
        .I1(A2F),
        .O(IQZ)
    );

endmodule
