module tb;
  reg clk,rst;
  wire [3:0]out;
  BCDcounter dut(clk,rst,out);
  
  initial begin
    $monitor("rst=%0d,out=%0d",rst,out);
    clk=0;
    rst=0;
    #10 rst=1;
    #100 $finish;
  end
  always #5 clk=!clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
