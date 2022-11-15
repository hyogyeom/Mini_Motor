`timescale 1ns / 1ps

module Motor_Divider_Min(
    input i_clk,
    input i_reset,
    output o_clk_min
    );

    reg r_clk_min;
    reg[31:0] r_counter = 0;
    assign o_clk_min = r_clk_min;

    always @(posedge i_clk or posedge i_reset) begin
        if(!i_reset) begin
            r_clk_min <= 1'b0;
            r_counter <= 0;
        end
        else begin
            if(r_counter == 45_000_000 - 1) begin
                r_counter <= 0;
                r_clk_min <= ~r_clk_min;
            end
            else begin
                r_counter <= r_counter + 1;
            end
        end  
    end
endmodule
