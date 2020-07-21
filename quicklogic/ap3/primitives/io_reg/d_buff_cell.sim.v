
`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module D_BUFF_CELL(DSEL_$inp, F2A_DEF_$out);
    
    (* iopad_external_pin *)
    input wire DSEL_$inp;

    (* iopad_external_pin *)
    output wire F2A_DEF_$out;

    assign F2A_DEF_$out = DSEL_$inp ? 1'b1: 1'b0;

endmodule
