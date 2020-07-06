`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="Q_FRAG" *)
(* whitebox *)
module Q_FRAG (QEN, QST, UQST, QSTS, QRT, UQRT, QRTS, QCK, QDI, CDS, notifier, AQZ);

    input CDS, QEN, QST, UQST, QSTS, QRT, UQRT, QRTS, QCK, QDI, notifier;

    output  AQZ;

    wire mux_qst_op, mux_qrt_op ;
    reg QZ_reg;
    reg setupHoldViolation;

    initial
    begin
        QZ_reg=1'bx;
        setupHoldViolation = 1'b0;
    end

    assign mux_qst_op = QSTS ? UQST : QST;

    assign mux_qrt_op = QRTS ? UQRT : QRT;

    always @ (posedge QCK)   
    begin
        if(~mux_qrt_op && ~mux_qst_op )
            if(QEN && CDS)
                QZ_reg = QDI;
    end
        
    always @(QRT or QST)
    begin
        if(mux_qrt_op)
            QZ_reg = 1'b0;
        else if (mux_qst_op)
            QZ_reg = 1'b1;
    end

    assign AQZ = setupHoldViolation ? 1'bx : QZ_reg;

    always @(notifier)
    begin
        setupHoldViolation = 1'b1;
    end

endmodule
