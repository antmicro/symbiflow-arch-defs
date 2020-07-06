
`timescale 1ns/10ps
(* whitebox *)
module IN_BUFF_CELL(A2F_$inp, IQZ_$out);
    input A2F_$inp;
    output IQZ_$out;

    wire A2F_reg_int;

    buf b1 (A2F_reg_int, A2F_$inp);

    assign IQZ_$out = A2F_reg_int;

endmodule
