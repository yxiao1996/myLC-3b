module alu_test();

    reg clk;
    reg [2:0] op;
    wire [15:0] alu_out;
    wire zero, neg;

    alu alu1(16'h0001,
             16'h0002,
             op,
             alu_out,
             zero,
             neg);

    initial begin
      
    $dumpfile("alu_test.vcd");
    $dumpvars(0);
    clk = 0;
    op = 3'b000;

    end

    always begin

    #5
    clk <= ~clk;
    op <= op + 1;

    end

endmodule
