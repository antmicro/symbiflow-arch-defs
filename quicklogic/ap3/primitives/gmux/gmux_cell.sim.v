`include "./gmux_CLK.sim.v"
`include "./gmux_HSCK.sim.v"


(* MODES="CLK;HSCK" *)
module GMUX(GCLKIN, GHSCK, SSEL, BL_DEN, BL_DYNEN, BL_SEN, BL_VLP, BR_DEN, 
            BR_DYNEN, BR_SEN, 
            BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP, IZ);
	input GCLKIN, GHSCK, SSEL, BL_DYNEN, BL_VLP, BR_DEN, BR_DYNEN, BR_SEN, BL_DEN, BL_SEN, 
			BR_VLP, TL_DEN, TL_DYNEN, TL_SEN, TL_VLP, TR_DEN, TR_DYNEN, TR_SEN, TR_VLP; 
	output IZ; 
	wire GCLKIN_int, GHSCK_int, SSEL_int;
	wire wire_mux_op_0;


    parameter MODE = "CLK";

    // Mode for the CLK input connected
    generate if (MODE == "CLK") begin

		GMUX_CLK gmux (
			.GCLKIN(GCLKIN), 
			.GHSCK(GHSCK),
			.SSEL(SSEL),
			.BL_DEN(BL_DEN), 
			.BL_DYNEN(BL_DYNEN), 
			.BL_SEN(BL_SEN),
			.BL_VLP(BL_VLP), 
			.BR_DEN(BR_DEN), 
			.BR_DYNEN(BR_DYNEN), 
			.BR_SEN(BR_SEN), 
			.BR_VLP(BR_VLP),
			.TL_DEN(TL_DEN), 
			.TL_DYNEN(TL_DYNEN), 
			.TL_SEN(TL_SEN),
			.TL_VLP(TL_VLP), 
			.TR_DEN(TR_DEN), 
			.TR_DYNEN(TR_DYNEN), 
			.TR_SEN(TR_SEN), 
			.TR_VLP(TR_VLP),
			.IZ(Q)
		);

    // Mode for the IP input disconnected
    end else if (MODE == "HSCK") begin

		GMUX_HSCK gmux (
			.GCLKIN(GCLKIN), 
			.GHSCK(GHSCK),
			.SSEL(SSEL),
			.BL_DEN(BL_DEN), 
			.BL_DYNEN(BL_DYNEN), 
			.BL_SEN(BL_SEN),
			.BL_VLP(BL_VLP), 
			.BR_DEN(BR_DEN), 
			.BR_DYNEN(BR_DYNEN), 
			.BR_SEN(BR_SEN), 
			.BR_VLP(BR_VLP),
			.TL_DEN(TL_DEN), 
			.TL_DYNEN(TL_DYNEN), 
			.TL_SEN(TL_SEN),
			.TL_VLP(TL_VLP), 
			.TR_DEN(TR_DEN), 
			.TR_DYNEN(TR_DYNEN), 
			.TR_SEN(TR_SEN), 
			.TR_VLP(TR_VLP),
			.IZ(Q)
		);

    end endgenerate

endmodule