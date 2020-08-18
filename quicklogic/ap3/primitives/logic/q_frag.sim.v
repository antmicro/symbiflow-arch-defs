`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="Q_FRAG" *)
(* whitebox *)
module Q_FRAG (QEN, QST, UQST, QSTS, QRT, UQRT, QRTS, QCK, QDI, CDS, AQZ);

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire QCK;

    // Cannot model timing, VPR currently does not support async SET/RESET
	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QST;

    // Cannot model timing, VPR currently does not support async SET/RESET
	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire UQST;

    // Cannot model timing, VPR currently does not support async SET/RESET
	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QSTS;

    // Cannot model timing, VPR currently does not support async SET/RESET
	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QRT;

    // Cannot model timing, VPR currently does not support async SET/RESET
	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire UQRT;

    // Cannot model timing, VPR currently does not support async SET/RESET
	(* SETUP="QCK 1e-10" *) (* NO_COMB *)
    input  wire QRTS;

    // No timing for QEN -> QZ in LIB/SDF
	(* SETUP="QCK {setup_QCK_QEN}" *) (* NO_COMB *)
	(* HOLD="QCK {hold_QCK_QEN}" *) (* NO_COMB *)
    input  wire QEN;

	(* SETUP="QCK {setup_QCK_QDI}" *) (* NO_COMB *)
	(* HOLD="QCK {hold_QCK_QDI}" *) (* NO_COMB *)
    input  wire QDI;

	(* SETUP="QCK {setup_QCK_CDS}" *) (* NO_COMB *)
	(* HOLD="QCK {hold_QCK_CDS}" *) (* NO_COMB *)
    input  wire CDS;

    (* CLK_TO_Q = "QCK {iopath_QCK_AQZ}" *)
    output reg AQZ;

    wire mux_qst_op, mux_qrt_op ;
    reg QZ_reg;

    specify
        (QCK => AQZ) = "";
        $setup(QDI, posedge QCK, "");
        $hold(posedge QCK, QDI, "");
        $setup(QST, posedge QCK, "");
        $hold(posedge QCK, QST, "");
        $setup(QRT, posedge QCK, "");
        $hold(posedge QCK, QRT, "");
        $setup(QEN, posedge QCK, "");
        $hold(posedge QCK, QEN, "");
        $setup(CDS, posedge QCK, "");
        $hold(posedge QCK, CDS, "");
    endspecify

    assign mux_qst_op = QSTS ? UQST : QST;

    assign mux_qrt_op = QRTS ? UQRT : QRT;

    always @ (posedge QCK)
    begin
        if(~mux_qrt_op && ~mux_qst_op )
            if(QEN && CDS)
                QZ_reg <= QDI;
    end

    always @(QRT or QST)
    begin
        if(mux_qrt_op)
            QZ_reg <= 1'b0;
        else if (mux_qst_op)
            QZ_reg <= 1'b1;
    end

    assign AQZ = QZ_reg;

endmodule
