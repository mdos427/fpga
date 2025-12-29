module PC
  (
    input clk,
    input [15:0] in,
    input reset,
    input load,
    input inc,
    output reg[15:0] out
	);
  
  always @(posedge clk) begin
    if(reset)
      out <= 16'd0;    
    else if(load)
      out <= in;       
	else if(inc) 
      out <= out + 16'd1;    
  end
endmodule

  
