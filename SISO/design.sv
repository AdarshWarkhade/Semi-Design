module siso(in,clk,rst,out);
	input in,rst,clk;
	output reg out;
	reg [3:0]temp;

	always @(posedge clk) begin
		if(rst)
			temp<=0;
		else begin
			temp<=temp>>1;
			temp[3]<=in;
			out<=temp[0];
		end
	end
endmodule
