module alu


  (
    input [15:0] x,
    input [15:0] y,
    input nx, //negative x
    input ny,
    input zx, // zero x
    input zy,
    input f, // if f => x + y else x & y
    input no, // if no => !out
    output wire [15:0] out,
    output wire zr,
    output wire ng
  );


  wire [15:0] xin;
  wire [15:0] yin;
  assign xin = (nx ? ~(zx ? 16'h0: x): (zx ? 16'h0: x));
  assign yin = (ny ? ~(zy ? 16'h0: y): (zy ? 16'h0: y));
  assign out = (no ? ~(f ? (xin + yin ) : (xin & yin )) : (f ? (xin + yin ) : (xin & yin )));
  assign zr = (out  == 16'h0000);
  assign ng = out[15];
endmodule
