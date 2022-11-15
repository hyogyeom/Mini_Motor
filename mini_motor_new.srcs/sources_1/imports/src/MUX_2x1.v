`timescale 1ns / 1ps

module MUX_2x1(
    input i_clk,  // ssec, mmin, hour CLK
    input i_clk_setting,  // 50_000 CLK
    input i_sel,
    output o_clk
    );

    reg[31:0] r_clk;
    assign o_clk = r_clk;

    always @(*) begin
        case(i_sel)
            1'b0 : r_clk <= i_clk;
            1'b1 : r_clk <= i_clk_setting;
        endcase
    end
endmodule
