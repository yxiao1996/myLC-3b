`ifndef _MUX
`define _MUX

module mux16x8(data0, data1, data2, data3, data4, data5, data6, data7, selectInput, out);  // 8-16bit-input mux

	output reg [15:0] out;
	input  [15:0] data0, data1, data2, data3, data4, data5, data6, data7;
	input  [2:0] selectInput;
	
	always@(data0 or data1 or data2 or data3 or data4 or data5 or data6 or data7 or selectInput) begin
		case(selectInput)
			0: out = data0;
			1: out = data1;
			2: out = data2;
			3: out = data3;
			4: out = data4;
			5: out = data5;
			6: out = data6;
			7: out = data7;
		endcase
	end
	
endmodule

module mux16x1(data0,data1,selectinput,out);//2-16bit-input-mux

	input [15:0] data0,data1;
	input selectinput;
	output reg [15:0] out;

	always @(*) begin

		case (selectinput)
		0:
			out = data0;
		1:
			out = data1;
		default:
			out = data0;
		endcase

	end
	
endmodule

module mux16x2(data0,data1,data2,data3,selectinput,out);//used in mux 2,4,5,6,7
	input [15:0] data0,data1,data2,data3;
	input [1:0]selectinput;
	output reg [15:0] out;



	always @(*) begin
		case (selectinput)
		0:
			out = data0;
		1:
			out = data1;
		2:
			out = data2;
		3:
			out = data3;
		default:
			out = data0;
		endcase
	end
	
endmodule

`endif
