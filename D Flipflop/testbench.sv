module tb;
	reg clk,rst,d;
	wire q;

	dff dut(clk,rst,d,q);

	initial begin
		rst=0;
		clk=0;
		//forever #5 clk=~clk;
	end

	always #5 clk=!clk;

	initial begin
		#8 rst=1;
		d=1;
		#10 d=0;
		#10 d=1;
		#10 d=0;
		#100 $finish;
	end

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
