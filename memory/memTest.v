module memTest();

    reg [15:0] in;
    reg [15:0] addr;
    reg write;
    reg clk;
    reg ir14;
    reg reset;
    wire [15:0] out;
    wire [15:0] outir;

    mem16 mem(.reset(reset),
            .address(addr),
            .write(write),
            .clk(clk),
            .in(in),
            .out(out),
            .ir14(ir14),
            .outir(outir));

    initial begin 
        $dumpfile("memTest.vcd");
        $dumpvars(0);
        clk = 1;
        write = 0;
        ir14 = 0;
        reset = 0;
        in = 16'b111;
        addr = 16'b0;
        #5
        reset = 1;
    end

    always begin
        #5
        write = 0;
        #5 
        clk = 0;
        #5
        write = 1;
        #5
        clk = 1;

    end

endmodule