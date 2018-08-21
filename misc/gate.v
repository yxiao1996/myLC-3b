module gate16(in, out, enable);

    input  [15:0] in;
    input         enable;
    output [15:0] out;

    bufif0 gate0(out[0], in[0], enable);
    bufif0 gate1(out[1], in[1], enable);
    bufif0 gate2(out[2], in[2], enable);
    bufif0 gate3(out[3], in[3], enable);
    bufif0 gate4(out[4], in[4], enable);
    bufif0 gate5(out[5], in[5], enable);
    bufif0 gate6(out[6], in[6], enable);
    bufif0 gate7(out[7], in[7], enable);
    bufif0 gate8(out[8], in[8], enable);
    bufif0 gate9(out[9], in[9], enable);
    bufif0 gate10(out[10], in[10], enable);
    bufif0 gate11(out[11], in[11], enable);
    bufif0 gate12(out[12], in[12], enable);
    bufif0 gate13(out[13], in[13], enable);
    bufif0 gate14(out[14], in[14], enable);
    bufif0 gate15(out[15], in[15], enable);

endmodule

module sext6(in,out);

    input [5:0] in;
    output[15:0] out;

    assign out= {{10{in[5]}},in[5:0]};

endmodule

module sext5(in,out);

    input [4:0] in;
    output[15:0] out;

    assign out= {{11{in[4]}},in[4:0]};

endmodule