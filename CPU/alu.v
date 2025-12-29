module alu
  (
    input clk,
    input [15:0] x,
    input [15:0] y,
    input nx, //negative x
    input ny,
    input zx, // zero x
    input zy,
    input f, // if f => x + y else x & y
    input no, // if no => !out
    output reg[15:0] out
  );
  reg [15:0] xin;
  reg [15:0] yin;
  always @(posedge clk) begin
    xin = x;
    yin = y;
    if(zx) xin = 0;
    if(nx) xin = ~xin;
  
    
    
    
    
    
    
    
    /*
    
  
  Chip name: ALU
Inputs: x[16], y[16], // Two 16-bit data inputs
zx, // Zero the x input
nx, // Negate the x input
zy, // Zero the y input
ny, // Negate the y input
f, // Function code: 1 for Add, 0 for And
no // Negate the out output
Outputs: out[16], // 16-bit output
zr, // True iff out=0
ng // True iff out<0
Function: if zx then x = 0 // 16-bit zero constant
if nx then x = !x // Bit-wise negation
if zy then y = 0 // 16-bit zero constant
if ny then y = !y // Bit-wise negation
if f then out = x + y // Integer 2's complement addition
else out = x & y // Bit-wise And
if no then out = !out // Bit-wise negation
if out=0 then zr = 1 else zr = 0 // 16-bit eq. comparison
if out<0 then ng = 1 else ng = 0 // 16-bit neg. comparison
*/
    
    
    
