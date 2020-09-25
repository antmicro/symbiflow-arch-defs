`include "../logic_cell/logic_cell.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* whitebox *)
module SUPER_LOGIC_CELL (
        L0I,
        L1I,
        L2I,
        L3I,
        L4I,
        L5I,
        L6I,
        L7I,
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

    input wire [3:0] L0I, L1I, L2I, L3I, L4I, L5I, L6I, L7I;
    input wire CI, QEN, QST, QRT;

    (* CLOCK *)
    input wire QCK;

    output wire [7:0] FZ, AQZ, BQZ, CQZ;
    output wire CO;

    parameter [7:0] LC_MODE = "LUT_FF";
    parameter [7:0] LC_QDI_MUX = "I0";
    parameter [7:0] LC_BQZ_MUX = "I0";
    parameter [7:0] LC_CQZ_MUX = "I0";

    wire [6:0] CO_int;

    LOGIC_CELL #(.MODE(LC_MODE[0]), .LE_QDI_MUX(LC_QDI_MUX[0]),
                 .LE_BQZ_MUX(LC_BQZ_MUX[0]), .LE_CQZ_MUX(LC_CQZ_MUX[0])) lc_0 (
            .LI(L0I),
            .CI(CI),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[0]),
            .AQZ(AQZ[0]),
            .BQZ(BQZ[0]),
            .CQZ(CQZ[0]),
            .CO(CO_int[0])
        );

    LOGIC_CELL #(.MODE(LC_MODE[1]), .LE_QDI_MUX(LC_QDI_MUX[1]),
                .LE_BQZ_MUX(LC_BQZ_MUX[1]), .LE_CQZ_MUX(LC_CQZ_MUX[1])) lc_1 (
            .LI(L1I),
            .CI(CO_int[0]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[1]),
            .AQZ(AQZ[1]),
            .BQZ(BQZ[1]),
            .CQZ(CQZ[1]),
            .CO(CO_int[1])
        );

    LOGIC_CELL #(.MODE(LC_MODE[2]), .LE_QDI_MUX(LC_QDI_MUX[2]),
                .LE_BQZ_MUX(LC_BQZ_MUX[2]), .LE_CQZ_MUX(LC_CQZ_MUX[2])) lc_2 (
            .LI(L2I),
            .CI(CO_int[1]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[2]),
            .AQZ(AQZ[2]),
            .BQZ(BQZ[2]),
            .CQZ(CQZ[2]),
            .CO(CO_int[2])
        );

    LOGIC_CELL #(.MODE(LC_MODE[3]), .LE_QDI_MUX(LC_QDI_MUX[3]),
                .LE_BQZ_MUX(LC_BQZ_MUX[3]), .LE_CQZ_MUX(LC_CQZ_MUX[3])) lc_3 (
            .LI(L3I),
            .CI(CO_int[2]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[3]),
            .AQZ(AQZ[3]),
            .BQZ(BQZ[3]),
            .CQZ(CQZ[3]),
            .CO(CO_int[3])
        );

    LOGIC_CELL #(.MODE(LC_MODE[4]), .LE_QDI_MUX(LC_QDI_MUX[4]),
                .LE_BQZ_MUX(LC_BQZ_MUX[4]), .LE_CQZ_MUX(LC_CQZ_MUX[4])) lc_4 (
            .LI(L4I),
            .CI(CO_int[3]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[4]),
            .AQZ(AQZ[4]),
            .BQZ(BQZ[4]),
            .CQZ(CQZ[4]),
            .CO(CO_int[4])
        );

    LOGIC_CELL #(.MODE(LC_MODE[5]), .LE_QDI_MUX(LC_QDI_MUX[5]),
                .LE_BQZ_MUX(LC_BQZ_MUX[5]), .LE_CQZ_MUX(LC_CQZ_MUX[5])) lc_5 (
            .LI(L5I),
            .CI(CO_int[4]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[5]),
            .AQZ(AQZ[5]),
            .BQZ(BQZ[5]),
            .CQZ(CQZ[5]),
            .CO(CO_int[5])
        );

    LOGIC_CELL #(.MODE(LC_MODE[6]), .LE_QDI_MUX(LC_QDI_MUX[6]),
                .LE_BQZ_MUX(LC_BQZ_MUX[6]), .LE_CQZ_MUX(LC_CQZ_MUX[6])) lc_6 (
            .LI(L6I),
            .CI(CO_int[5]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[6]),
            .AQZ(AQZ[6]),
            .BQZ(BQZ[6]),
            .CQZ(CQZ[6]),
            .CO(CO_int[6])
        );

    LOGIC_CELL #(.MODE(LC_MODE[7]), .LE_QDI_MUX(LC_QDI_MUX[7]),
                .LE_BQZ_MUX(LC_BQZ_MUX[7]), .LE_CQZ_MUX(LC_CQZ_MUX[7])) lc_7 (
        .LI(L7I),
        .CI(CO_int[6]),
        .QEN(QEN),
        .QST(QST),
        .QRT(QRT),
        .QCK(QCK),
        .FZ(FZ[7]),
        .AQZ(AQZ[7]),
        .BQZ(BQZ[7]),
        .CQZ(CQZ[7]),
        .CO(CO)
    );

endmodule

