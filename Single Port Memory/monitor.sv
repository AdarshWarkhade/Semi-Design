class monitor;
  transaction tr = new();
  virtual sp_intf vif;
  
  task run();
    vif = common::intf;
    
    repeat(4) 
      begin
        wait(vif.rst==0);
    
        @(posedge vif.clk);
        tr.wdata=vif.wdata;
        tr.addr=vif.addr;
        tr.wr_rd=vif.wr_rd;
      
        @(negedge vif.clk);
        tr.rdata=vif.rdata;  
        tr.ready=vif.ready;  
        
        common::mon2scb.put(tr);
    end
  endtask
endclass
