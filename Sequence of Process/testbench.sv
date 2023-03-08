module tb();
  initial begin
     fork
       
       #1 $display("time=%0t Process-1",$time);
       #5 $display("time=%0t Process-2",$time);
       #3 $display("time=%0t Process-3",$time);
       #7 $display("time=%0t Process-4",$time);
       
     join
    
    #1 $display("time=%0t Process-1",$time);
    
  end
endmodule
