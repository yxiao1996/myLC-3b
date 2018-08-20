module lc3bTest();

    reg clk;
    reg reset;

    lc3b test(.clk(clk),
              .reset(reset));

    initial begin
        $dumpfile("lc3bTest.vcd");
        $dumpvars(0);
        clk = 0;
        reset = 0;
        #5
        reset = 1;
    end

    always begin
        #5
        clk = ~clk;
    end

endmodule