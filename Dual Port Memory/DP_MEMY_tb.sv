module dp_tb();
  parameter DATA_SIZE=32;
  parameter ADDR_WIDTH=4;
 
  reg clk,rst,valid,we,re;
  reg[DATA_SIZE-1:0]w_data;
  reg[ADDR_WIDTH-1:0]w_addr,r_addr;
  
  wire [DATA_SIZE-1:0]r_data;
  wire ready;
  
  dp_memory dut(clk,rst,valid,we,re,r_addr,w_data,w_addr,r_data,ready);
   
  integer i;
  

  
   always #5 clk=~clk;
  
  initial 
    begin
  
      clk=0;
      rst=0;
      
      valid=1'b0;
      we=1'bx;
      re=1'bx;
      
      #10;
      rst=1;
      
    end
  initial 
    begin
      wait(rst==1);
      valid=1;
      we=1;
      re=0;
      for(i=0;i<2**ADDR_WIDTH;i=i+1)
      begin
        w_addr=i;
        w_data=$random;
        #10;
      end
      
      we=0;
      re=1;
      for(i=0;i<2**ADDR_WIDTH;i=i+1)
        begin
          r_addr=i;
          #10;
        end
        fork
         we=1;
         re=1;
        join
      
          for(i=0;i<2**ADDR_WIDTH;i=i+1)
          begin
          w_addr=i;
          r_addr=i;
          w_data=$random;
          #10;
      end 
      #200 $finish;
    end
  initial
    begin
      $dumpfile("DPMEM.vcd");
      $dumpvars;
    end
      
endmodule
