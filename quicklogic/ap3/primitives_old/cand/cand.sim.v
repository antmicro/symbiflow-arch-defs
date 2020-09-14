
`timescale 1ns/10ps

module CAND(SEN, CLKIN, IZ);
    input wire SEN, CLKIN;

    (* DELAY_CONST_SEN="1e-10" *)  // No timing for the select pin
    (* clkbuf_driver *)
    output wire IZ;

    wire SEN_int, CLKIN_int;
    buf SEN_buf (SEN_int, SEN) ;
    buf CLKIN_buf (CLKIN_int, CLKIN) ;
    specify
            if (SEN == 1'b1)
               (CLKIN => IZ) = (0,0);
       //(SEN => IZ) = (0,0);
    endspecify
    
    assign IZ = CLKIN_int & SEN_int; 

endmodule 
