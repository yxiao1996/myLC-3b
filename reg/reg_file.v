`ifndef _REGFILE
`define _REGFILE
`include "./misc/mux.v"
`include "./misc/demux.v"
`include "./reg/register.v"

module reg_file(clk,
                readAddr1, readAddr2, writeAddr,
                write, reset,
                in,
                out1, out2);

    output [15:0] out1, out2;
    input  [15:0] in;
    input  [2:0]  readAddr1, readAddr2, writeAddr;
    input         write, clk, reset;

    wire   [15:0]
                  data0, data1, data2, data3,
                  data4, data5, data6, data7;

    wire   [7:0]  writeLinesInit, writeLines;

    demux8  dem(writeAddr, writeLinesInit);

    mux16x8 mux1(data0, data1, data2, data3, data4, data5, data6, data7,
                 readAddr1, out1);

    mux16x8 mux2(data0, data1, data2, data3, data4, data5, data6, data7,
                 readAddr2, out2);

    or a0(writeLines[0], write, ~writeLinesInit[0]);
	or a1(writeLines[1], write, ~writeLinesInit[1]);
	or a2(writeLines[2], write, ~writeLinesInit[2]);
	or a3(writeLines[3], write, ~writeLinesInit[3]);
	or a4(writeLines[4], write, ~writeLinesInit[4]);
	or a5(writeLines[5], write, ~writeLinesInit[5]);
	or a6(writeLines[6], write, ~writeLinesInit[6]);
	or a7(writeLines[7], write, ~writeLinesInit[7]);
	
	register16 r0(clk, data0, in, writeLines[0], reset);
	register16 r1(clk, data1, in, writeLines[1], reset);
	register16 r2(clk, data2, in, writeLines[2], reset);
	register16 r3(clk, data3, in, writeLines[3], reset);
	register16 r4(clk, data4, in, writeLines[4], reset);
	register16 r5(clk, data5, in, writeLines[5], reset);
	register16 r6(clk, data6, in, writeLines[6], reset);
	register16 r7(clk, data7, in, writeLines[7], reset);
	
endmodule

`endif
