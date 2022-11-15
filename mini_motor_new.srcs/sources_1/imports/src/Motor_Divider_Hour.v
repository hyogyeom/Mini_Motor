`timescale 1ns / 1ps

module Motor_Divider_Hour(
    input i_clk,
    input i_reset,
    output o_clk_hour
    );

    reg r_clk_hour;
    reg[31:0] r_counter = 0;
    assign o_clk_hour = r_clk_hour;

    always @(posedge i_clk or posedge i_reset) begin
        if(!i_reset) begin
            r_clk_hour <= 1'b0;
            r_counter <= 0;
        end
        else begin
            if(r_counter == 1_080_000_000 - 1) begin
                r_counter <= 0;
                r_clk_hour <= ~r_clk_hour;
            end
            else begin
                r_counter <= r_counter + 1;
            end
        end  
    end
endmodule
