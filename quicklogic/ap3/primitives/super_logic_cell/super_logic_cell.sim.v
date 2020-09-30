`include "../logic_cell/logic_cell.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* keep_hierarchy *)
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

    parameter LC0_MODE = "LUT_FF";
    parameter LC0_QDI_MUX = "I0";
    parameter LC0_BQZ_MUX = "I0";
    parameter LC0_CQZ_MUX = "I0";

    parameter LC1_MODE = "LUT_FF";
    parameter LC1_QDI_MUX = "I0";
    parameter LC1_BQZ_MUX = "I0";
    parameter LC1_CQZ_MUX = "I0";

    parameter LC2_MODE = "LUT_FF";
    parameter LC2_QDI_MUX = "I0";
    parameter LC2_BQZ_MUX = "I0";
    parameter LC2_CQZ_MUX = "I0";

    parameter LC3_MODE = "LUT_FF";
    parameter LC3_QDI_MUX = "I0";
    parameter LC3_BQZ_MUX = "I0";
    parameter LC3_CQZ_MUX = "I0";

    parameter LC4_MODE = "LUT_FF";
    parameter LC4_QDI_MUX = "I0";
    parameter LC4_BQZ_MUX = "I0";
    parameter LC4_CQZ_MUX = "I0";

    parameter LC5_MODE = "LUT_FF";
    parameter LC5_QDI_MUX = "I0";
    parameter LC5_BQZ_MUX = "I0";
    parameter LC5_CQZ_MUX = "I0";

    parameter LC6_MODE = "LUT_FF";
    parameter LC6_QDI_MUX = "I0";
    parameter LC6_BQZ_MUX = "I0";
    parameter LC6_CQZ_MUX = "I0";

    parameter LC7_MODE = "LUT_FF";
    parameter LC7_QDI_MUX = "I0";
    parameter LC7_BQZ_MUX = "I0";
    parameter LC7_CQZ_MUX = "I0";

    wire [6:0] CO_int;

    LOGIC_CELL /*#(.MODE(LC0_MODE[0]), .LE_QDI_MUX(LC0_QDI_MUX[0]),
                 .LE_BQZ_MUX(LC0_BQZ_MUX[0]), .LE_CQZ_MUX(LC0_CQZ_MUX[0]))*/ L0 (
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

    LOGIC_CELL /*#(.MODE(LC1_MODE[1]), .LE_QDI_MUX(LC1_QDI_MUX[1]),
                .LE_BQZ_MUX(LC1_BQZ_MUX[1]), .LE_CQZ_MUX(LC1_CQZ_MUX[1]))*/ L1 (
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

    LOGIC_CELL /*#(.MODE(LC2_MODE[2]), .LE_QDI_MUX(LC2_QDI_MUX[2]),
                .LE_BQZ_MUX(LC2_BQZ_MUX[2]), .LE_CQZ_MUX(LC2_CQZ_MUX[2]))*/ L2 (
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

    LOGIC_CELL /*#(.MODE(LC3_MODE[3]), .LE_QDI_MUX(LC3_QDI_MUX[3]),
                .LE_BQZ_MUX(LC3_BQZ_MUX[3]), .LE_CQZ_MUX(LC3_CQZ_MUX[3]))*/ L3 (
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

    LOGIC_CELL /*#(.MODE(LC4_MODE[4]), .LE_QDI_MUX(LC4_QDI_MUX[4]),
                .LE_BQZ_MUX(LC4_BQZ_MUX[4]), .LE_CQZ_MUX(LC4_CQZ_MUX[4]))*/ L4 (
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

    LOGIC_CELL /*#(.MODE(LC5_MODE[5]), .LE_QDI_MUX(LC5_QDI_MUX[5]),
                .LE_BQZ_MUX(LC5_BQZ_MUX[5]), .LE_CQZ_MUX(LC5_CQZ_MUX[5]))*/ L5 (
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

    LOGIC_CELL /*#(.MODE(LC6_MODE[6]), .LE_QDI_MUX(LC6_QDI_MUX[6]),
                .LE_BQZ_MUX(LC6_BQZ_MUX[6]), .LE_CQZ_MUX(LC6_CQZ_MUX[6]))*/ L6 (
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

    LOGIC_CELL /*#(.MODE(LC7_MODE[7]), .LE_QDI_MUX(LC7_QDI_MUX[7]),
                .LE_BQZ_MUX(LC7_BQZ_MUX[7]), .LE_CQZ_MUX(LC7_CQZ_MUX[7]))*/ L7 (
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

