(* whitebox *)
(* FASM_FEATURES="" *)
module GMUX_HSCK (GCLKIN, GHSCK, SSEL, BL_DEN, BL_DYNEN, BL_SEN, BL_VLP, BR_DEN, 
            BR_DYNEN, BR_SEN, 
            BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP, IZ);

    input GCLKIN, GHSCK, SSEL, BL_DYNEN, BL_VLP, BR_DEN, BR_DYNEN, BR_SEN, BL_DEN, BL_SEN, 
            BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP; 
    output IZ; 
    wire GCLKIN_int, GHSCK_int, SSEL_int;
    wire wire_mux_op_0;

    buf GCLKIN_buf (GCLKIN_int, GCLKIN) ;
    buf GHSCK_buf (GHSCK_int, GHSCK) ;
    buf SSEL_buf (SSEL_int, SSEL) ;

    assign wire_mux_op_0 = SSEL_int ? GHSCK_int : GCLKIN_int;
    assign IZ  = wire_mux_op_0;

    (* clkbuf_driver *)
    output wire IZ;

    specify
        if (SSEL == 1'b1 && TL_SEN == 1'b1 && TR_SEN == 1'b1 && BL_SEN == 1'b1 && BR_SEN == 1'b1 && TL_DEN == 1'b0 && TR_DEN == 1'b0 && BL_DEN == 1'b0 && BR_DEN == 1'b0 && TL_VLP == 1'b0 && TR_VLP == 1'b0 && BL_VLP == 1'b0 && BR_VLP == 1'b0)
            (GHSCK => IZ) = (0,0);
    endspecify

endmodule
