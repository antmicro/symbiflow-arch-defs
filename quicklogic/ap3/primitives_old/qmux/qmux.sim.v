`timescale 1ns/10ps

module QMUX (GMUXIN, QHSCK, IS, IZ);
    
    (* CLOCK, NO_COMB=0 *) 
    input wire GMUXIN;
    
    (* CLOCK, NO_COMB=0 *) 
    input wire QHSCK;
    input wire IS;

    //(* DELAY_CONST_GMUXIN="{iopath_GMUXIN_IZ}" *)
    //(* DELAY_CONST_QHSCK="{iopath_QHSCK_IZ}" *)
    (* DELAY_CONST_GMUXIN="1e-10" *)
    (* DELAY_CONST_QHSCK="1e-10" *)
    (* DELAY_CONST_IS="1e-10" *)  // No timing for the select pin
    (* clkbuf_driver *)
    output wire IZ;

    /*wire GMUXIN_int,  QHSCK_int, IS_int;
    buf GMUXIN_buf (GMUXIN_int, GMUXIN) ;
    buf QHSCK_buf (QHSCK_int, QHSCK) ;
    buf IS_buf (IS_int, IS) ;*/

    specify
            //if (IS == 1'b0)
                    (GMUXIN => IZ) = (0,0);
            //if (IS == 1'b1)
                    (QHSCK => IZ) = (0,0);
       //(IS => IZ) = (0,0);
    endspecify

    assign IZ = IS ? QHSCK : GMUXIN; 

endmodule 
