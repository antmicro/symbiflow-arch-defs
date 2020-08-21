(* whitebox *)
(* FASM_FEATURES="" *)
module GMUX_CLK (GCLKIN, SSEL, BL_DEN, BL_DYNEN, BL_SEN, BL_VLP, BR_DEN, 
            BR_DYNEN, BR_SEN, 
            BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP, IZ);

    input wire GCLKIN;

    input wire SSEL; 
    input wire BL_DYNEN;
    input wire BL_VLP;
    input wire BR_DEN;
    input wire BR_DYNEN;
    input wire BR_SEN;
    input wire BL_DEN;
    input wire BL_SEN;
    input wire BR_VLP;
    input wire TL_DEN;
    input wire TL_DYNEN;
    input wire TL_SEN;
    input wire TL_VLP;
    input wire TR_DEN;
    input wire TR_DYNEN;
    input wire TR_SEN;
    input wire TR_VLP;
    
    (* clkbuf_driver *)
    output wire IZ; 

    specify
        //if (SSEL == 1'b0 && TL_SEN == 1'b1 && TR_SEN == 1'b1 && BL_SEN == 1'b1 && BR_SEN == 1'b1 && TL_DEN == 1'b0 && TR_DEN == 1'b0 && BL_DEN == 1'b0 && BR_DEN == 1'b0 && TL_VLP == 1'b0 && TR_VLP == 1'b0 && BL_VLP == 1'b0 && BR_VLP == 1'b0)
            (GCLKIN => IZ) = (0,0);
    endspecify

    assign IZ = GCLKIN;

endmodule
