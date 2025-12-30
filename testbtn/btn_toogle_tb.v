// Code your testbench here
// or browse Examples
module tb;
  reg clk;
  reg btn;
  reg reset;
  wire out;

  
  btn_toggle t0(
    .clk(clk),
    .reset(reset),
    .btn(btn),
    .out(out)
  );


  //clock
  initial clk = 0;
  always #5 clk <=~clk; //tic tac clock
  
    
 //init values
  
  initial begin
    reset = 1;
    btn = 0;
  end
  
  //reset
  
  initial begin
    repeat(2) @(posedge clk);
    reset = 0;
  end
  
  //action
  initial begin 
    #20
    btn = 1;
    #210 btn = 0;
    #450 btn = 1;
  end
  
  
  //monitoring
  
  always @(posedge clk) $display ("t=%0t | reset %b | btn %b | out %b ",$time,reset,btn,out);
  

  //stop simu
  initial #1000 $finish;
    
endmodule

    
