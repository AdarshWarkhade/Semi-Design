// Code your testbench here
// or browse Examples
module APB_tb();
  
  /////      SPECIFICATIONS     //////
  parameter DATA_SIZE = 32;
  parameter ADDR_SIZE = 10;
  
  //////      REG     //////
  reg pclk, presetn, penable, psel, pbusy;	
  reg pwrite; // if pwrite = 1 then write else read
  reg [ADDR_SIZE - 1 :0] paddr;	// from where to read or write
  reg [DATA_SIZE -1 :0] pwdata;	// data to be written
  
  //////      WIRE     ///////
  wire pready, pslverr;
  wire [DATA_SIZE -1 :0] prdata;

  ///////      MISC     ///////
  reg [ADDR_SIZE - 1 :0] address;
  integer i, num;
  
  ///////      MODULE DUT INSTATIATION       ///////
  APB dut(pclk, presetn, pwrite, psel, penable, pbusy, paddr, pwdata, pready, prdata, pslverr);
  
  ///////      GENERATE CLOCK     //////
  always begin
    pclk = 1;
    forever #5 pclk=~pclk;
  end
  
  ////////     IDLE     /////////
  task goto_idle();
    {psel,penable} = 2'b00;
  endtask
  
  ////////     SETUP     /////////
  task goto_setup(input integer wr_rd, input [ADDR_SIZE - 1 :0] address = 0, input integer num = 0);
    fork
      {psel, penable} = 2'b10;
      pwrite = wr_rd;
    join
    @(negedge pclk);
    for(i=0; i<=num; i=i+1) begin
      goto_access();
      address = address + i;
    end
    goto_idle();
  endtask
  
  ////////     ACCESS     /////////
  task goto_access();
    {psel, penable} = 2'b11;
    if(pwrite) write();
    else read();
    @(negedge pclk);
    {psel, penable} = 2'b10;
    @(negedge pclk);
  endtask
  
  ////////     BUSY     /////////
  task call_busy();
    pbusy = 1;
  endtask
  task release_busy();
    pbusy = 0;
  endtask
  
  ////////     WRITE     /////////
  task write();
    paddr = address;
    pwdata = $random;
  endtask
  
  ////////     READ     /////////
  task read();
    paddr = address;
  endtask
  
  
  ////////////////     STIMULUS START     ////////////////
  initial begin
    presetn = 0; //active-low reset
    goto_idle();
    call_busy();
    @(negedge pclk);
    presetn = 1;
    release_busy();
    #200 $finish;
  end
  
  initial begin
    wait(presetn==1);
    goto_setup(1,1,4); // write-read, addr, number of data
    goto_setup(0,1,4);
  end
  //////////////////      STIMULUS END     ///////////////
  
  
  //////      DUMP FILE FOR WAVEFORM      /////
  initial begin
    $dumpfile("APB.vcd");
    $dumpvars();
  end
  
endmodule
