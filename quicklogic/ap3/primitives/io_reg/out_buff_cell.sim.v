
`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module OUT_BUFF_CELL(OQI_$inp, F2A_$out);
    (* iopad_external_pin *)
    input wire OQI_$inp;
    
    (* iopad_external_pin *)
    output wire F2A_$out;

    assign F2A_$out = OQI_$inp;

endmodule
