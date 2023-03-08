module tb_siso();
	reg clk,rst,in;
	wire out;

	siso dut(in,clk,rst,out);

	initial begin
		$monitor("#%0t- in=%0b, out=%0b",$time,in,out);
		clk=0;
		rst=1;
		in=1;
		#10 rst=0;
		in=0;
		#10 in=1;
		repeat(15) begin
			#10 in=$random;
		end
      #200 $finish;
	end

	always #5 clk=!clk;
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
