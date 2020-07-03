
`timescale 1ns/10ps
module IO_REG (
		IQC,
		QRT,
		ISEL_0_,
	    ISEL_1_,
		ISEL_2_,
		ISEL_3_,
		ISEL_4_,
		ISEL_5_,
		ISEL_6_,
		ISEL_7_,
		OSEL_0_,
		OSEL_1_,
		OSEL_2_,
		OSEL_3_,
		OSEL_4_,
		OSEL_5_,
		OSEL_6_,
		OSEL_7_,
		OSEL_8_,
		OSEL_9_,
		OSEL_10_,
		OSEL_11_,
		OSEL_12_,
		OSEL_13_,
		OSEL_14_,
		OSEL_15_,
		OSEL_16_,
		OSEL_17_,
		DSEL_0_,
		DSEL_1_,
		DSEL_2_,
		DSEL_3_,
		FIXHOLD_0_,
		FIXHOLD_1_,
		FIXHOLD_2_,
		FIXHOLD_3_,
		FIXHOLD_4_,
		FIXHOLD_5_,
		FIXHOLD_6_,
		FIXHOLD_7_,
		A2F_0_,
		A2F_1_,
		A2F_2_,
		A2F_3_,
		A2F_4_,
		A2F_5_,
		A2F_6_,
		A2F_7_,
		OQI_0_,
		OQI_1_,
		OQI_2_,
		OQI_3_,
		OQI_4_,
		OQI_5_,
		OQI_6_,
		OQI_7_,
		OQI_8_,
		OQI_9_,
		OQI_10_,
		OQI_11_,
		OQI_12_,
		OQI_13_,
		OQI_14_,
		OQI_15_,
		OQI_16_,
		OQI_17_,
		IQZ_0_,
		IQZ_1_,
		IQZ_2_,
		IQZ_3_,
		IQZ_4_,
		IQZ_5_,
		IQZ_6_,
		IQZ_7_,
		F2A_0_,
		F2A_1_,
		F2A_2_,
		F2A_3_,
		F2A_4_,
		F2A_5_,
		F2A_6_,
		F2A_7_,
		F2A_8_,
		F2A_9_,
		F2A_10_,
		F2A_11_,
		F2A_12_,
		F2A_13_,
		F2A_14_,
		F2A_15_,
		F2A_16_,
		F2A_17_,
		F2A_DEF_0_,
        F2A_DEF_1_,
        F2A_DEF_2_,
        F2A_DEF_3_);

input IQC;
input QRT;
input ISEL_0_;
input ISEL_1_;
input ISEL_2_;
input ISEL_3_;
input ISEL_4_;
input ISEL_5_;
input ISEL_6_;
input ISEL_7_;
input OSEL_0_;
input OSEL_1_;
input OSEL_2_;
input OSEL_3_;
input OSEL_4_;
input OSEL_5_;
input OSEL_6_;
input OSEL_7_;
input OSEL_8_;
input OSEL_9_;
input OSEL_10_;
input OSEL_11_;
input OSEL_12_;
input OSEL_13_;
input OSEL_14_;
input OSEL_15_;
input OSEL_16_;
input OSEL_17_;
input DSEL_0_;
input DSEL_1_;
input DSEL_2_;
input DSEL_3_;
input FIXHOLD_0_;
input FIXHOLD_1_;
input FIXHOLD_2_;
input FIXHOLD_3_;
input FIXHOLD_4_;
input FIXHOLD_5_;
input FIXHOLD_6_;
input FIXHOLD_7_;
input A2F_0_;
input A2F_1_;
input A2F_2_;
input A2F_3_;
input A2F_4_;
input A2F_5_;
input A2F_6_;
input A2F_7_;
input OQI_0_;
input OQI_1_;
input OQI_2_;
input OQI_3_;
input OQI_4_;
input OQI_5_;
input OQI_6_;
input OQI_7_;
input OQI_8_;
input OQI_9_;
input OQI_10_;
input OQI_11_;
input OQI_12_;
input OQI_13_;
input OQI_14_;
input OQI_15_;
input OQI_16_;
input OQI_17_;
output IQZ_0_;
output IQZ_1_;
output IQZ_2_;
output IQZ_3_;
output IQZ_4_;
output IQZ_5_;
output IQZ_6_;
output IQZ_7_;
output F2A_0_;
output F2A_1_;
output F2A_2_;
output F2A_3_;
output F2A_4_;
output F2A_5_;
output F2A_6_;
output F2A_7_;
output F2A_8_;
output F2A_9_;
output F2A_10_;
output F2A_11_;
output F2A_12_;
output F2A_13_;
output F2A_14_;
output F2A_15_;
output F2A_16_;
output F2A_17_;
output F2A_DEF_0_;
output F2A_DEF_1_;
output F2A_DEF_2_;
output F2A_DEF_3_;

wire [7:0] A2F_reg_int, A2F_reg_int_buff;
wire [7:0] fixhold_mux_op;
wire [17:0] osel_mux_op;
wire [3:0] dsel_mux_op;

reg [7:0] iqz_reg;
reg [17:0] f2a_reg;

buf b1 (A2F_reg_int[0], A2F_0_);
buf b2 (A2F_reg_int[1], A2F_1_);
buf b3 (A2F_reg_int[2], A2F_2_);
buf b4 (A2F_reg_int[3], A2F_3_);
buf b5 (A2F_reg_int[4], A2F_4_);
buf b6 (A2F_reg_int[5], A2F_5_);
buf b7 (A2F_reg_int[6], A2F_6_);
buf b8 (A2F_reg_int[7], A2F_7_);

genvar i;
generate for (i = 0; i < 8; i = i + 1) 
   begin
      buf A2F_reg_buf1 (A2F_reg_int_buff[i], A2F_reg_int[i]);
   end 
endgenerate 


assign fixhold_mux_op[0] = FIXHOLD_0_ ? A2F_reg_int_buff[0] : A2F_reg_int[0];
assign fixhold_mux_op[1] = FIXHOLD_1_ ? A2F_reg_int_buff[1] : A2F_reg_int[1];
assign fixhold_mux_op[2] = FIXHOLD_2_ ? A2F_reg_int_buff[2] : A2F_reg_int[2];
assign fixhold_mux_op[3] = FIXHOLD_3_ ? A2F_reg_int_buff[3] : A2F_reg_int[3];
assign fixhold_mux_op[4] = FIXHOLD_4_ ? A2F_reg_int_buff[4] : A2F_reg_int[4];
assign fixhold_mux_op[5] = FIXHOLD_5_ ? A2F_reg_int_buff[5] : A2F_reg_int[5];
assign fixhold_mux_op[6] = FIXHOLD_6_ ? A2F_reg_int_buff[6] : A2F_reg_int[6];
assign fixhold_mux_op[7] = FIXHOLD_7_ ? A2F_reg_int_buff[7] : A2F_reg_int[7];



initial
  begin 
    iqz_reg = 8'b00000000;
    f2a_reg = 18'b000000000000000000;
  end

always @(posedge IQC or posedge QRT)
  begin
   if (QRT)
     iqz_reg <= 8'b00000000;
   else
     iqz_reg <= fixhold_mux_op; 
  end


assign IQZ_0_ = ISEL_0_ ? A2F_reg_int[0] : iqz_reg[0];
assign IQZ_1_ = ISEL_1_ ? A2F_reg_int[1] : iqz_reg[1];
assign IQZ_2_ = ISEL_2_ ? A2F_reg_int[2] : iqz_reg[2];
assign IQZ_3_ = ISEL_3_ ? A2F_reg_int[3] : iqz_reg[3];
assign IQZ_4_ = ISEL_4_ ? A2F_reg_int[4] : iqz_reg[4];
assign IQZ_5_ = ISEL_5_ ? A2F_reg_int[5] : iqz_reg[5];
assign IQZ_6_ = ISEL_6_ ? A2F_reg_int[6] : iqz_reg[6];
assign IQZ_7_ = ISEL_7_ ? A2F_reg_int[7] : iqz_reg[7];

always @(posedge IQC or posedge QRT)
  begin
    if (QRT)
      f2a_reg <= 18'b000000000000000000;
    else
            f2a_reg <= ({OQI_17_,OQI_16_,OQI_15_,OQI_14_,OQI_13_,OQI_12_,OQI_11_,OQI_10_,OQI_9_,OQI_8_,OQI_7_,OQI_6_,OQI_5_,OQI_4_,OQI_3_,OQI_2_,OQI_1_,OQI_0_});
  end


assign osel_mux_op[0] = OSEL_0_ ? OQI_0_ : f2a_reg[0];
assign osel_mux_op[1] = OSEL_1_ ? OQI_1_ : f2a_reg[1];
assign osel_mux_op[2] = OSEL_2_ ? OQI_2_ : f2a_reg[2];
assign osel_mux_op[3] = OSEL_3_ ? OQI_3_ : f2a_reg[3];
assign osel_mux_op[4] = OSEL_4_ ? OQI_4_ : f2a_reg[4];
assign osel_mux_op[5] = OSEL_5_ ? OQI_5_ : f2a_reg[5];
assign osel_mux_op[6] = OSEL_6_ ? OQI_6_ : f2a_reg[6];
assign osel_mux_op[7] = OSEL_7_ ? OQI_7_ : f2a_reg[7];
assign osel_mux_op[8] = OSEL_8_ ? OQI_8_ : f2a_reg[8];
assign osel_mux_op[9] = OSEL_9_ ? OQI_9_ : f2a_reg[9];
assign osel_mux_op[10] = OSEL_10_ ? OQI_10_ : f2a_reg[10];
assign osel_mux_op[11] = OSEL_11_ ? OQI_11_ : f2a_reg[11];
assign osel_mux_op[12] = OSEL_12_ ? OQI_12_ : f2a_reg[12];
assign osel_mux_op[13] = OSEL_13_ ? OQI_13_ : f2a_reg[13];
assign osel_mux_op[14] = OSEL_14_ ? OQI_14_ : f2a_reg[14];
assign osel_mux_op[15] = OSEL_15_ ? OQI_15_ : f2a_reg[15];
assign osel_mux_op[16] = OSEL_16_ ? OQI_16_ : f2a_reg[16];
assign osel_mux_op[17] = OSEL_17_ ? OQI_17_ : f2a_reg[17];

buf F2F_reg_buf1 (F2A_0_, osel_mux_op[0]);
buf F2F_reg_buf2 (F2A_1_, osel_mux_op[1]);
buf F2F_reg_buf3 (F2A_2_, osel_mux_op[2]);
buf F2F_reg_buf4 (F2A_3_, osel_mux_op[3]);
buf F2F_reg_buf5 (F2A_4_, osel_mux_op[4]);
buf F2F_reg_buf6 (F2A_5_, osel_mux_op[5]);
buf F2F_reg_buf7 (F2A_6_, osel_mux_op[6]);
buf F2F_reg_buf8 (F2A_7_, osel_mux_op[7]);
buf F2F_reg_buf9 (F2A_8_, osel_mux_op[8]);
buf F2F_reg_buf10 (F2A_9_, osel_mux_op[9]);
buf F2F_reg_buf11 (F2A_10_, osel_mux_op[10]);
buf F2F_reg_buf12 (F2A_11_, osel_mux_op[11]);
buf F2F_reg_buf13 (F2A_12_, osel_mux_op[12]);
buf F2F_reg_buf14 (F2A_13_, osel_mux_op[13]);
buf F2F_reg_buf15 (F2A_14_, osel_mux_op[14]);
buf F2F_reg_buf16 (F2A_15_, osel_mux_op[15]);
buf F2F_reg_buf17 (F2A_16_, osel_mux_op[16]);
buf F2F_reg_buf18 (F2A_17_, osel_mux_op[17]);



assign dsel_mux_op[0] = DSEL_0_ ? 1'b1: 1'b0;
assign dsel_mux_op[1] = DSEL_1_ ? 1'b1: 1'b0;
assign dsel_mux_op[2] = DSEL_2_ ? 1'b1: 1'b0;
assign dsel_mux_op[3] = DSEL_3_ ? 1'b1: 1'b0;

buf F2A_def_buf1 (F2A_DEF_0_, dsel_mux_op[0]);
buf F2A_def_buf2 (F2A_DEF_1_, dsel_mux_op[1]);
buf F2A_def_buf3 (F2A_DEF_2_, dsel_mux_op[2]);
buf F2A_def_buf4 (F2A_DEF_3_, dsel_mux_op[3]); 


endmodule 