`timescale 1ns/10ps

module GMUX(GCLKIN, GHSCK, SSEL, BL_DEN, BL_DYNEN, BL_SEN, BL_VLP, BR_DEN, 
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
//buf SEN_buf (SEN_int, SEN) ;
//buf DYNEN_buf (DYNEN_int, DYNEN) ;
//buf DEN_buf (DEN_int, DEN) ;
//buf VLP_buf (VLP_int, VLP) ;

assign wire_mux_op_0 = SSEL_int ? GHSCK_int : GCLKIN_int;
//assign wire_mux_op_1 = SEN_int ? 1'b1 : 1'b0;
//assign wire_mux_op_2 = DEN_int ? DYNEN_int : wire_mux_op_1;
//assign wire_mux_op_3 = VLP_int ? 1'b0 : wire_mux_op_2;

assign IZ  = wire_mux_op_0;

specify
	if (SSEL == 1'b0 && TL_SEN == 1'b1 && TR_SEN == 1'b1 && BL_SEN == 1'b1 && BR_SEN == 1'b1 && TL_DEN == 1'b0 && TR_DEN == 1'b0 && BL_DEN == 1'b0 && BR_DEN == 1'b0 && TL_VLP == 1'b0 && TR_VLP == 1'b0 && BL_VLP == 1'b0 && BR_VLP == 1'b0)
	   (GCLKIN => IZ) = (0,0);
	if (SSEL == 1'b1 && TL_SEN == 1'b1 && TR_SEN == 1'b1 && BL_SEN == 1'b1 && BR_SEN == 1'b1 && TL_DEN == 1'b0 && TR_DEN == 1'b0 && BL_DEN == 1'b0 && BR_DEN == 1'b0 && TL_VLP == 1'b0 && TR_VLP == 1'b0 && BL_VLP == 1'b0 && BR_VLP == 1'b0)
	   (GHSCK => IZ) = (0,0);

   //(BL_DEN => IZ) = (0,0);
   //(BL_DYNEN => IZ) = (0,0);
	//(BL_SEN => IZ) = (0,0);   
	//(BL_VLP => IZ) = (0,0); 
	//(BR_DEN => IZ) = (0,0);
	//(BR_SEN => IZ) = (0,0); 
    //(BR_VLP => IZ) = (0,0); 
	//(TL_DEN => IZ) = (0,0); 
	//(TL_SEN => IZ) = (0,0); 
	//(TL_VLP => IZ) = (0,0); 
	//(TR_DEN => IZ) = (0,0); 
	//(TR_SEN => IZ) = (0,0); 
	//(TR_VLP => IZ) = (0,0);
    //(BR_DYNEN => IZ) = (0,0); 
	//(TR_DYNEN => IZ) = (0,0); 
	//(TL_DYNEN => IZ) = (0,0); 
endspecify

endmodule