`include "./logic_cell.sim.v"

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
    input wire CI, QEN, QST, QRT, QCK;

    output wire [7:0] FZ, AQZ, BQZ, CQZ;
    output wire CO;

    parameter [7:0] LC_MODE;
    parameter [7:0] LC_QDI_MUX;
    parameter [7:0] LC_BQZ_MUX;
    parameter [7:0] LC_CQZ_MUX;

    assign LC_MODE[0] = "LUT_FF";
    assign LC_QDI_MUX[0] = "I0";
    assign LC_BQZ_MUX[0] = "I0";
    assign LC_CQZ_MUX[0] = "I0";

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

    genvar i;
    generate for (i = 1; i < 8; i = i + 1) begin: slice

        assign LC_MODE[i] = "LUT_FF";
        assign LC_QDI_MUX[i] = "I0";
        assign LC_BQZ_MUX[i] = "I0";
        assign LC_CQZ_MUX[i] = "I0";
        LOGIC_CELL #(.MODE(LC_MODE[i]), .LE_QDI_MUX(LC_QDI_MUX[i]),
                    .LE_BQZ_MUX(LC_BQZ_MUX[i]), .LE_CQZ_MUX(LC_CQZ_MUX[i])) lc_i (
            .LI(LiI),
            .CI(CO_int[i-1]),
            .QEN(QEN),
            .QST(QST),
            .QRT(QRT),
            .QCK(QCK),
            .FZ(FZ[i]),
            .AQZ(AQZ[i]),
            .BQZ(BQZ[i]),
            .CQZ(CQZ[i]),
            .CO(CO_int[i])
        );

    end: slice
    endgenerate

    assign LC_MODE[7] = "LUT_FF";
    assign LC_QDI_MUX[7] = "I0";
    assign LC_BQZ_MUX[7] = "I0";
    assign LC_CQZ_MUX[7] = "I0";
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

