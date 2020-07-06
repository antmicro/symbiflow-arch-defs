`include "./l_frag.sim.v"
`include "./q_frag.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="ONE_LOGIC_CELL" *)
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
        notifier,
        FZ,
        AQZ,
		LCO);

    input [15:0] lFragBitInfo;
    input LI0, LI1, LI2, LI3, CDS, QEN, QST, UQST, QSTS, QRT, UQRT, QRTS, QCK, QDI, notifier;

    output  FZ, AQZ, LCO;

    wire mux_cds_op, lFragLUTOutput;

    assign mux_cds_op = CDS ? QDI : lFragLUTOutput;

    L_FRAG l_frag(
            .fragBitInfo(fragBitInfo), 
            .I0(LI0), 
            .I1(LI1), 
            .I2(LI2), 
            .I3(LI3), 
            .LUTOutput(FZ),
            .CarryOut(LCO));

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
            .notifier(notifier), 
            .AQZ(AQZ));

endmodule

