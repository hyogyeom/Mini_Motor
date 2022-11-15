`timescale 1ns / 1ps

module Motor_Divider_Setting(
    input i_clk,
    input i_reset,
    input i_set_SW,
    output o_clk_setting
    );

    reg r_clk_setting;
    reg[31:0] r_counter = 0;
    assign o_clk_setting = r_clk_setting;

    always @(posedge i_clk or posedge i_reset) begin
        if(!i_reset) begin
            r_clk_setting <= 1'b0;
            r_counter <= 0;
        end
        else begin
            if(r_counter == 50_000 - 1) begin
                r_counter <= 0;
                r_clk_setting <= ~r_clk_setting;
            end
            else begin
                r_counter <= r_counter + 1;
            end
        end  
    end
endmodule
