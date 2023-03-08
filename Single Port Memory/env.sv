class environment;
  
  generator gen;
  driver drv;
  monitor mon = new();
  scoreboard scb = new();
  
  function new();
    gen=new();
    drv=new();
    mon = new();
    scb = new();
  endfunction
  
  task run();
    fork 
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join
  endtask
  
endclass
