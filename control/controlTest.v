module controlTest();

    reg clk;
    reg reset;
    reg N, P, Z, R;
    reg [15:0] IR;
    wire [1:0] aluop;
    wire LDCC, LDIR, LDREG;
    wire LDPC, LDMAR, LDMDR;
    wire MEMEN;

    control Control(.clk(clk),
                    .reset(reset),
                    .IR(IR),
                    .N(N), .P(P), .Z(Z), .R(R),
                    .aluop(aluop),
                    .LDCC(LDCC), .LDIR(LDIR),   .LDREG(LDREG),
                    .LDPC(LDPC), .LDMAR(LDMAR), .LDMDR(LDMDR),
                    .MEMEN(MEMEN));

    initial begin 
        $dumpfile("controlTest.vcd");
        $dumpvars(0);
        clk = 1;        
        reset = 0;
        IR = 16'b0;
        N = 1;
        P = 1;
        Z = 1;
        R = 1;

        #5
        reset = 1;
    end

    always begin
        #5
        clk = ~clk;
    end

endmodule