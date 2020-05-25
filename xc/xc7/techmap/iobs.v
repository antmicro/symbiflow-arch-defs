module IBUF (I, O);
  (* iopad_external_pin *)
  input  I;
  output O;

  parameter IOSTANDARD   = "default";
  parameter IBUF_LOW_PWR = 0;
  parameter IN_TERM      = "NONE";  // Not supported by Vivado ?

  assign O = I;

endmodule

module OBUF (I, O);
  input  I;
  (* iopad_external_pin *)
  output O;

  parameter IOSTANDARD   = "default";
  parameter DRIVE        = 12;
  parameter SLEW         = "SLOW";

  assign O = I;

endmodule

module OBUFT (I, T, O);
  input  I;
  input  T;
  (* iopad_external_pin *)
  output O;

  parameter IOSTANDARD   = "default";
  parameter DRIVE        = 12;
  parameter SLEW         = "SLOW";

  assign O = (T == 1'b0) ? I : 1'bz;

endmodule

