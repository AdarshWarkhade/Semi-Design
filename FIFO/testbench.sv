module fifo_tb();
	
  parameter DATA_SIZE=8;
  parameter ADDR_WIDTH=4;
 
  reg clk,rst,wr_en,rd_en;
  reg[7:0]wdata;
  reg [2:0]rd_ptr,wr_ptr;
  
  wire [7:0]rdata;
  wire full,empty,error;
  wire [3:0]count;
  integer i;
  
  fifo dut(clk,rst,wdata,rdata,rd_en,wr_en,full,empty,error);
  
  task write(input integer num,addr_i=0);
    wr_en=1;
  for(i=0;i<num;i=i+1)
    begin
      wr_ptr=addr_i+i;
      wdata=$random;
      #10;
    end
  wr_en=0;
endtask
  
  
  task read(input integer num,addr_i=0);
    rd_en=1;
    for(i=0;i<num;i=i+1)
      
      #10;
      
    rd_en=0;
  endtask
  
  
  initial begin
    clk=0;
    rst=1;
    wr_en=0;
    rd_en=0;
  
    #10;
    rst=0;
    #200 $finish;
  end
  
  initial begin
    wait(rst==0)
    write(4,0);
    read(3,4);
  end
    
  always #5 clk=~clk;
  initial begin
    $dumpfile("fifo.vcd");
    $dumpvars;
  end
endmodule
