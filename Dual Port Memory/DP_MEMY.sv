module dp_memory(clk,rst,valid,we,re,r_addr,w_data,w_addr,r_data,ready);
	
  parameter DATA_SIZE=32;
  parameter ADDR_WIDTH=4;
 
  input clk,rst,valid,we,re;
  input[DATA_SIZE-1:0]w_data;
  input[ADDR_WIDTH-1:0]w_addr,r_addr;
  
  output reg [DATA_SIZE-1:0]r_data;
  output reg ready;
  integer i;
  
  reg[DATA_SIZE-1:0]mem[2**ADDR_WIDTH-1:0];
	
  always@(posedge clk)
        begin
          if(!rst)
             begin
               for(i=0;i<2**ADDR_WIDTH;i=i+1)
               mem[i]<=0;
             end
		  else
            begin
             if(valid) 
               begin
                 ready<=1;
                 if(we==1 && re==0)
                   begin
                     mem[w_addr]<=w_data;
                   end
                 else if(we==0 && re==1)
                   begin
                     r_data<=mem[r_addr];
                   end
                 else if(we==1 && re==1)
                   begin
                     mem[w_addr]<=w_data;
                     r_data<=mem[r_addr];
                   end
                 else
                   begin
                     for(i=0;i<2**ADDR_WIDTH;i=i+1)
                      mem[i]<=0;
                   end
               end
             else
               begin
                 ready<=0;
               end
            end
        end
endmodule
