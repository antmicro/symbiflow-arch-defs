module top(
    input wire in,
    output wire out
);

reg cnst = 8'b00000001;

(* keep, LOC="GTPE2_COMMON_X0Y0" *)
GTPE2_COMMON #(
            .PLL0_CFG(27'b001011100100001101100001010),
            .PLL0_REFCLK_DIV(5'b10000),
            .PLL0_FBDIV_45(1'b1),
            .PLL0_FBDIV(6'b000010),
            .PLL0_LOCK_CFG(9'b100010110),
            .PLL0_INIT_CFG(24'b110100010100101001101100),
            .RSVD_ATTR0(16'b0100101010100101),
            .PLL1_DMON_CFG(1'b0),
            .PLL0_DMON_CFG(1'b0),
            .COMMON_CFG(32'b10010001111100110111001011011010),
            .PLL_CLKOUT_CFG(8'b11011111),
            .BIAS_CFG(64'b0000110100110111011100001111100100110010001111100001111111111111),
            .RSVD_ATTR1(16'b0010110110111111),
            .PLL1_INIT_CFG(24'b100001100010100010111101),
            .PLL1_LOCK_CFG(9'b001110000),
            .PLL1_REFCLK_DIV(5'b10000),
            .PLL1_FBDIV_45(1'b1),
            .PLL1_FBDIV(6'b000010),
            .PLL1_CFG(27'b111010010111111101110000010),
            .IS_GTGREFCLK1_INVERTED(0),
            .IS_GTGREFCLK0_INVERTED(1),
            .IS_PLL0LOCKDETCLK_INVERTED(1),
            .IS_PLL1LOCKDETCLK_INVERTED(1),
            .IS_DRPCLK_INVERTED(1)
) GTPE2_COMMON_X0Y0 (
	.DRPRDY(out),
        .BGBYPASSB(1'b1),
        .BGMONITORENB(1'b1),
        .BGPDB(1'b1),
        .BGRCALOVRDENB(1'b1),
        .DRPCLK(in),
        .DRPEN(1'b1),
        .DRPWE(1'b1),
        //.GTEASTREFCLK0(in),
        //.GTEASTREFCLK1(in),
        //.GTGREFCLK0(1'b0),
        //.GTGREFCLK1(in),
        //.GTREFCLK0(in), // should be connected to IBUF_GTSE2
        //.GTREFCLK1(1'b0),
        //.GTWESTREFCLK0(in),
        //.GTWESTREFCLK1(in),
        .PLL0LOCKDETCLK(1'b1),
        .PLL0LOCKEN(1'b1),
        .PLL0PD(1'b1),
        .PLL0RESET(1'b1),
        .PLL1LOCKDETCLK(1'b1),
        .PLL1LOCKEN(1'b1),
        .PLL1PD(1'b1),
        .PLL1RESET(1'b1),
        .RCALENB(1'b1),
        .DRPDI(16'b1),
        .PLL0REFCLKSEL(3'b1),
        .PLL1REFCLKSEL(3'b1),
        .BGRCALOVRD(5'b1),
        .DRPADDR(8'b1),
        .PMARSVD(8'b1)
    );
endmodule
