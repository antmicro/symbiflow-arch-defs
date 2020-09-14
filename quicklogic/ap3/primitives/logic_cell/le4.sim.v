`include "../lut4/lut4.sim.v"
`include "../ff/ff.sim.v"
`include "./mux.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* whitebox *)
module LE4 (
        LI,
        QEN,
        QST,
        QRT,
        QCK,
        FZ,
        AQZ,
        BQZ,
        CQZ
);

    input wire [3:0] LI;
    input wire QEN, QST, QRT, QCK;

    output wire FZ, AQZ, BQZ, CQZ;

    (* pack="LUT2FF" *)
    wire lut_out;

    wire ff_out;

    LUT4 lut4_inst(.I0(LI[0]), I1(LI[1]), .I2(LI[2]), .I3(LI[3]), .O(lut_out));

    FF ff_inst(.D(lut_out), .QEN(QEN), .QST(QST), .QRT(QRT), .QCK(QCK), .CQZ(ff_out));    

    assign FZ = lut_out;
    assign AQZ = ff_out;
 
    parameter BQZ_MUX = "I0";
    MUX #(.MODE(BQZ_MUX)) mux_bqz(.I0(ff_out), .I1(lut_out), .O(BQZ));

    parameter CQZ_MUX = "I0";
    MUX #(.MODE(CQZ_MUX)) mux_cqz(.I0(ff_out), .I1(lut_out), .O(BQZ));

endmodule

