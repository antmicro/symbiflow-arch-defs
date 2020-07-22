`timescale 1ns/10ps

module QPMUX (QCLKIN, QHSCK, GMUXIN, IS0, IS1, IZ);
    input wire QCLKIN, QHSCK, GMUXIN, IS0, IS1;


    (* DELAY_CONST_GMUXIN="{iopath_GMUXIN_IZ}" *)
    (* DELAY_CONST_QHSCK="{iopath_QHSCK_IZ}" *)
    (* DELAY_CONST_IS0="1e-10" *)  // No timing for the select pin
    (* DELAY_CONST_IS1="1e-10" *)  // No timing for the select pin
    (* clkbuf_driver *)
    output wire IZ;

    wire GMUXIN_int, QCLKIN_int, QHSCK_int, IS_int;
    buf GMUXIN_buf (GMUXIN_int, GMUXIN) ;
    buf QHSCK_buf (QHSCK_int, QHSCK) ;
    buf QCLKIN_buf (QCLKIN_int, QCLKIN) ;
    buf IS0_buf (IS0_int, IS0);
    buf IS1_buf (IS1_int, IS1);

    //assign IZ = IS0 ? (IS1 ? QHSCK_int : QCLKIN_int) : (IS1 ? QHSCK_int : GMUXIN_int); 
    assign IZ = IS0_int ? (IS1_int ? QHSCK_int : GMUXIN_int) : (IS1_int ? QHSCK_int : QCLKIN_int); 

    specify
            if (IS0 == 1'b0 && IS1 == 1'b0)
               (QCLKIN => IZ) = (0,0);
            if (IS0 == 1'b0 && IS1 == 1'b1)
               (QHSCK => IZ) = (0,0);
            if (IS0 == 1'b1 && IS1 == 1'b0)
               (GMUXIN => IZ) = (0,0);
       //(IS0 => IZ) = (0,0);
       //(IS1 => IZ) = (0,0);
    endspecify

endmodule 
