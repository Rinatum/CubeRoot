module cube_root(
	input [1:0] KEY , // keys
	input [9:0] SWITCH , // switches
	input clk,
	output [9:0] LED, // leds
	output [5:0][7:0] HEX // displays
);

integer value;
reg[12:0] counter = 1'b0;
reg [6:0] counter3 = 1'b0;
reg on3 = 1'b0;
reg on = 1'b0;
wire [5:0][7:0]hex;

Input in(on3, KEY[0], KEY[1], value, LED[4], SWITCH[0]);
Output out(HEX, value, on3, SWITCH[0], KEY[0], KEY[1], LED[1]);

//generate
//		begin:upstream 
//		genvar i,j;
//		for (i = 0; i < 6 ; i = i + 1) begin:firstloop
//			for(j = 0; j <= 7 ; j = j + 1) begin:secondloop
//				assign HEX[i][j] = hex[i][j];
//			end
//		end
//		end
//endgenerate



// definition of clock cycle
always@(posedge clk) begin
	counter = counter + 1'b1;
		if (counter == 4095) begin
			on = !on;
		end
	end

always @(posedge on)
	begin
	counter3 = counter3 + 1'b1;
	if(counter3 == 31) begin
		on3 = !on3;
	end
	end

endmodule