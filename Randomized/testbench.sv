class transaction;
  rand int data;
  rand byte addr;
  bit wr_rd;
  
  function void display();
    $display("data=%0d",data);
    $display("addr=%0d",addr);
    $display("wr_rd=%0d",wr_rd);
  endfunction
endclass
  
  module top;
    transaction tx;
    initial begin
      tx=new();
      repeat(5)
        begin
          tx.randomize();
          tx.display();
        end
    end
  endmodule
      
