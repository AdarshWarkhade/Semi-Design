module sp_memory(clk,rst,wr_rd,valid,addr,wdata,rdata,ready);
	
  parameter DATA_LENGTH=32;
  parameter ADDR_SIZE=4;
  
  input clk,rst,wr_rd,valid;
  input[DATA_LENGTH-1:0]wdata;
  input[ADDR_SIZE-1:0]addr;
  
  output reg ready;
  output reg [DATA_LENGTH-1:0]rdata;
  integer i;
  
  reg[DATA_LENGTH-1:0]mem[2**ADDR_SIZE-1:0];
	
  always@(posedge clk, negedge rst)
        begin
          if(!rst)
             begin
               for(i=0;i<2**ADDR_SIZE;i=i+1)
               mem[i]<=0;
             end
		  else
            begin
             if(valid) 
               begin
                 ready=1;
                  if(wr_rd)
                    begin
                     mem[addr]<=wdata;
                    end
                  else
                    begin
                     rdata<=mem[addr];
                    end
                end
             else
               begin
                 ready<=0;
               end
            end
        end
endmodule
