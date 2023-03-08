`include "interface.sv"
`include "trans.sv"
`include "common.sv"
`include "gen.sv"
`include "driver.sv"
`include "scoreboard.sv"
`include "monitor.sv"
`include "env.sv"


module top();
  
  environment env;
  
  bit clk,rst,valid;
  
  sp_intf pif(clk,rst);
  
     
  single_port dut(.clk(pif.clk), .rst(pif.rst), .wr_rd(pif.wr_rd), .valid(pif.valid), .wdata(pif.wdata), .addr(pif.addr), .rdata(pif.rdata), .ready(pif.ready));
  
  always #5 clk = !clk;
  
  initial
    begin
      common::intf = pif;
      env = new();
      env.run();
  end
  
  initial begin
    rst = 1;
    @(posedge clk);
    rst = 0;
    #200 $finish;
  end
     
  initial
    begin
      $dumpfile("mem.vcd");
      $dumpvars();
    end
  
endmodule
