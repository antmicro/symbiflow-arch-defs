// ============================================================================
// Constant sources

// Reduce logic_0 and logic_1 cells to 1'b0 and 1'b1. Const sources suitable
// for VPR will be added by Yosys during EBLIF write.
module logic_0(output a);
    assign a = 0;
endmodule

module logic_1(output a);
    assign a = 1;
endmodule


// ============================================================================

// IO

module in_buff(A , Q);
    input A;
    output Q;

    IN_BUFF_CELL #() _TECHMAP_REPLACE_(
        .A2F_$inp(A), 
        .IQZ_$out(Q)
        );

endmodule


module out_buff(A , Q);
    input A;
    output Q;

    OUT_BUFF_CELL#() _TECHMAP_REPLACE_(
        .OQI_$inp(A), 
        .F2A_$out(Q)));

endmodule

module d_buff (A,Q);
    input A;
    output Q;
    
    D_BUFF_CELL#() _TECHMAP_REPLACE_(
        .DSEL_$inp(A), 
        .F2A_DEF_$out(Q));

endmodule


module  in_reg(clk, sel, hold, rst, dataIn, dataOut);

    input clk, sel, hold, rst, dataIn;
    output dataOut;

    IN_REG_CELL#() _TECHMAP_REPLACE_(
        .IQC(clk), 
        .ISEL_$inp(sel), 
        .FIXHOLD_$inp(hold), 
        .QRT(rst), 
        .A2F_$inp(dataIn), 
        .IQZ_$out(dataOut));

endmodule

module  out_reg(clk, sel, rst, dataIn, dataOut);

    input clk, sel, rst, dataIn;
    output dataOut;

    OUT_REG_CELL#() _TECHMAP_REPLACE_(
        .IQC(clk), 
        .OSEL_$inp(sel), 
        .QRT(rst), 
        .OQI_$inp(dataIn), 
        .F2A_$out(dataOut));

endmodule

