`timescale 1ns/10ps

module QMUX (GMUXIN, QHSCK, IS, IZ);
    input wire GMUXIN, QHSCK, IS;

    (* DELAY_CONST_GMUXIN="{iopath_GMUXIN_IZ}" *)
    (* DELAY_CONST_QHSCK="{iopath_QHSCK_IZ}" *)
    (* DELAY_CONST_IS="1e-10" *)  // No timing for the select pin
    (* clkbuf_driver *)
    output wire IZ;

    wire GMUXIN_int,  QHSCK_int, IS_int;
    buf GMUXIN_buf (GMUXIN_int, GMUXIN) ;
    buf QHSCK_buf (QHSCK_int, QHSCK) ;
    buf IS_buf (IS_int, IS) ;

    assign IZ = IS ? QHSCK_int : GMUXIN_int; 

    specify
            if (IS == 1'b0)
                    (GMUXIN => IZ) = (0,0);
            if (IS == 1'b1)
                    (QHSCK => IZ) = (0,0);
       (IS => IZ) = (0,0);
    endspecify

endmodule 
