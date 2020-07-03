
`timescale 1ns/10ps

module SQMUX(QMUXIN, SQHSCK, SELECT, IZ);
input QMUXIN, SQHSCK,SELECT;
output IZ;

wire QMUXIN_int, SQHSCK_int, SELECT_int;

buf QMUXIN_buf (QMUXIN_int, QMUXIN) ;
buf SQHSCK_buf (SQHSCK_int, SQHSCK) ;
buf SELECT_buf (SELECT_int, SELECT) ;

assign IZ = SELECT_int ?  SQHSCK_int : QMUXIN_int;
specify
	if (SELECT == 1'b0)
   		(QMUXIN => IZ) = (0,0);
	if (SELECT == 1'b1)
   		(SQHSCK => IZ) = (0,0);
   //(SELECT => IZ) = (0,0);
endspecify

endmodule