module inpad_ff (P, FFCLR, FFCLK, Q);
    input P, FFCLR, FFCLK;
    output Q; 

    IN_REG_CELL#() _TECHMAP_REPLACE_(
        .IQC(FFCLK), 
        .ISEL_$inp(1'b0), 
        .FIXHOLD_$inp(1'b0), 
        .QRT(FFCLR), 
        .A2F_$inp(P), 
        .IQZ_$out(Q));

endmodule

module outpad_ff (A, FFCLR, FFCLK, P);
    input A, FFCLR, FFCLK;
    output P; 

    OUT_REG_CELL#() _TECHMAP_REPLACE_(
        .IQC(FFCLK), 
        .OSEL_$inp(1'b0), 
        .QRT(FFCLR), 
        .OQI_$inp(A), 
        .F2A_$out(P));

endmodule


// ============================================================================
// LOGIC

module inv(A , Q);
    input A;
    output Q;

    L_FRAG#() _TECHMAP_REPLACE_(
        .lFragBitInfo(16'b1000000000000000),
        .I0(1'b0),
        .I1(1'b0),
        .I2(1'b0),
        .I3(A),
        .LUTOutput(Q),
        .CarryOut());

endmodule

module buff(A , Q);
    input A;
    output Q;

    L_FRAG#() _TECHMAP_REPLACE_(
        .lFragBitInfo(16'b0000000010000000),
        .I0(1'b0),
        .I1(1'b0),
        .I2(1'b0),
        .I3(A),
        .LUTOutput(Q),
        .CarryOut());

endmodule

module carry_out(CI, CO);
    input CI;
    output CO;

    L_FRAG#() _TECHMAP_REPLACE_(
        .lFragBitInfo(16'b0000100000000000),
        .I0(1'b0),
        .I1(1'b0),
        .I2(C1),
        .I3(1'b0),
        .LUTOutput(CO),
        .CarryOut(CO));

endmodule

module full_adder(A, B, CI, L1CI, S, CO);
    input A, B, CI, L1CI;
    output S, CO;

    L_FRAG l_frag_0(
        .lFragBitInfo(16'b0110100110001110),
        .I0(A),
        .I1(B),
        .I2(C1),
        .I3(1'b0),
        .LUTOutput(S),
        .CarryOut());
    )

    L_FRAG l_frag_1(
        .lFragBitInfo(16'b0000100000000000),
        .I0(1'b0),
        .I1(1'b0),
        .I2(L1CI),
        .I3(1'b0),
        .LUTOutput(CO),
        .CarryOut());
    )

endmodule

module LOGIC_Cell (
            LI0,
            LI1,
            LI2, 
            LI3,
            CDS,
            QEN,
            QST,
            QRT,
            QCK,
            FZ,
            AQZ);
    
    input LI0, LI1, LI2, LI3, CDS, QEN, QST, QRT, QCK;

    output  FZ, AQZ;

    reg notifier;

    wire [15:0] INIT = 0;
    ONE_LOGIC_CELL #() _TECHMAP_REPLACE_(
            .lFragBitInfo (INIT),
            .LI0 (LI0),
            .LI1 (LI1),
            .LI2 (LI2), 
            .LI3 (LI3),
            .CDS (CDS),
            .QEN (QEN),
            .QST (QST),
            .UQST (QST),
            .QSTS (1'b0),
            .QRT (QRT),
            .UQRT (QRT),
            .QRTS (1'b0),
            .QCK (QCK),
            .QDI (LI3),
            .notifier (notifier),
            .FZ (FZ),
            .AQZ (AQZ),
            .LCO () ); 

endmodule

module LUT4 (
    output O,
    input  I0,
    input  I1,
    input  I2,
    input  I3
    );

    wire [15:0] INIT = 0;

    L_FRAG #() _TECHMAP_REPLACE_(
            .fragBitInfo(INIT), 
            .I0(I0), 
            .I1(I1), 
            .I2(I2), 
            .I3(I3), 
            .LUTOutput(O),
            .CarryOut());

endmodule

module lqfrag_macro_0 (
            LI0,
            LI1,
            LI2, 
            LI3,
            QEN,
            QST,
            QRT,
            QCK,
            FZ,
            AQZ
);

    input LI0, LI1, LI2, LI3, QEN, QST, QRT, QCK;

    output  FZ, AQZ;

    reg notifier;

    wire [15:0] INIT = 0;
    ONE_LOGIC_CELL #() _TECHMAP_REPLACE_(
            .lFragBitInfo (INIT),
            .LI0 (LI0),
            .LI1 (LI1),
            .LI2 (LI2), 
            .LI3 (LI3),
            .CDS (1'b0),
            .QEN (QEN),
            .QST (QST),
            .UQST (QST),
            .QSTS (1'b0),
            .QRT (QRT),
            .UQRT (QRT),
            .QRTS (1'b0),
            .QCK (QCK),
            .QDI (LI3),
            .notifier (notifier),
            .FZ (FZ),
            .AQZ (AQZ),
            .LCO () ); 

endmodule

module lqfrag_macro_1 (
            LI0,
            LI1,
            LI2, 
            LI3,
            QDI,
            QEN,
            QST,
            QRT,
            QCK,
            FZ,
            AQZ
);

    input LI0, LI1, LI2, LI3, QDI, QEN, QST, QRT, QCK;

    output  FZ, AQZ;

    reg notifier;

    wire [15:0] INIT = 0;
    ONE_LOGIC_CELL #() _TECHMAP_REPLACE_(
            .lFragBitInfo (INIT),
            .LI0 (LI0),
            .LI1 (LI1),
            .LI2 (LI2), 
            .LI3 (LI3),
            .QDI (QDI)
            .CDS (1'b1),
            .QEN (QEN),
            .QST (QST),
            .UQST (QST),
            .QSTS (1'b0),
            .QRT (QRT),
            .UQRT (QRT),
            .QRTS (1'b0),
            .QCK (QCK),
            .notifier (notifier),
            .FZ (FZ),
            .AQZ (AQZ),
            .LCO () ); 

endmodule

module ff (
        D,
        QCK,
        QEN,
        QST,
        QRT,
        CQZ
        );

    input D, QCK, QEN, QST, QRT;
    output CQZ;    

    reg notifier;

    Q_FRAG #() _TECHMAP_REPLACE_(
        .QDI(D), 
        .QEN(QEN), 
        .QST(QST), 
        .UQST(QST), 
        .QSTS(1'b0), 
        .QRT(QRT), 
        .UQRT(QRT), 
        .QRTS(1'b0), 
        .CDS(1'b1), 
        .notifier(notifier), 
        .AQZ(CQZ));

endmodule

// ============================================================================
// CLOCK cells

module ckpad(output Q, input P);

  parameter IO_PAD  = "";
  parameter IO_LOC  = "";
  parameter IO_TYPE = "";

  // If the IO_TYPE is not set or it is set to CLOCK map the ckpad to a CLOCK
  // cell.
  generate if (IO_TYPE == "" || IO_TYPE == "CLOCK") begin

      // In VPR GMUX has to be explicitly present in the netlist. Add it here.

      wire C;

      CLOCK clock (
      .IP(P),
      .IC(C),
      .CEN(1'b1)
      );

      GMUX_CLK gmux (
        .GCLKIN(C), 
        .GHSCK(1'b0),
        .SSEL(1'b0),
        .BL_DEN(1'b0), 
        .BL_DYNEN(1'b0), 
        .BL_SEN(1'b1),
        .BL_VLP(1'b0), 
        .BR_DEN(1'b0), 
        .BR_DYNEN(1'b0), 
        .BR_SEN(1'b1), 
        .BR_VLP(1'b0),
        .TL_DEN(1'b0), 
        .TL_DYNEN(1'b0), 
        .TL_SEN(1'b1),
        .TL_VLP(1'b0), 
        .TR_DEN(1'b0), 
        .TR_DYNEN(1'b0), 
        .TR_SEN(1'b1), 
        .TR_VLP(1'b0),
        .IZ(Q)
      );

    // TODO: clock pad source can directly be connected to QMUX as well. Need to 
    // handle that case later.

  end else begin
    // Otherwise make it an inpad cell that gets mapped to IO_REG

      in_buff #(
      .IO_PAD(IO_PAD),
      .IO_LOC(IO_LOC),
      .IO_TYPE(IO_TYPE)
      ) _TECHMAP_REPLACE_ (
      .Q(Q),
      .P(P)
      );

  end endgenerate

endmodule

module GCLKBUFF ( A , Z );
    input A;
    output Z;
    
    SQMUX#() _TECHMAP_REPLACE_(
        .SQHSCK(A), 
        .SELECT(1'b1), 
        .QMUXIN(1'b0), 
        .IZ(Z));

endmodule

module ck_buff ( A , Z );
    input A;
    output Z;

    CLOCK#() _TECHMAP_REPLACE_(
        .IP(A), 
        .IC(Q), 
        .CEN(1'b1), 
        .OP());

endmodule


