module tb();
 
  typedef enum {cycle,bike,car=6,train=51,plane,ship=100} vehicle;
  vehicle a;
  
  initial
    begin
      	a=car;
      $display("name of vehicle=%s",a.prev(1).next(2).name);
      $display("value of vehicle=%0d",a.prev(2).next(3));
      
      $display("name of vehicle=%s",a.prev(2).next(4).name);
      $display("value of vehicle=%0d",a.prev(0).next(3));
      
      $display("name of vehicle=%s",a.prev(1).next(4).name);
      $display("value of vehicle=%0d",a.next(3).prev(2));
    end
  
endmodule
