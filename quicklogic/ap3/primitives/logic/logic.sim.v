`include "./one_logic_cell.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="LOGIC" *)
(* whitebox *)
module LOGIC (
        lFragBitInfo,
        L0I0,
        L0I1,
        L0I2,
        L0I3,
		CD0S,
        Q0EN,
        QST,
		UQST0,
		QST0S,
        QRT,
		UQRT0,
		QRT0S,
        QCK,
		Q0DI,
        L1I0,
        L1I1,
        L1I2,
        L1I3,
		CD1S,
        Q1EN,
        UQST1,
		QST1S,
        UQRT1,
		QRT1S,
        Q1DI,
		L2I0,
        L2I1,
        L2I2,
        L2I3,
		CD2S,
        Q2EN,
        UQST2,
		QST2S,
        UQRT2,
		QRT2S,
        Q2DI,
		L3I0,
        L3I1,
        L3I2,
        L3I3,
		CD3S,
        Q3EN,
        UQST3,
		QST3S,
        UQRT3,
		QRT3S,
        Q3DI,
		L4I0,
        L4I1,
        L4I2,
        L4I3,
		CD4S,
        Q4EN,
        UQST4,
		QST4S,
        UQRT4,
		QRT4S,
        Q4DI,
		L5I0,
        L5I1,
        L5I2,
        L5I3,
		CD5S,
        Q5EN,
        UQST5,
		QST5S,
        UQRT5,
		QRT5S,
        Q5DI,
		L6I0,
        L6I1,
        L6I2,
        L6I3,
		CD6S,
        Q6EN,
        UQST6,
		QST6S,
        UQRT6,
		QRT6S,
        Q6DI,
		L7I0,
        L7I1,
        L7I2,
        L7I3,
		CD7S,
        Q7EN,
        UQST7,
		QST7S,
        UQRT7,
		QRT7S,
        Q7DI,
		F0Z,
        AQ0Z,
        BQ0Z,
        CQ0Z,
		L0CO,
		F1Z,
        AQ1Z,
        BQ1Z,
        CQ1Z,
		L1CO,
		F2Z,
        AQ2Z,
        BQ2Z,
        CQ2Z,
        L2CO,
		F3Z,
        AQ3Z,
        BQ3Z,
        CQ3Z,
		L3CO,
		F4Z,
        AQ4Z,
        BQ4Z,
        CQ4Z,
		L4CO,
		F5Z,
        AQ5Z,
        BQ5Z,
        CQ5Z,
		L5CO,
		F6Z,
        AQ6Z,
        BQ6Z,
        CQ6Z,
		L6CO,
		F7Z,
        AQ7Z,
        BQ7Z,
        CQ7Z,
		L7CO);

    input [127:0] lFragBitInfo;
    input L0I0;
    input L0I1;
    input L0I2;
    input L0I3;
    input CD0S;
    input Q0EN;
    input QST;
    input UQST0;
    input QST0S;
    input QRT;
    input UQRT0;
    input QRT0S;
    input QCK;
    input Q0DI;
    input L1I0;
    input L1I1;
    input L1I2;
    input L1I3;
    input CD1S;
    input Q1EN;
    input UQST1;
    input QST1S;
    input UQRT1;
    input QRT1S;
    input Q1DI;
    input L2I0;
    input L2I1;
    input L2I2;
    input L2I3;
    input CD2S;
    input Q2EN;
    input UQST2;
    input QST2S;
    input UQRT2;
    input QRT2S;
    input Q2DI;
    input L3I0;
    input L3I1;
    input L3I2;
    input L3I3;
    input CD3S;
    input Q3EN;
    input UQST3;
    input QST3S;
    input UQRT3;
    input QRT3S;
    input Q3DI;
    input L4I0;
    input L4I1;
    input L4I2;
    input L4I3;
    input CD4S;
    input Q4EN;
    input UQST4;
    input QST4S;
    input UQRT4;
    input QRT4S;
    input Q4DI;
    input L5I0;
    input L5I1;
    input L5I2;
    input L5I3;
    input CD5S;
    input Q5EN;
    input UQST5;
    input QST5S;
    input UQRT5;
    input QRT5S;
    input Q5DI;
    input L6I0;
    input L6I1;
    input L6I2;
    input L6I3;
    input CD6S;
    input Q6EN;
    input UQST6;
    input QST6S;
    input UQRT6;
    input QRT6S;
    input Q6DI;
    input L7I0;
    input L7I1;
    input L7I2;
    input L7I3;
    input CD7S;
    input Q7EN;
    input UQST7;
    input QST7S;
    input UQRT7;
    input QRT7S;
    input Q7DI;
    output F0Z;
    output AQ0Z;
    output BQ0Z;
    output CQ0Z;
    output L0CO;
    output F1Z;
    output AQ1Z;
    output BQ1Z;
    output CQ1Z;
    output L1CO;
    output F2Z;
    output AQ2Z;
    output BQ2Z;
    output CQ2Z;
    output L2CO;
    output F3Z;
    output AQ3Z;
    output BQ3Z;
    output CQ3Z;
    output L3CO;
    output F4Z;
    output AQ4Z;
    output BQ4Z;
    output CQ4Z;
    output L4CO;
    output F5Z;
    output AQ5Z;
    output BQ5Z;
    output CQ5Z;
    output L5CO;
    output F6Z;
    output AQ6Z;
    output BQ6Z;
    output CQ6Z;
    output L6CO;
    output F7Z;
    output AQ7Z;
    output BQ7Z;
    output CQ7Z;
    output L7CO;


    ONE_LOGIC_CELL logic0(
            .lFragBitInfo (lFragBitInfo[15:0]),
            .LI0 (L0I0),
            .LI1 (L0I1),
            .LI2 (L0I2),
            .LI3 (L0I3),
            .CDS (CD0S),
            .QEN (Q0EN),
            .QST (QST),
            .UQST (UQST0),
            .QSTS (QST0S),
            .QRT (QRT),
            .UQRT (UQRT0),
            .QRTS (QRT0S),
            .QCK (QCK),
            .QDI (Q0DI),
            .FZ (F0Z),
            .AQZ (AQ0Z),
            .BQZ (BQ0Z),
            .CQZ (CQ0Z),
            .LCO (L0CO) );

    ONE_LOGIC_CELL logic1(
            .lFragBitInfo (lFragBitInfo[31:16]),
            .LI0 (L1I0),
            .LI1 (L1I1),
            .LI2 (L1I2),
            .LI3 (L1I3),
            .CDS (CD1S),
            .QEN (Q1EN),
            .QST (QST),
            .UQST (UQST1),
            .QSTS (QST1S),
            .QRT (QRT),
            .UQRT (UQRT1),
            .QRTS (QRT1S),
            .QCK (QCK),
            .QDI (Q1DI),
            .FZ (F1Z),
            .AQZ (AQ1Z),
            .BQZ (BQ1Z),
            .CQZ (CQ1Z),
            .LCO (L1CO) );

    ONE_LOGIC_CELL logic2(
            .lFragBitInfo (lFragBitInfo[47:32]),
            .LI0 (L2I0),
            .LI1 (L2I1),
            .LI2 (L2I2),
            .LI3 (L2I3),
            .CDS (CD2S),
            .QEN (Q2EN),
            .QST (QST),
            .UQST (UQST2),
            .QSTS (QST2S),
            .QRT (QRT),
            .UQRT (UQRT2),
            .QRTS (QRT2S),
            .QCK (QCK),
            .QDI (Q2DI),
            .FZ (F2Z),
            .AQZ (AQ2Z),
            .BQZ (BQ2Z),
            .CQZ (CQ2Z),
            .LCO (L2CO) );

    ONE_LOGIC_CELL logic3(
            .lFragBitInfo (lFragBitInfo[63:48]),
            .LI0 (L3I0),
            .LI1 (L3I1),
            .LI2 (L3I2),
            .LI3 (L3I3),
            .CDS (CD3S),
            .QEN (Q3EN),
            .QST (QST),
            .UQST (UQST3),
            .QSTS (QST3S),
            .QRT (QRT),
            .UQRT (UQRT3),
            .QRTS (QRT3S),
            .QCK (QCK),
            .QDI (Q3DI),
            .FZ (F3Z),
            .AQZ (AQ3Z),
            .BQZ (BQ3Z),
            .CQZ (CQ3Z),
            .LCO (L3CO) );

    ONE_LOGIC_CELL logic4(
            .lFragBitInfo (lFragBitInfo[79:64]),
            .LI0 (L4I0),
            .LI1 (L4I1),
            .LI2 (L4I2),
            .LI3 (L4I3),
            .CDS (CD4S),
            .QEN (Q4EN),
            .QST (QST),
            .UQST (UQST4),
            .QSTS (QST4S),
            .QRT (QRT),
            .UQRT (UQRT4),
            .QRTS (QRT4S),
            .QCK (QCK),
            .QDI (Q4DI),
            .FZ (F4Z),
            .AQZ (AQ4Z),
            .BQZ (BQ4Z),
            .CQZ (CQ4Z),
            .LCO (L4CO) );

    ONE_LOGIC_CELL logic5(
            .lFragBitInfo (lFragBitInfo[95:80]),
            .LI0 (L5I0),
            .LI1 (L5I1),
            .LI2 (L5I2),
            .LI3 (L5I3),
            .CDS (CD5S),
            .QEN (Q5EN),
            .QST (QST),
            .UQST (UQST5),
            .QSTS (QST5S),
            .QRT (QRT),
            .UQRT (UQRT5),
            .QRTS (QRT5S),
            .QCK (QCK),
            .QDI (Q5DI),
            .FZ (F5Z),
            .AQZ (AQ5Z),
            .BQZ (BQ5Z),
            .CQZ (CQ5Z),
            .LCO (L5CO) );

    ONE_LOGIC_CELL logic6(
            .lFragBitInfo (lFragBitInfo[111:96]),
            .LI0 (L6I0),
            .LI1 (L6I1),
            .LI2 (L6I2),
            .LI3 (L6I3),
            .CDS (CD6S),
            .QEN (Q6EN),
            .QST (QST),
            .UQST (UQST6),
            .QSTS (QST6S),
            .QRT (QRT),
            .UQRT (UQRT6),
            .QRTS (QRT6S),
            .QCK (QCK),
            .QDI (Q6DI),
            .FZ (F6Z),
            .AQZ (AQ6Z),
            .BQZ (BQ6Z),
            .CQZ (CQ6Z),
            .LCO (L6CO) );

    ONE_LOGIC_CELL logic7(
            .lFragBitInfo (lFragBitInfo[127:112]),
            .LI0 (L7I0),
            .LI1 (L7I1),
            .LI2 (L7I2),
            .LI3 (L7I3),
            .CDS (CD7S),
            .QEN (Q7EN),
            .QST (QST),
            .UQST (UQST7),
            .QSTS (QST7S),
            .QRT (QRT),
            .UQRT (UQRT7),
            .QRTS (QRT7S),
            .QCK (QCK),
            .QDI (Q7DI),
            .FZ (F7Z),
            .AQZ (AQ7Z),
            .BQZ (BQ7Z),
            .CQZ (CQ7Z),
            .LCO (L7CO) );

    /***Logic Cell Specify Block Data***/

    wire CD0S_EQ_0 = (CD0S == 1'b0);
    wire Q0EN_EQ_1 = (Q0EN == 1'b1);

    wire CD1S_EQ_0 = (CD1S == 1'b0);
    wire Q1EN_EQ_1 = (Q1EN == 1'b1);

    wire CD2S_EQ_0 = (CD2S == 1'b0);
    wire Q2EN_EQ_1 = (Q2EN == 1'b1);

    wire CD3S_EQ_0 = (CD3S == 1'b0);
    wire Q3EN_EQ_1 = (Q3EN == 1'b1);

    wire CD4S_EQ_0 = (CD4S == 1'b0);
    wire Q4EN_EQ_1 = (Q4EN == 1'b1);

    wire CD5S_EQ_0 = (CD5S == 1'b0);
    wire Q5EN_EQ_1 = (Q5EN == 1'b1);

    wire CD6S_EQ_0 = (CD6S == 1'b0);
    wire Q6EN_EQ_1 = (Q6EN == 1'b1);

    wire CD7S_EQ_0 = (CD7S == 1'b0);
    wire Q7EN_EQ_1 = (Q7EN == 1'b1);

    specify
        (L0I0 => L0CO) = (0,0);
        (L0I1 => L0CO) = (0,0);
        (L0I2 => L0CO) = (0,0);

        if (Q0EN == 1'b1)
            (QCK => AQ0Z)  = (0,0);
            (QCK => BQ0Z)  = (0,0);
            (QCK => CQ0Z)  = (0,0);

        (L0I0 => F0Z) = (0,0);
        (L0I1 => F0Z) = (0,0);
        (L0I3 => F0Z) = (0,0);
        (L0I2 => F0Z) = (0,0);

        (L1I0 => L1CO) = (0,0);
        (L1I1 => L1CO) = (0,0);
        (L1I2 => L1CO) = (0,0);

        if (Q1EN == 1'b1)
            (QCK => AQ1Z)  = (0,0);
            (QCK => BQ1Z)  = (0,0);
            (QCK => CQ1Z)  = (0,0);

        (L1I0 => F1Z) = (0,0);
        (L1I1 => F1Z) = (0,0);
        (L1I3 => F1Z) = (0,0);
        (L1I2 => F1Z) = (0,0);

        (L2I0 => L2CO) = (0,0);
        (L2I1 => L2CO) = (0,0);
        (L2I2 => L2CO) = (0,0);

        if (Q2EN == 1'b1)
            (QCK => AQ2Z)  = (0,0);
            (QCK => BQ2Z)  = (0,0);
            (QCK => CQ2Z)  = (0,0);

        (L2I0 => F2Z) = (0,0);
        (L2I1 => F2Z) = (0,0);
        (L2I3 => F2Z) = (0,0);
        (L2I2 => F2Z) = (0,0);

        (L3I0 => L3CO) = (0,0);
        (L3I1 => L3CO) = (0,0);
        (L3I2 => L3CO) = (0,0);

        if (Q3EN == 1'b1)
            (QCK => AQ3Z)  = (0,0);
            (QCK => BQ3Z)  = (0,0);
            (QCK => CQ3Z)  = (0,0);

        (L3I0 => F3Z) = (0,0);
        (L3I1 => F3Z) = (0,0);
        (L3I3 => F3Z) = (0,0);
        (L3I2 => F3Z) = (0,0);

        (L4I0 => L4CO) = (0,0);
        (L4I1 => L4CO) = (0,0);
        (L4I2 => L4CO) = (0,0);

        if (Q4EN == 1'b1)
            (QCK => AQ4Z)  = (0,0);
            (QCK => BQ4Z)  = (0,0);
            (QCK => CQ4Z)  = (0,0);

        (L4I0 => F4Z) = (0,0);
        (L4I1 => F4Z) = (0,0);
        (L4I3 => F4Z) = (0,0);
        (L4I2 => F4Z) = (0,0);

        (L5I0 => L5CO) = (0,0);
        (L5I1 => L5CO) = (0,0);
        (L5I2 => L5CO) = (0,0);

        if (Q5EN == 1'b1)
            (QCK => AQ5Z)  = (0,0);
            (QCK => BQ5Z)  = (0,0);
            (QCK => CQ5Z)  = (0,0);

        (L5I0 => F5Z) = (0,0);
        (L5I1 => F5Z) = (0,0);
        (L5I3 => F5Z) = (0,0);
        (L5I2 => F5Z) = (0,0);

        (L6I0 => L6CO) = (0,0);
        (L6I1 => L6CO) = (0,0);
        (L6I2 => L6CO) = (0,0);

        if (Q6EN == 1'b1)
            (QCK => AQ6Z)  = (0,0);
            (QCK => BQ6Z)  = (0,0);
            (QCK => CQ6Z)  = (0,0);

        (L6I0 => F6Z) = (0,0);
        (L6I1 => F6Z) = (0,0);
        (L6I3 => F6Z) = (0,0);
        (L6I2 => F6Z) = (0,0);

        (L7I0 => L7CO) = (0,0);
        (L7I1 => L7CO) = (0,0);
        (L7I2 => L7CO) = (0,0);

        if (Q7EN == 1'b1)
            (QCK => AQ7Z)  = (0,0);
            (QCK => BQ7Z)  = (0,0);
            (QCK => CQ7Z)  = (0,0);

        (L7I0 => F7Z) = (0,0);
        (L7I1 => F7Z) = (0,0);
        (L7I3 => F7Z) = (0,0);
        (L7I2 => F7Z) = (0,0);
    endspecify


endmodule

