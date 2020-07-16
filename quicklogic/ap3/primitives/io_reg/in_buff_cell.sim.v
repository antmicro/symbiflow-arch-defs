
`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module IN_BUFF_CELL(A2F_$inp, IQZ_$out);
    
    (* iopad_external_pin *)
    input wire A2F_$inp;
    
    (* iopad_external_pin *)
    output wire IQZ_$out;

    assign IQZ_$out = A2F_$inp;

endmodule
