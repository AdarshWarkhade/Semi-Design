module sp_tb();
  parameter DATA_LENGTH=32;
  parameter ADDR_SIZE=4;
  
  reg clk,rst,wr_rd,valid;
  reg[DATA_LENGTH-1:0]wdata;
  reg[ADDR_SIZE-1:0]addr;
  
  wire ready;
  wire [DATA_LENGTH-1:0]rdata;
  integer i;
  
  sp_memory dut(clk,rst,wr_rd,valid,addr,wdata,rdata,ready);
    
  always #5 clk=!clk;
   initial begin
     $monitor("clk=%0b,rst=%0b,wr_rd=%0b,valid=%0b,addr=%0b,wdata=%0b,rdata=%0b,ready=%0b",clk,rst,wr_rd,valid,addr,wdata,rdata,ready);
     
     clk=0;
     rst=0;
     #10;
     rst=1;
     #100 $finish;
   end
  initial begin
    wait(rst==1)
    valid=1;
    wr_rd=1;
    
      for(i=0;i<2**ADDR_SIZE;i=i+1)
        
        begin
          addr=i;
          wdata=$random;
          #10;
        end
  end
  initial begin
    wr_rd=0;
    
      for(i=0;i<2**ADDR_SIZE;i=i+1)
        
        begin
           addr=i;
          #10;
        end
  end
    initial begin
      $dumpfile("spmem.vcd");
      $dumpvars;
    end
endmodule
