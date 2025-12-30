//module btn_toggle with debounce

module btn_toggle #(
  parameter DEBOUNCE_CNT = 270000  // 270000 cycles ~10ms à 27Mhz ( 20 pour la simu)
)
  (
    input clk,
    input btn,
    input reset,
    output reg out
  );
  
  reg btn_ff1;
  reg btn_ff2;
  reg btn_stable;
  reg btn_n1;
  reg [$clog2(DEBOUNCE_CNT)-1:0] count; 
  
  
  //synchro bouton
  always @(posedge clk) begin
    btn_ff1 <= btn;
    btn_ff2 <= btn_ff1;
  end
  
  
  //debounce
  
  always @(posedge clk) begin
    if(reset) begin
      btn_stable <=0;
      count <=0;
    end else if(btn_ff2 == btn_stable) begin
      count <= 0;
    end else begin
      if(count == (DEBOUNCE_CNT -1)) begin
        btn_stable <= btn_ff2;
        count <= 0;
      end else begin
        count <= count + 1 ;
      end
    end
  end

// toggle
  always @(posedge clk) begin
    if(reset) begin 
      out <=0;
      btn_n1 <=0;
    end else if(btn_stable && ~btn_n1) begin
      out <= ~out;
    end 
      btn_n1 <= btn_stable;    
  end         
endmodule
         
         
         
        
      
      
  
    
    
