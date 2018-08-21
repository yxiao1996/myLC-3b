module memHigh(clk, reset, write,
               addr, in, out);

    input [7:0]      in;
    input [7:0]      addr;
    input            clk;
    input            reset;
    input            write;
    output reg [7:0] out;
    integer          i;

    reg [7:0] mem [0:255];

    always @(negedge clk) begin
        out = mem[addr];
        if (reset == 1'b0) begin
            for (i = 0; i < 256; i = i + 1)
                mem[i] = 0;
            // specify initial commands here
            mem[0] = 8'b01100001;  // read data at mem[8] into reg0 / ldw reg0, [8]
            mem[1] = 8'b01100011;  // read data at mem[9] into reg1 / ldw reg1, [9]
            mem[2] = 8'b00010100;  // add data in reg0 and reg1, then store in reg2 / add reg2, reg0, reg1
            mem[3] = 8'b01010100;  // reg 1 and 0001 store in reg2 / add reg2, 0001
            mem[4] = 8'b11000001;
            mem[8] = 8'b00000001;
            mem[9] = 8'b00000010;
        end
        else begin
            if (write == 1'b0) 
                mem[addr] <= in;
        end
    end

endmodule