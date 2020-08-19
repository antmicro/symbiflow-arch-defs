`include "./f_frag.sim.v"

(* FASM_FEATURES="LOGIC.LOGIC.Ipwr_gates.J_pwr_st" *)
module FFRAG (F1, F2, FS, FZ);
    input  wire F1;
    input  wire F2;
    input  wire FS;
    output wire FZ;

    // The F-Frag
    F_FRAG f_frag (
    .F1 (F1),
    .F2 (F2),
    .FS (FS),
    .FZ (FZ)
    );

endmodule
