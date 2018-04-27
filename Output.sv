module Output(
	output [5:0][7:0] HEX,
	input integer value,
	input on3,
	input SWITCH,
	input KEY_DIGIT,
	input KEY_INCREMENT,
	output test
);
	reg finish = 1'b1;
	integer digit = -1;
	integer t = 0;
	int unsigned answer;
	int unsigned conc;
	reg [5:0][7:0] hex;
	calculation_module calc(on3, SWITCH, value, answer, test);
	
generate
		begin:upstream 
		genvar i,j;
		for (i = 0; i < 6 ; i = i + 1) begin:firstloop
			for(j = 0; j <= 7 ; j = j + 1) begin:secondloop
				assign HEX[i][j] = hex[i][j];
			end
		end
		end
endgenerate


	
always@(posedge on3) begin
	if (!SWITCH) begin // initial state: waiting for input value
	if (finish) begin 
	for (int o = 0; o < 6 ; o = o + 1) begin// cleaning of display
			for(int p = 0; p <= 7 ; p = p + 1) begin
				hex[o][p] = 1'b1;
			end
		end
		hex[0][7] = 1'b0;
		finish = 1'b0;
	end
	else begin 
	if (!KEY_INCREMENT) begin // move to next digit number
		digit = -1;
		hex[t][7] = !hex[t][7];
		t = t + 1;
		hex[t][7] = !hex[t][7];
	end
	if (!KEY_DIGIT) begin  //increase certain digit
		if (digit == 9)
			digit = 0;
		else
			digit = digit + 1;
		if(t <= 5) 
		case (digit) // state machine for output temporary result
		0: begin
			for (int k = 0; k < 6 ; k = k + 1) begin
			hex[t][k] = 1'b0;
			end
			hex[t][6] = 1'b1;
			end
		1: begin
			for (int k = 3; k < 6 ; k = k + 1) begin
			hex[t][k] = !hex[t][k];
			end
			hex[t][0] = !hex[t][0];
			end
		2: begin
			hex[t][2] = !hex[t][2];
			hex[t][0] = !hex[t][0];
			hex[t][3] = !hex[t][3];
			hex[t][4] = !hex[t][4];
			hex[t][6] = !hex[t][6];
			end
		3: begin
			hex[t][2] = !hex[t][2];
			hex[t][4] = !hex[t][4];
			end
		4: begin
			hex[t][0] = !hex[t][0];
			hex[t][3] = !hex[t][3];
			hex[t][5] = !hex[t][5];
			end
		5: begin
			hex[t][1] = !hex[t][1];
			hex[t][0] = !hex[t][0];
			hex[t][3] = !hex[t][3];
			end
		6: begin
			hex[t][4] = !hex[t][4];
			end
		7: begin
			for (int k = 3; k < 7 ; k = k + 1) begin
				hex[t][k] = !hex[t][k];
			end
			hex[t][1] = !hex[t][1];
			end
		8: for (int k = 3; k < 7 ; k = k + 1) begin
				hex[t][k] = !hex[t][k];
			end
		9: begin
			hex[t][4] = !hex[t][4];
			end
		endcase
			end
	    end
		end
		else begin // calculation state!
		for (int o = 0; o < 6 ; o = o + 1) begin // cleaning of display
			for(int p = 0; p <= 7 ; p = p + 1) begin
				hex[o][p] = 1'b1;
			end
		end
		hex[0][7] = 1'b0;
		t = 0;
		conc = answer;
		while ((conc > 0) && (t < 6)) begin
		digit = conc % 10;
		conc = conc / 10;
			case (digit) // state machine for print final result 
		0: for (int k = 0; k < 6 ; k = k + 1) begin
			hex[t][k] = !hex[t][k];
			end
		1: for (int k = 1; k < 3 ; k = k + 1) begin
			hex[t][k] = !hex[t][k];
			end
		2: begin
			hex[t][0] = !hex[t][0];
			hex[t][1] = !hex[t][1];
			hex[t][3] = !hex[t][3];
			hex[t][4] = !hex[t][4];
			hex[t][6] = !hex[t][6];
			end
		3: begin
				for (int k = 0; k < 4 ; k = k + 1) begin
					hex[t][k] = !hex[t][k];
				end
			hex[t][6] = !hex[t][6];
			end
		4: begin
			hex[t][1] = !hex[t][1];
			hex[t][2] = !hex[t][2];
			hex[t][5] = !hex[t][5];
			hex[t][6] = !hex[t][6];
			end
		5: begin
			hex[t][0] = !hex[t][0];
			hex[t][5] = !hex[t][5];
			hex[t][6] = !hex[t][6];
			hex[t][2] = !hex[t][2];
			hex[t][3] = !hex[t][3];
			end
		6: begin
			hex[t][0] = !hex[t][0];
			hex[t][5] = !hex[t][5];
			hex[t][6] = !hex[t][6];
			hex[t][2] = !hex[t][2];
			hex[t][3] = !hex[t][3];
			hex[t][4] = !hex[t][4];
			end
		7: for (int k = 0; k < 3 ; k = k + 1) begin
				hex[t][k] = !hex[t][k];
			end
		8: for (int k = 0; k < 7 ; k = k + 1) begin
				hex[t][k] = !hex[0][k];
			end
		9: begin
				for (int k = 0; k < 4 ; k = k + 1) begin
					hex[t][k] = !hex[t][k];
				end
			hex[t][6] = !hex[t][6];
			hex[t][5] = !hex[t][5];
			end
		endcase
		t = t + 1;
		end
		finish = 1'b1; 
		t = 0;
		digit = -1;
	end

	end
endmodule

