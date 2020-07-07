`timescale 1ns/10ps
(* whitebox *)
module IN_REG_CELL(IQC, ISEL_$inp, FIXHOLD_$inp, QRT, A2F_$inp, IQZ_$out);
    input IQC, ISEL_$inp, FIXHOLD_$inp, QRT, A2F_$inp;
    output IQZ_$out;

    wire A2F_reg_int, A2F_reg_int_buff;
    wire fixhold_mux_op;

    reg iqz_reg;

    buf b1 (A2F_reg_int, A2F_$inp);
    
    buf A2F_reg_buf1 (A2F_reg_int_buff, A2F_reg_int);

    assign fixhold_mux_op = FIXHOLD_$inp ? A2F_reg_int_buff[0] : A2F_reg_int[0];

    always @(posedge IQC or posedge QRT)
    begin
        if (QRT)
            iqz_reg <= 1'b0;
        else
            iqz_reg <= fixhold_mux_op; 
    end

    assign IQZ_$out = ISEL_$inp ? A2F_reg_int : iqz_reg;

endmodule
