
`timescale 1ns/10ps
(* whitebox *)
module OUT_BUFF_CELL(OQI_$inp, F2A_$out);
    input OQI_$inp;
    output F2A_$out;

    assign osel_mux_op = OQI_$inp;

    buf F2F_reg_buf1 (F2A_$out, osel_mux_op);

endmodule
