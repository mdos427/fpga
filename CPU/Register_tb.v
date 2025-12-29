module tb;
  
  reg clk;
  reg [15:0] in;
  reg reset;
  reg load;
  wire [15:0] out;
  
  Register u0(
    .clk(clk),
    .in(in),
    .reset(reset),
    .load(load),
    .out(out)
  );

  	initial clk = 0;
  	always #5 clk <=~clk; //tic tac clock
  
  
  // initials values
  initial begin  
    reset = 1;
    load = 0;
  end
  
  //reset
  
  initial begin
    repeat(2) @(posedge clk);
    reset = 0;
  end
  
    
  initial begin
    #20 
    in = 16'h1234;    
  	#20
    load = 1;
    #10 
    load = 0;
    #10
    in = 0;
    #10
    load = 1;
    #10
    load = 0;
    #10
    in = 16'hffff;
    load = 1;
    #10 load = 0;
    
  end   
  //monitoring 

  
  always @(posedge clk)  $display("t=%0t| reset %h | load %b | in %h | out %h",$time,reset,load,in,out);

  // stop la simulation
  initial begin 
    #200 $finish;
  end  
endmodule 
