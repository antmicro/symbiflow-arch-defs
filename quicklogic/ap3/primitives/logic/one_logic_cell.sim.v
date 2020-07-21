`include "./l_frag.sim.v"
`include "./q_frag.sim.v"

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
        notifier,
        FZ,
        AQZ,
        BQZ,
        CQZ,
		LCO);

    input wire [15:0] lFragBitInfo;
    input wire LI0, LI1, LI2, LI3, CDS, QEN, QST, UQST, QSTS, QRT, UQRT, QRTS, QCK, QDI, notifier;

    output wire FZ, AQZ, BQZ, CQZ, LCO;

    parameter MODE = "LUT_FRAGS";

    wire mux_cds_op, lFragLUTOutput;

    assign mux_cds_op = CDS ? QDI : lFragLUTOutput;

    generate if(MODE == "LUT_FRAGS") begin
        // LOGIC Cell split into frags
        
        (* FASM_PREFIX="LOGIC.LOGIC" *)
        L_FRAG l_frag(
                .fragBitInfo(fragBitInfo), 
                .I0(LI0), 
                .I1(LI1), 
                .I2(LI2), 
                .I3(LI3), 
                .LUTOutput(FZ),
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
                .notifier(notifier), 
                .AQZ(AQZ));
    end endgenerate

endmodule

