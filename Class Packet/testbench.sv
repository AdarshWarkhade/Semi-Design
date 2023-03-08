class packet;
  int data;
  byte addr;
endclass
    
    module top;
      packet pkt; 
      initial begin
        pkt=new();
        pkt.data=100;
        pkt.addr=10;
        $display("Data=%0d Addr=%0d",pkt.data,pkt.addr);
      end
    endmodule
      
  
