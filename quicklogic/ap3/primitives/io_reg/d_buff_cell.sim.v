
`timescale 1ns/10ps
(* whitebox *)
module D_BUFF_CELL(DSEL_$inp, F2A_DEF_$out);
    input IQC, OSEL_$inp, QRT, OQI_$inp;
    output F2A_$out;

    wire dsel_mux_op;

    assign dsel_mux_op = DSEL_$inp ? 1'b1: 1'b0;

    buf F2A_def_buf1 (F2A_DEF_$out, dsel_mux_op);

endmodule
