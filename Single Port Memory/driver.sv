class driver;
  transaction tr;
  virtual sp_intf vif;
  
  task run();
    vif = common::intf;
    
   forever 
     begin
       wait(vif.rst==0);
       common::gen2drv.get(tr);
       
       @(vif.drv_cb);	
       
       vif.valid <= 1;
       vif.wdata <= tr.wdata;
       vif.addr <= tr.addr;
       vif.wr_rd <= tr.wr_rd;
       @(posedge vif.clk);
    end
  endtask
  
endclass
