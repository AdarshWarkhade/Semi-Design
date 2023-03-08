module dynamic_array();
  integer arr[];
  
   initial
    begin
     arr=new[8];
     $display(arr.size);
     
     arr[2]=8;
     arr[4]=1;
     arr[7]=6;
      $display("arr=%p",arr);
     
      arr=new[16](arr);
      $display(arr.size);
      $display("arr=%p",arr);
     
     arr[12]=4;
     arr[15]=9;
      $display("arr=%p",arr);
   end
endmodule
