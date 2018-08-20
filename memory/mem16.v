`include "./memory/memLow.v"
`include "./memory/memHigh.v"

module mem16(reset,address, write,clk, in, out, ir14, outir, R);

    input [15:0] in;
    input [15:0] address;
    input write,clk,ir14,reset;
    output reg [15:0] out;
    output [15:0]outir;
    output reg R;

    reg wreven,wrodd;
    wire [7:0] outeven,outodd;
    reg [7:0] ineven,inodd;

    memLow even(.reset(reset),.addr(address[8:1]),.in(ineven),
                .out(outeven),.clk(clk),.write(wreven));
                
    memHigh odd(.reset(reset),.addr(address[8:1]),.in(inodd),
                .out(outodd),.clk(clk),.write(wrodd));

    always @(*) begin
        if (reset == 0)
            R = 1'b1;
    end

    //for in signals of individual memories
    always @(*) begin
        if(ir14==0) begin
            ineven<=in[7:0];
            inodd<=in[7:0];
        end 
        else begin
            ineven<= in[7:0];
            inodd<=in[15:8];
        end
    end
    //-----------------------------------------------
    assign outir[15:8]  = outodd;
    assign outir[7:0] = outeven;

    //for out signals of individual memories
    always @(*) begin
        if(ir14 ==1'b1) begin
            out[15:8]<=outodd;
            out[7:0]<=outeven;
        end
        else if(address[0]==0)
            begin
                out<= {{8{outeven[7]}},outeven[7:0]};
            end
        else 
            begin
                out<= {{8{outodd[7]}},outodd[7:0]};
            end
    end

    //-------------------------------------------------

    //for write signal

    always @(*) begin
        if(ir14==0&&address[0]==1'b1) begin
            wreven<=1'b1;
        end
        else begin
            wreven<=write;
        end
    end

    always @(*) begin
        if(ir14==0&&address[0]==1'b0) begin
            wrodd<=1'b1;
        end
        else begin
            wrodd<=write;
        end
    end

endmodule