(* whitebox *)
(* FASM_FEATURES="" *)
module GMUX_CLK (GCLKIN, GHSCK, SSEL, BL_DEN, BL_DYNEN, BL_SEN, BL_VLP, BR_DEN, 
            BR_DYNEN, BR_SEN, 
            BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP, IZ);

    input wire GCLKIN, GHSCK, SSEL, BL_DYNEN, BL_VLP, BR_DEN, BR_DYNEN, BR_SEN, BL_DEN, BL_SEN, 
            BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP; 
    
    (* DELAY_CONST_GCLKIN="{iopath_GCLKINN_IZ}" *)
    (* DELAY_CONST_GHSCK="{iopath_GHSCK_IZ}" *)
    (* DELAY_CONST_SSEL="1e-10" *)  // No timing for the select pin
    (* clkbuf_driver *)
    output wire IZ; 

    assign IZ = SSEL ? GHSCK : GCLKIN;

    specify
        if (SSEL == 1'b0 && TL_SEN == 1'b1 && TR_SEN == 1'b1 && BL_SEN == 1'b1 && BR_SEN == 1'b1 && TL_DEN == 1'b0 && TR_DEN == 1'b0 && BL_DEN == 1'b0 && BR_DEN == 1'b0 && TL_VLP == 1'b0 && TR_VLP == 1'b0 && BL_VLP == 1'b0 && BR_VLP == 1'b0)
            (GCLKIN => IZ) = (0,0);
    endspecify

endmodule
