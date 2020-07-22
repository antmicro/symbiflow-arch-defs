`timescale 1ns/10ps

module SQEMUX(QMUXIN, SQHSCK, DYNEN, SEN, DEN, SELECT, IZ);

    input QMUXIN, SQHSCK, DYNEN, SEN, DEN, SELECT;

    (* DELAY_CONST_QMUXIN="{iopath_QMUXIN_IZ}" *)
    (* DELAY_CONST_SQHSCK="{iopath_SQHSCK_IZ}" *)
    (* DELAY_CONST_SELECT="1e-10" *)  // No timing for the select pin
    (* clkbuf_driver *)
    output IZ;

    wire QMUXIN_int, SQHSCK_int, DYNEN_int, SEN_int, DEN_int, SELECT_int;
    buf QMUXIN_buf (QMUXIN_int, QMUXIN) ;
    buf SQHSCK_buf (SQHSCK_int, SQHSCK) ;
    buf DYNEN_buf (DYNEN_int, DYNEN) ;
    buf SEN_buf (SEN_int, SEN) ;
    buf DEN_buf (DEN_int, DEN) ;
    buf SELECT_buf (SELECT_int, SELECT) ;

    specify
            if (SELECT == 1'b0 && SEN == 1'b1 && DEN == 1'b0)
               (QMUXIN => IZ) = (0,0);
            if (SELECT == 1'b1 && SEN == 1'b1 && DEN == 1'b0)
               (SQHSCK => IZ) = (0,0);
       //(DYNEN => IZ) = (0,0);
       //(SEN => IZ) = (0,0);
       //(DEN => IZ) = (0,0);
       //(SELECT => IZ) = (0,0);
    endspecify

    assign IZ = SELECT_int ?  SQHSCK_int : QMUXIN_int;
            
endmodule
