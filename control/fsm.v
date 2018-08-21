module fsm(clk, reset, stateID, IR,
           R,
           MuxALU, MuxAddr1, MuxAddr2, MuxPC);

    input            clk;
    input            reset;
    input            R;
    input  [15:0]    IR;
    output reg [5:0] stateID;
    output reg MuxALU, MuxAddr1;
    output reg [1:0] MuxAddr2, MuxPC;

    reg [5:0] nextState;

    always @(posedge clk) begin
      
        if(reset == 0)
            stateID <= 6'b010010;
        else
            stateID <= nextState;

    end

    always @(*) begin

        if(reset == 1) begin
            case(stateID)
                18: begin
                    nextState = 19;
                    MuxALU <= 0;
                    MuxAddr1 <= 0;
                    MuxAddr2 <= 0;
                    MuxPC <= 0;
                end
                19: nextState = 33;
                33: 
                    if (R == 1)
                        nextState = 35;
                    else
                        nextState = 33;
                35: nextState = 32;
                32: begin
                    if (IR[15:12] == 4'b0001)
                        nextState <= 1; // add
                    else if (IR[15:12] == 4'b0101)
                        nextState <= 5;
                    else if (IR[15:12] == 4'b0110)
                        nextState <= 6; // load word
                    else if (IR[15:12] == 4'b1100)
                        nextState <= 12;
                    else
                        nextState <= 18;
                end
                1:  begin // add
                    if (IR[5] == 0)
                        MuxALU <= 0;
                    else
                        MuxALU <= 1;
                    nextState = 18;
                end
                5:  begin // and
                    if (IR[5] == 0)
                        MuxALU <= 0;
                    else
                        MuxALU <= 1;
                    nextState <= 18;
                end
                6:  nextState <= 25;
                12: begin  //jump
                    MuxAddr2 <= 2;
                    MuxAddr1 <= 1;
                    MuxPC <= 2;
                    nextState <=18; 
                end
                25: nextState <= 27;
                27: nextState <= 18;
                default:
                    nextState = 18;
            endcase
        end
    end

endmodule