module Register
  (
    input clk,
    input [15:0] in,
    input reset,
    input load,
    output reg[15:0] out
  );
  
  always @(posedge clk) begin
    if(reset) out <= '0;
    else if(load) out <= in;
  end
endmodule

  
    
