module BCDcounter(clk,rst,out);
  input clk,rst;
  output reg [3:0]out;
  
  always @(posedge clk) begin
    if(rst==0)
      out<=0;
    
    else begin
      if(out<9)
        out<=out+1;
      else
        out<=0;
    end
  end
endmodule
