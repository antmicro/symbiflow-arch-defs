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

    INREG_CELL#() _TECHMAP_REPLACE_(
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

    OUTREG_CELL#() _TECHMAP_REPLACE_(
        .IQC(clk), 
        .OSEL_$inp(sel), 
        .QRT(rst), 
        .OQI_$inp(dataIn), 
        .F2A_$out(dataOut));

endmodule


module inv(A , Q);
    input A;
    output Q;

    LOGIC#() _TECHMAP_REPLACE_(
        .lFragBitInfo(128'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx1000000000000000),
        .L0I0(1'b0),
        .L0I1(1'b0),
        .L0I2(1'b0),
        .L0I3(A),
        .CD0S(1'b0),
        .Q0EN(1'b0),
        .QST(1'b0),
        .UQST0(1'b0),
        .QST0S(1'b0),
        .QRT(1'b0),
        .UQRT0(1'b0),
        .QRT0S(1'b0),
        .QCK(1'b0),
        .Q0DI(1'b0),
        .L1I0(1'b0),
        .L1I1(1'b0),
        .L1I2(1'b0),
        .L1I3(1'b0),
        .CD1S(1'b0),
        .Q1EN(1'b0),
        .UQST1(1'b0),
        .QST1S(1'b0),
        .UQRT1(1'b0),
        .QRT1S(1'b0),
        .Q1DI(1'b0),
        .L2I0(1'b0),
        .L2I1(1'b0),
        .L2I2(1'b0),
        .L2I3(1'b0),
        .CD2S(1'b0),
        .Q2EN(1'b0),
        .UQST2(1'b0),
        .QST2S(1'b0),
        .UQRT2(1'b0),
        .QRT2S(1'b0),
        .Q2DI(1'b0),
        .L3I0(1'b0),
        .L3I1(1'b0),
        .L3I2(1'b0),
        .L3I3(1'b0),
        .CD3S(1'b0),
        .Q3EN(1'b0),
        .UQST3(1'b0),
        .QST3S(1'b0),
        .UQRT3(1'b0),
        .QRT3S(1'b0),
        .Q3DI(1'b0),
        .L4I0(1'b0),
        .L4I1(1'b0),
        .L4I2(1'b0),
        .L4I3(1'b0),
        .CD4S(1'b0),
        .Q4EN(1'b0),
        .UQST4(1'b0),
        .QST4S(1'b0),
        .UQRT4(1'b0),
        .QRT4S(1'b0),
        .Q4DI(1'b0),
        .L5I0(1'b0),
        .L5I1(1'b0),
        .L5I2(1'b0),
        .L5I3(1'b0),
        .CD5S(1'b0),
        .Q5EN(1'b0),
        .UQST5(1'b0),
        .QST5S(1'b0),
        .UQRT5(1'b0),
        .QRT5S(1'b0),
        .Q5DI(1'b0),
        .L6I0(1'b0),
        .L6I1(1'b0),
        .L6I2(1'b0),
        .L6I3(1'b0),
        .CD6S(1'b0),
        .Q6EN(1'b0),
        .UQST6(1'b0),
        .QST6S(1'b0),
        .UQRT6(1'b0),
        .QRT6S(1'b0),
        .Q6DI(1'b0),
        .L7I0(1'b0),
        .L7I1(1'b0),
        .L7I2(1'b0),
        .L7I3(1'b0),
        .CD7S(1'b0),
        .Q7EN(1'b0),
        .UQST7(1'b0),
        .QST7S(1'b0),
        .UQRT7(1'b0),
        .QRT7S(1'b0),
        .Q7DI(1'b0),
        .F0Z(Q),
        .AQ0Z(),
        .L0CO(),
        .F1Z(),
        .AQ1Z(),
        .L1CO(),
        .F2Z(),
        .AQ2Z(),
        .L2CO(),
        .F3Z(),
        .AQ3Z(),
        .L3CO(),
        .F4Z(),
        .AQ4Z(),
        .L4CO(),
        .F5Z(),
        .AQ5Z(),
        .L5CO(),
        .F6Z(),
        .AQ6Z(),
        .L6CO(),
        .F7Z(),
        .AQ7Z(),
        .L7CO());

endmodule

module buff(A , Q);
    input A;
    output Q;

    LOGIC#() _TECHMAP_REPLACE_(
        .lFragBitInfo(128'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx0000000010000000),
        .L0I0(1'b0),
        .L0I1(1'b0),
        .L0I2(1'b0),
        .L0I3(A),
        .CD0S(1'b0),
        .Q0EN(1'b0),
        .QST(1'b0),
        .UQST0(1'b0),
        .QST0S(1'b0),
        .QRT(1'b0),
        .UQRT0(1'b0),
        .QRT0S(1'b0),
        .QCK(1'b0),
        .Q0DI(1'b0),
        .L1I0(1'b0),
        .L1I1(1'b0),
        .L1I2(1'b0),
        .L1I3(1'b0),
        .CD1S(1'b0),
        .Q1EN(1'b0),
        .UQST1(1'b0),
        .QST1S(1'b0),
        .UQRT1(1'b0),
        .QRT1S(1'b0),
        .Q1DI(1'b0),
        .L2I0(1'b0),
        .L2I1(1'b0),
        .L2I2(1'b0),
        .L2I3(1'b0),
        .CD2S(1'b0),
        .Q2EN(1'b0),
        .UQST2(1'b0),
        .QST2S(1'b0),
        .UQRT2(1'b0),
        .QRT2S(1'b0),
        .Q2DI(1'b0),
        .L3I0(1'b0),
        .L3I1(1'b0),
        .L3I2(1'b0),
        .L3I3(1'b0),
        .CD3S(1'b0),
        .Q3EN(1'b0),
        .UQST3(1'b0),
        .QST3S(1'b0),
        .UQRT3(1'b0),
        .QRT3S(1'b0),
        .Q3DI(1'b0),
        .L4I0(1'b0),
        .L4I1(1'b0),
        .L4I2(1'b0),
        .L4I3(1'b0),
        .CD4S(1'b0),
        .Q4EN(1'b0),
        .UQST4(1'b0),
        .QST4S(1'b0),
        .UQRT4(1'b0),
        .QRT4S(1'b0),
        .Q4DI(1'b0),
        .L5I0(1'b0),
        .L5I1(1'b0),
        .L5I2(1'b0),
        .L5I3(1'b0),
        .CD5S(1'b0),
        .Q5EN(1'b0),
        .UQST5(1'b0),
        .QST5S(1'b0),
        .UQRT5(1'b0),
        .QRT5S(1'b0),
        .Q5DI(1'b0),
        .L6I0(1'b0),
        .L6I1(1'b0),
        .L6I2(1'b0),
        .L6I3(1'b0),
        .CD6S(1'b0),
        .Q6EN(1'b0),
        .UQST6(1'b0),
        .QST6S(1'b0),
        .UQRT6(1'b0),
        .QRT6S(1'b0),
        .Q6DI(1'b0),
        .L7I0(1'b0),
        .L7I1(1'b0),
        .L7I2(1'b0),
        .L7I3(1'b0),
        .CD7S(1'b0),
        .Q7EN(1'b0),
        .UQST7(1'b0),
        .QST7S(1'b0),
        .UQRT7(1'b0),
        .QRT7S(1'b0),
        .Q7DI(1'b0),
        .F0Z(Q),
        .AQ0Z(),
        .L0CO(),
        .F1Z(),
        .AQ1Z(),
        .L1CO(),
        .F2Z(),
        .AQ2Z(),
        .L2CO(),
        .F3Z(),
        .AQ3Z(),
        .L3CO(),
        .F4Z(),
        .AQ4Z(),
        .L4CO(),
        .F5Z(),
        .AQ5Z(),
        .L5CO(),
        .F6Z(),
        .AQ6Z(),
        .L6CO(),
        .F7Z(),
        .AQ7Z(),
        .L7CO());

endmodule

// ============================================================================
// LOGIC_CELL

module LOGIC_Cell (L0I0, L0I1, L0I2, L0I3, 
                   CD0S, QEN, QST, QRT, QCK, F0Z, AQ0Z);

input L0I0, L0I1, L0I2, L0I3;
input CD0S, QEN, QST, QRT, QCK;				  
output F0Z, AQ0Z;


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


