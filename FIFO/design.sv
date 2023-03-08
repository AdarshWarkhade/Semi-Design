module fifo(clk,rst,wdata,rdata,rd_en,wr_en,full,empty,error);
	
  parameter DATA_SIZE=8;
  parameter ADDR_WIDTH=4;
 
  input clk,rst,wr_en,rd_en;
  input[7:0]wdata;
  
  output reg[7:0]rdata;
  output reg full,empty,error;
  
  reg [2:0] rd_ptr,wr_ptr;  
  reg [7:0] count;
  reg[7:0]mem[7:0];
  integer i;
  
  assign full=(count==8)?1:0;
  assign empty=(count==0)?1:0;
	
  always@(posedge clk)
    begin if(rst)
      begin
      wr_ptr<=0;
      rd_ptr<=0;
      count<=0;
      for(i=0;i<7;i=i+1)
            mem[i]<=0;
    end
  
    else if(wr_en && !full)
    begin
      error<=0;
      mem[wr_ptr]<=wdata;
      wr_ptr<=wr_ptr+1;
      count<=count+1;
      
    end
  
    else if(rd_en && !empty)
    begin
      error<=0;
      rdata<=mem[rd_ptr];
      rd_ptr<=rd_ptr+1;
      count<=count-1;
    end
  
    else
    begin
      error<=1;
    end
    
  end
endmodule
