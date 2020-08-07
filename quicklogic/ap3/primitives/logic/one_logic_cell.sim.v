`include "./l_frag.sim.v"
`include "./q_frag.sim.v"
`include "./rmux.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="ONE_LOGIC_CELL" *)
/** (* MODES="MACRO:LUT_FRAGS;ADDER" *) **/
(* MODES="LUT_FRAGS" *)
(* whitebox *)
module ONE_LOGIC_CELL (
        lFragBitInfo,
        LI0,
        LI1,
        LI2,
        LI3,
        CDS,
        QEN,
        QST,
        UQST,
        QSTS,
        QRT,
        UQRT,
        QRTS,
        QCK,
        QDI,
        FZ,
        AQZ,
        BQZ,
        CQZ,
        LCO
);

    input wire [15:0] lFragBitInfo;
    input wire LI0, LI1, LI2, LI3, CDS, QEN, QST, UQST, QSTS, QRT, UQRT, QRTS, QCK, QDI;

    output wire FZ, AQZ, BQZ, CQZ, LCO;

    parameter MODE = "LUT_FRAGS";

    wire mux_cds_op, lFragLUTOutput;
    assign FZ = lFragLUTOutput;

    RMUX rmux (.I0(QDI), .I1(lFragLUTOutput), .O(mux_cds_op));

    generate if(MODE == "LUT_FRAGS") begin
        // LOGIC Cell split into frags

        (* FASM_PREFIX="LOGIC.LOGIC" *)
        L_FRAG l_frag(
                .fragBitInfo(lFragBitInfo),
                .I0(LI0),
                .I1(LI1),
                .I2(LI2),
                .I3(LI3),
                .LUTOutput(lFragLUTOutput),
                .CarryOut(LCO));

        (* FASM_PREFIX="LOGIC.LOGIC" *)
        Q_FRAG q_frag(
                .QEN(QEN),
                .QST(QST),
                .UQST(UQST),
                .QSTS(QSTS),
                .QRT(QRT),
                .UQRT(UQRT),
                .QRTS(QRTS),
                .QCK(QCK),
                .QDI(mux_cds_op),
                .CDS(CDS),
                .AQZ(AQZ));
    end endgenerate

endmodule

