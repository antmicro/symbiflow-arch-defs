
`timescale 1ns/10ps

module CAND(SEN, CLKIN, IZ);
input SEN, CLKIN;
output IZ;
wire SEN_int, CLKIN_int;
buf SEN_buf (SEN_int, SEN) ;
buf CLKIN_buf (CLKIN_int, CLKIN) ;
assign IZ = CLKIN_int & SEN_int; 

specify
	if (SEN == 1'b1)
	   (CLKIN => IZ) = (0,0);
   //(SEN => IZ) = (0,0);
endspecify
endmodule 
