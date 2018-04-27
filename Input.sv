module Input(
	input on3,
	input KEY_DIGIT,
	input KEY_INCREMENT,
	output integer value,
	output Led,
	input switch
);
reg led;
assign Led = led;
integer factor = 1;	
integer digit = -1;

//block for maping of input value from display to decimal
always@(posedge on3)
	begin
	if (!switch) begin
	if (!KEY_INCREMENT) begin
			value = value + digit*factor;
			factor = factor * 10;
			digit = -1;
		end
	if (!KEY_DIGIT) 
		if (digit == 9)
			digit = 0;
		else 
			digit = digit + 1;
	end
	else begin
		factor = 1;
		value = 0;
	end
	end
endmodule

