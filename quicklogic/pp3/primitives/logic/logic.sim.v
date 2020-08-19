`include "./c_frag_modes.sim.v"
`include "./q_frag.sim.v"

(* FASM_FEATURES="LOGIC.LOGIC.Ipwr_gates.J_pwr_st" *)
module LOGIC (QST, QDS, TBS, TAB, TSL, TA1, TA2, TB1, TB2, BAB, BSL, BA1, BA2, BB1, BB2, QDI, QEN, QCK, QRT, TZ, CZ, QZ);
    input wire QST;
    input wire QDS;
    input wire TBS;
    input wire TAB;
    input wire TSL;
    input wire TA1;
    input wire TA2;
    input wire TB1;
    input wire TB2;
    input wire BAB;
    input wire BSL;
    input wire BA1;
    input wire BA2;
    input wire BB1;
    input wire BB2;
    input wire QDI;
    input wire QEN;
    input wire QCK;
    input wire QRT;
    output wire TZ;
    output wire CZ;
    output wire QZ;

    // The C-Frag (with modes)
    (* FASM_PREFIX="LOGIC.LOGIC" *)
    C_FRAG_MODES c_frag_modes (
    .TBS(TBS),
    .TAB(TAB),
    .TSL(TSL),
    .TA1(TA1),
    .TA2(TA2),
    .TB1(TB1),
    .TB2(TB2),
    .BAB(BAB),
    .BSL(BSL),
    .BA1(BA1),
    .BA2(BA2),
    .BB1(BB1),
    .BB2(BB2),
    .TZ (TZ),
    .CZ (CZ)
    );

    // The Q-Frag
    (* FASM_PREFIX="LOGIC.LOGIC" *)
    Q_FRAG q_frag (
    .QCK(QCK),
    .QST(QST),
    .QRT(QRT),
    .QEN(QEN),
    .QDI(QDI),
    .QDS(QDS),
    .CZI(), // Deliberately disconnected as here the Q_FRAG always has to use the QDI input
    .QZ (QZ)
    );

endmodule
