class scoreboard;
  transaction tr;
  transaction tr1;
  
  reg [7:0] mem1[7:0];
  
  task run();
    forever begin
      common::mon2scb.get(tr);
      tr1 = new();
      
      tr1.wr_rd=tr.wr_rd;
      tr1.wdata=tr.wdata;
      tr1.addr=tr.addr;
      
      if(tr1.wr_rd==1)
        mem1[tr1.addr]<=tr1.wdata;
      else
        tr1.rdata<=mem1[tr1.addr];
                                   
      if(tr1.rdata == tr.rdata) 
        begin
          tr.display("ACTUAL OUTPUT");
          tr1.display("EXPECTED OUTPUT");
          $display("----TEST CASE PASS----");
          $display(" ");
        end
      else 
        begin
          tr.display("ACTUAL OUTPUT");
          tr1.display("EXPECTED OUTPUT");
          $display("----TEST CASE FAIL----");
          $display(" ");
        end
         
    end
  endtask
endclass
