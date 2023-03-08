class generator;
  transaction tr;
  int que[$];
  int temp;
  
  task run();
    repeat(4) 
      begin
        tr = new();
        tr.randomize() with {tr.wr_rd==1;};
        que.push_front(tr.addr);
        common::gen2drv.put(tr);
      end
    
    repeat(4) 
      begin
        tr = new();
        temp = que.pop_back();
        tr.randomize() with {tr.wr_rd==0; tr.addr==temp;};
        common::gen2drv.put(tr);
      end
  endtask
  
endclass
