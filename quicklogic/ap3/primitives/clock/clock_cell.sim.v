`timescale 1ns/10ps

module CLOCK(IP, CEN, IC, OP);
input IP, CEN;
output IC, OP;
buf IP_buf (IP_int, IP) ;
buf CEN_buf (CEN_int, CEN) ;

buf (IC, IP_int);

specify
   (IP => IC) = (0,0);
endspecify


endmodule

