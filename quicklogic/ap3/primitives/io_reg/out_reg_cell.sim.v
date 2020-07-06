
`timescale 1ns/10ps
(* whitebox *)
module OUTREG_CELL(IQC, OSEL_$inp, QRT, OQI_$inp, F2A_$out);
    input IQC, OSEL_$inp, QRT, OQI_$inp;
    output F2A_$out;

    wire osel_mux_op;

    reg f2a_reg;

    always @(posedge IQC or posedge QRT)
    begin
        if (QRT)
            f2a_reg <= 1'b0;
        else
            f2a_reg <= OQI_$inp;
    end

    assign osel_mux_op = OSEL_$inp ? OQI_$inp : f2a_reg;

    buf F2F_reg_buf1 (F2A_$out, osel_mux_op);
    
endmodule
