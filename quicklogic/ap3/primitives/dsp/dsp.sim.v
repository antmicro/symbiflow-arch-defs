
(* blackbox *)
module DSP (MODE_SEL,COEF_DATA,OPER_DATA,OUT_SEL,ENABLE,CLR,RND,SAT,CLOCK,MAC_OUT,CSEL,OSEL,SBOG)/* synthesis black_box */;

input [1:0] MODE_SEL,OUT_SEL;
input [1:0] CSEL;
input [1:0] OSEL;
input [31:0] COEF_DATA,OPER_DATA;
input ENABLE,CLR,RND,SAT,CLOCK;
input [1:0]SBOG;
output [63:0] MAC_OUT;


dsp_top U1 (
	       .oper(OPER_DATA), .coef(COEF_DATA),
	       .outsel(OUT_SEL),
	       .mode(MODE),
	       .clk(CLOCK), .clr(CLR), .ena(ENABLE),
	       .fld(32'h0), .frd(32'h0), .sbog(SBOG),
	       .rnd(RND), .sat(SAT),
	       .o_sel(OSEL), .c_sel(CSEL),
	       .mac_out(MAC_OUT),
	       .tld(), .trd(),
	       .DFT_SCAN_CLK_DAISYIN(1'b0),
	       .DFT_SCAN_RST_DAISYIN(1'b0),
	       .DFT_SCAN_MODE_DAISYIN(1'b0),
	       .DFT_SCAN_EN_DAISYIN(1'b0),
	       .DFT_SCAN_IN_DAISYIN(1'b0),
	       .dft_FFB_scan_out()
	       );
endmodule 
