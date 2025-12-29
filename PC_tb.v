module tb;
  
  reg clk;
  reg [15:0] in;
  reg reset;
  reg inc;
  reg load;
  wire [15:0] out;
  
  PC u0(
    .clk(clk),
    .in(in),
    .reset(reset),
    .inc(inc),
    .load(load),
    .out(out)
  );

  	initial clk = 0;
  	always #5 clk <=~clk; //tic tac clock
  
  
  // initials values
  initial begin  
    reset = 1;
    load = 0;
    inc = 0;
  end
  
  //reset
  
  initial begin
    repeat(10) @(posedge clk);
    reset = 0;
  end
  
  initial begin
    #200
    inc=1;
    #200
    inc=0;
    in = 16'h1234;
    load = 1;
  	#20
    load = 0;
    
    
    
  end   
  //monitoring 
  
  always @(posedge clk)  $display("t=%0t|inc %h | reset %h | in %h | out %h",$time,inc,reset,in,out);
  
  
  
  
  // stop la simulation
  initial begin 
    #1000 $finish;
  end
  
endmodule 
  
  
  
