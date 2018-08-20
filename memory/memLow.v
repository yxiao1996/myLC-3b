module memLow(clk, reset, write,
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
            mem[0] = 8'b11010000;
            mem[1] = 8'b11010010;
            mem[2] = 8'b00000001;
            mem[8] = 8'b00000001;
            mem[9] = 8'b00000010;
        end
        else begin
            if (write == 1'b0) 
                mem[addr] <= in;
        end
    end

endmodule