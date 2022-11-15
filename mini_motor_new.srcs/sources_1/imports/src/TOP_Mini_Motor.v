`timescale 1ns / 1ps

module TOP_Mini_Motor(
    input i_clk,
    input i_reset,
    input [2:0]i_enable,   // on/off
    input i_ms1,      // Half/ Full
    input i_dir_mode, // direction
    input i_set_SW,
    output[3:0] o_motor_0,
    output[3:0] o_motor_1,
    output[3:0] o_motor_2
    );

    wire w_clk_sec;
    Motor_Divider_Sec Motor_Divider_Sec(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk_sec(w_clk_sec)
    );

    wire w_clk_min;
    Motor_Divider_Min Motor_Divider_Min(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk_min(w_clk_min)
    );

    wire w_clk_hour;
    Motor_Divider_Hour Motor_Divider_Hour(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk_hour(w_clk_hour)
    );

    wire w_clk_setting;
    Motor_Divider_Setting Motor_Divider_Setting(
    .i_clk(i_clk),
    .i_set_SW(i_set_SW),
    .i_reset(i_reset),
    .o_clk_setting(w_clk_setting)
    );

    wire w_clk;
    MUX_2x1 MUX_2x1_0(
    .i_clk(w_clk_sec),
    .i_clk_setting(w_clk_setting),
    .i_sel(i_set_SW),
    .o_clk(w_clk_0)
    );

    MUX_2x1 MUX_2x1_1(
    .i_clk(w_clk_min),
    .i_clk_setting(w_clk_setting),
    .i_sel(i_set_SW),
    .o_clk(w_clk_1)
    );

    MUX_2x1 MUX_2x1_2(
    .i_clk(w_clk_hour),
    .i_clk_setting(w_clk_setting),
    .i_sel(i_set_SW),
    .o_clk(w_clk_2)
    );

    Stepmotor Stepmotor_0(
    .i_clk(w_clk_0),
    .i_reset(i_reset),
    .i_enable(i_enable[0]),
    .i_ms1(i_ms1),
    .i_dir_mode(i_dir_mode),
    .o_motor(o_motor_0)
    );

    Stepmotor Stepmotor_1(
    .i_clk(w_clk_1),
    .i_reset(i_reset),
    .i_enable(i_enable[1]),
    .i_ms1(i_ms1),
    .i_dir_mode(i_dir_mode),
    .o_motor(o_motor_1)
    );

    Stepmotor Stepmotor_2(
    .i_clk(w_clk_2),
    .i_reset(i_reset),
    .i_enable(i_enable[2]),
    .i_ms1(i_ms1),
    .i_dir_mode(i_dir_mode),
    .o_motor(o_motor_2)
    );
endmodule
