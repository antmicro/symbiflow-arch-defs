`include "../full_adder/full_adder.sim.v"
`include "../ff/ff.sim.v"
`include "./mux.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* keep_hierarchy *)
module BADDER (
        LI,
        CI,
        QEN,
        QST,
        QRT,
        QCK,
        FZ,
        AQZ,
        BQZ,
        CQZ,
        CO
);

    input wire [3:0] LI;
    input wire CI, QEN, QST, QRT, QCK;

    output wire FZ, AQZ, BQZ, CQZ, CO;

    wire sum_out;

    wire ff_in, ff_out;

    FULL_ADDER adder_inst(.A(LI[0]), .B(LI[1]), .CI(CI), .S(sum_out), .CO(CO));

    parameter QDI_MUX = "I0";
    MUX #(.MODE(QDI_MUX)) mux_qdi(.I0(sum_out), .I1(LI[3]), .O(ff_in));

    FF ff_inst(.D(ff_in), .QEN(QEN), .QST(QST), .QRT(QRT), .QCK(QCK), .CQZ(ff_out));    

    assign FZ = sum_out;

    assign AQZ = ff_out;
    
    parameter BQZ_MUX = "I0";
    MUX #(.MODE(BQZ_MUX)) mux_bqz(.I0(ff_out), .I1(sum_out), .O(BQZ));

    parameter CQZ_MUX = "I0";
    MUX #(.MODE(CQZ_MUX)) mux_cqz(.I0(ff_out), .I1(sum_out), .O(CQZ));

endmodule

