interface sp_intf(input logic clk, rst); 
  bit [7:0]wdata;
  bit [3:0]addr;
  logic wr_rd;
  logic valid ;
  bit [7:0]rdata;
  logic ready;
  
  clocking drv_cb @(posedge clk);
    default input #1;
    default output #1; 
    input wr_rd;
    output wdata, addr, valid, rdata, ready;
  endclocking:drv_cb
  

  clocking mon_cb @(negedge clk);
    default input #1;
    default output #1;
    input wr_rd, wdata, addr, valid, rdata, ready;
  endclocking:mon_cb
  
endinterface
