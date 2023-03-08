class transaction;
  rand bit [7:0]wdata;
  rand bit [3:0]addr;
  rand logic wr_rd;
  logic valid;
  
  bit [7:0]rdata;
  logic ready;
  
  function void display(string name);
    $display("-- %s --", name);
    $display("MODE: WRITE/RIGHT = %d ", wr_rd);
    $display("INPUTS: WRITE DATA = %d,  ADDRESS = %d ", wdata, addr);
    $display("OUTPUT: READ DATA = %d ", rdata);
  endfunction

endclass
