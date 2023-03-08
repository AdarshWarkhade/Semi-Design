module single_port(clk,rst,wr_rd,valid,wdata,addr,rdata,ready);
  parameter DATA_SIZE=8;
  parameter ADDR_SIZE=4;
  
  input [DATA_SIZE-1:0]wdata;
  input [ADDR_SIZE-1:0]addr;
  input clk,rst,wr_rd,valid;
  
  output reg [DATA_SIZE-1:0]rdata;
  output reg ready;
  
  integer i;
   
  reg [DATA_SIZE-1:0] mem[2**ADDR_SIZE-1:0];
  
  always@(posedge clk)
    begin
      if(rst)
        begin
          for(i=0;i<(2**ADDR_SIZE);i=i+1) 
            mem[i]<=0;
        end
      else
        begin
          if(valid)
            begin
              ready<=1;
              if(wr_rd)
                mem[addr]<=wdata;
              else
                rdata<=mem[addr];
            end
          else
            ready<=0;
        end
     end
  
endmodule
        
