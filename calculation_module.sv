module calculation_module(
	input on3,
	input switch,
	input integer value,
	output int unsigned answ,
	output Led
);
	logic ready_to_calculate = 1'b1;
	int unsigned y;
	integer s; 
	integer val = 0;
	int unsigned b;
	reg led;
	assign Led = led;
	
//calculation block( algorithm from hacker deligt book ) 
always@(*)
	begin
		if (switch && ready_to_calculate) begin
		val = value;
		y = 0;
		for(s = 30; s >= 0; s = s - 3) begin
			y = 2 * y;
			b = (3 * y * (y + 1) + 1) << s;
			if (val > b | val == b) begin
				val = val - b;
				y = y + 1;
			end
		end
			ready_to_calculate = 1'b0;
		end
		else if(!switch && !ready_to_calculate) begin
			ready_to_calculate = 1'b1;
		end
		else if(switch && !ready_to_calculate) begin
			answ = y;
		end
		end
endmodule
