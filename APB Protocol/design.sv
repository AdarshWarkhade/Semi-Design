// Code your design here
module APB(pclk, presetn, pwrite, psel, penable, pbusy, paddr, pwdata, pready, prdata, pslverr);
  
  /////      SPECIFICATIONS     //////
  parameter DATA_SIZE = 32; // 32 bit data
  parameter ADDR_SIZE = 10; // 10 bit address line
  parameter DEPTH = 16; // we are considering just 16 location for the purpose of readability
  
  /////      STATES      /////
  parameter idle = 2'b00, setup = 2'b01, access = 2'b10;
  reg [1:0] p_state, n_state;
  
  /////      INPUTS      //////
  input pclk, presetn, penable, psel, pbusy;	
  input pwrite; // if pwrite = 1 then write else read
  input [ADDR_SIZE - 1 :0] paddr;	// from where to read or write
  input [DATA_SIZE -1 :0] pwdata;	// data to be written
  
  /////      OUTPUTS      //////
  output reg pready, pslverr;
  output reg [DATA_SIZE -1 :0] prdata;

  /////      INTERNAL MEMORY      //////
  reg [DATA_SIZE -1 :0] mem[(2**ADDR_SIZE) - 1 :0];
  
  /////      PSEL, PENABLE      //////
  wire in;
  assign in = {psel, penable}; 
  
  integer i;
  
  //////     pready      //////
  always @(penable) begin
    pready = !pbusy;
  end
  
  //////     setting the present state       //////
  always @(posedge pclk) begin
    if(!presetn) begin
      p_state <= idle;  // active-low reset
      pslverr <= 0;
      for(i=0; i<DEPTH; i=i+1) mem[i] <= 0;
    end
    else begin
      p_state <= n_state;
    end
  end
  
  //////    state changes    //////
  always @(p_state, in) begin
    case(p_state) 
      idle: n_state = (in==2'b10)?setup:idle;
      setup: begin
        if(in==2'b11) n_state = access;
        else if(in==2'b00) n_state = idle;
        else n_state = setup;
      end
      access: begin
        if(in==2'b00) n_state = idle;
        else if(in==2'b11) n_state = access;
        else if(in==2'b10) n_state = setup;
        else n_state = access;
      end
      default: n_state = idle;
    endcase
  end
  
  //////      pslverr      //////
  always @(p_state) begin
    if(p_state == setup) begin
      if(paddr>=1024 & paddr<=0) pslverr = 1;
      else pslverr = 0;
    end
  end
  
  //////      pslverr and write and read      //////
  always @(p_state, pready) begin
    if(p_state==access & pready & ~pslverr) begin
      if(pwrite) mem[paddr] <= pwdata;
      else prdata <= mem[paddr];
    end
    else prdata <= prdata;
  end
  
endmodule
