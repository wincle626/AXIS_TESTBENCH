-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1.3
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity wrapped_pgd_hw is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    INPUT_STREAM_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    INPUT_STREAM_TVALID : IN STD_LOGIC;
    INPUT_STREAM_TREADY : OUT STD_LOGIC;
    INPUT_STREAM_TKEEP : IN STD_LOGIC_VECTOR (3 downto 0);
    INPUT_STREAM_TSTRB : IN STD_LOGIC_VECTOR (3 downto 0);
    INPUT_STREAM_TUSER : IN STD_LOGIC_VECTOR (3 downto 0);
    INPUT_STREAM_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    INPUT_STREAM_TID : IN STD_LOGIC_VECTOR (4 downto 0);
    INPUT_STREAM_TDEST : IN STD_LOGIC_VECTOR (4 downto 0);
    OUTPUT_STREAM_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    OUTPUT_STREAM_TVALID : OUT STD_LOGIC;
    OUTPUT_STREAM_TREADY : IN STD_LOGIC;
    OUTPUT_STREAM_TKEEP : OUT STD_LOGIC_VECTOR (3 downto 0);
    OUTPUT_STREAM_TSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    OUTPUT_STREAM_TUSER : OUT STD_LOGIC_VECTOR (3 downto 0);
    OUTPUT_STREAM_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
    OUTPUT_STREAM_TID : OUT STD_LOGIC_VECTOR (4 downto 0);
    OUTPUT_STREAM_TDEST : OUT STD_LOGIC_VECTOR (4 downto 0) );
end;


architecture behav of wrapped_pgd_hw is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (5 downto 0) := "000010";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (5 downto 0) := "000100";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (5 downto 0) := "001000";
    constant ap_ST_fsm_pp1_stage0 : STD_LOGIC_VECTOR (5 downto 0) := "010000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (5 downto 0) := "100000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv4_F : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv5_10 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv5_1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_const_lv5_F : STD_LOGIC_VECTOR (4 downto 0) := "01111";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n : STD_LOGIC;
    signal INPUT_STREAM_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal icmp_ln87_reg_309 : STD_LOGIC_VECTOR (0 downto 0);
    signal OUTPUT_STREAM_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp1_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp1_stage0 : signal is "none";
    signal ap_enable_reg_pp1_iter1 : STD_LOGIC := '0';
    signal ap_block_pp1_stage0 : BOOLEAN;
    signal icmp_ln98_reg_318 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_0_reg_172 : STD_LOGIC_VECTOR (4 downto 0);
    signal i1_0_reg_184 : STD_LOGIC_VECTOR (4 downto 0);
    signal icmp_ln87_fu_259_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state2_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal i_fu_265_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal i_reg_313 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal icmp_ln98_fu_276_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state6_pp1_stage0_iter0 : BOOLEAN;
    signal ap_block_state7_pp1_stage0_iter1 : BOOLEAN;
    signal ap_block_state7_io : BOOLEAN;
    signal ap_block_pp1_stage0_11001 : BOOLEAN;
    signal i_1_fu_282_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_enable_reg_pp1_iter0 : STD_LOGIC := '0';
    signal icmp_ln101_fu_293_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln101_reg_332 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state2 : STD_LOGIC;
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal grp_pgd_f32_fu_195_ap_ready : STD_LOGIC;
    signal grp_pgd_f32_fu_195_ap_done : STD_LOGIC;
    signal ap_block_pp1_stage0_subdone : BOOLEAN;
    signal ap_condition_pp1_exit_iter0_state6 : STD_LOGIC;
    signal b_address0 : STD_LOGIC_VECTOR (3 downto 0);
    signal b_ce0 : STD_LOGIC;
    signal b_we0 : STD_LOGIC;
    signal b_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal x_address0 : STD_LOGIC_VECTOR (3 downto 0);
    signal x_ce0 : STD_LOGIC;
    signal x_we0 : STD_LOGIC;
    signal x_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_pgd_f32_fu_195_ap_start : STD_LOGIC;
    signal grp_pgd_f32_fu_195_ap_idle : STD_LOGIC;
    signal grp_pgd_f32_fu_195_y_address0 : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_pgd_f32_fu_195_y_ce0 : STD_LOGIC;
    signal grp_pgd_f32_fu_195_x_out_address0 : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_pgd_f32_fu_195_x_out_ce0 : STD_LOGIC;
    signal grp_pgd_f32_fu_195_x_out_we0 : STD_LOGIC;
    signal grp_pgd_f32_fu_195_x_out_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_s_pop_stream_fu_233_ap_start : STD_LOGIC;
    signal tmp_s_pop_stream_fu_233_ap_done : STD_LOGIC;
    signal tmp_s_pop_stream_fu_233_ap_idle : STD_LOGIC;
    signal tmp_s_pop_stream_fu_233_ap_ready : STD_LOGIC;
    signal tmp_s_pop_stream_fu_233_INPUT_STREAM_TREADY : STD_LOGIC;
    signal tmp_s_pop_stream_fu_233_ap_return : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_s_pop_stream_fu_233_ap_ce : STD_LOGIC;
    signal ap_block_state2_pp0_stage0_iter0_ignore_call3 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter1_ignore_call3 : BOOLEAN;
    signal ap_block_pp0_stage0_11001_ignoreCallOp22 : BOOLEAN;
    signal call_ret_push_stream_fu_252_ap_ready : STD_LOGIC;
    signal call_ret_push_stream_fu_252_ap_return_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal call_ret_push_stream_fu_252_ap_return_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_mux_i_0_phi_fu_176_p4 : STD_LOGIC_VECTOR (4 downto 0);
    signal grp_pgd_f32_fu_195_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal tmp_s_pop_stream_fu_233_ap_start_reg : STD_LOGIC := '0';
    signal zext_ln89_fu_271_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln101_fu_288_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp1_stage0_01001 : BOOLEAN;
    signal ap_CS_fsm_state8 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state8 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_idle_pp1 : STD_LOGIC;
    signal ap_enable_pp1 : STD_LOGIC;

    component pgd_f32 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        y_address0 : OUT STD_LOGIC_VECTOR (3 downto 0);
        y_ce0 : OUT STD_LOGIC;
        y_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        x_out_address0 : OUT STD_LOGIC_VECTOR (3 downto 0);
        x_out_ce0 : OUT STD_LOGIC;
        x_out_we0 : OUT STD_LOGIC;
        x_out_d0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component pop_stream IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        INPUT_STREAM_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
        INPUT_STREAM_TVALID : IN STD_LOGIC;
        INPUT_STREAM_TREADY : OUT STD_LOGIC;
        INPUT_STREAM_TKEEP : IN STD_LOGIC_VECTOR (3 downto 0);
        INPUT_STREAM_TSTRB : IN STD_LOGIC_VECTOR (3 downto 0);
        INPUT_STREAM_TUSER : IN STD_LOGIC_VECTOR (3 downto 0);
        INPUT_STREAM_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
        INPUT_STREAM_TID : IN STD_LOGIC_VECTOR (4 downto 0);
        INPUT_STREAM_TDEST : IN STD_LOGIC_VECTOR (4 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (31 downto 0);
        INPUT_STREAM_TDATA_blk_n : OUT STD_LOGIC;
        ap_ce : IN STD_LOGIC );
    end component;


    component push_stream IS
    port (
        ap_ready : OUT STD_LOGIC;
        v_read : IN STD_LOGIC_VECTOR (31 downto 0);
        last : IN STD_LOGIC_VECTOR (0 downto 0);
        ap_return_0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        ap_return_1 : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;


    component wrapped_pgd_hw_b IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (3 downto 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        q0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;



begin
    b_U : component wrapped_pgd_hw_b
    generic map (
        DataWidth => 32,
        AddressRange => 16,
        AddressWidth => 4)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => b_address0,
        ce0 => b_ce0,
        we0 => b_we0,
        d0 => tmp_s_pop_stream_fu_233_ap_return,
        q0 => b_q0);

    x_U : component wrapped_pgd_hw_b
    generic map (
        DataWidth => 32,
        AddressRange => 16,
        AddressWidth => 4)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => x_address0,
        ce0 => x_ce0,
        we0 => x_we0,
        d0 => grp_pgd_f32_fu_195_x_out_d0,
        q0 => x_q0);

    grp_pgd_f32_fu_195 : component pgd_f32
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_pgd_f32_fu_195_ap_start,
        ap_done => grp_pgd_f32_fu_195_ap_done,
        ap_idle => grp_pgd_f32_fu_195_ap_idle,
        ap_ready => grp_pgd_f32_fu_195_ap_ready,
        y_address0 => grp_pgd_f32_fu_195_y_address0,
        y_ce0 => grp_pgd_f32_fu_195_y_ce0,
        y_q0 => b_q0,
        x_out_address0 => grp_pgd_f32_fu_195_x_out_address0,
        x_out_ce0 => grp_pgd_f32_fu_195_x_out_ce0,
        x_out_we0 => grp_pgd_f32_fu_195_x_out_we0,
        x_out_d0 => grp_pgd_f32_fu_195_x_out_d0);

    tmp_s_pop_stream_fu_233 : component pop_stream
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => tmp_s_pop_stream_fu_233_ap_start,
        ap_done => tmp_s_pop_stream_fu_233_ap_done,
        ap_idle => tmp_s_pop_stream_fu_233_ap_idle,
        ap_ready => tmp_s_pop_stream_fu_233_ap_ready,
        INPUT_STREAM_TDATA => INPUT_STREAM_TDATA,
        INPUT_STREAM_TVALID => INPUT_STREAM_TVALID,
        INPUT_STREAM_TREADY => tmp_s_pop_stream_fu_233_INPUT_STREAM_TREADY,
        INPUT_STREAM_TKEEP => INPUT_STREAM_TKEEP,
        INPUT_STREAM_TSTRB => INPUT_STREAM_TSTRB,
        INPUT_STREAM_TUSER => INPUT_STREAM_TUSER,
        INPUT_STREAM_TLAST => INPUT_STREAM_TLAST,
        INPUT_STREAM_TID => INPUT_STREAM_TID,
        INPUT_STREAM_TDEST => INPUT_STREAM_TDEST,
        ap_return => tmp_s_pop_stream_fu_233_ap_return,
        INPUT_STREAM_TDATA_blk_n => tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n,
        ap_ce => tmp_s_pop_stream_fu_233_ap_ce);

    call_ret_push_stream_fu_252 : component push_stream
    port map (
        ap_ready => call_ret_push_stream_fu_252_ap_ready,
        v_read => x_q0,
        last => icmp_ln101_reg_332,
        ap_return_0 => call_ret_push_stream_fu_252_ap_return_0,
        ap_return_1 => call_ret_push_stream_fu_252_ap_return_1);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state2) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state2) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then 
                    ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state2);
                elsif ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp1_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp1_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_const_logic_1 = ap_condition_pp1_exit_iter0_state6) and (ap_const_boolean_0 = ap_block_pp1_stage0_subdone))) then 
                    ap_enable_reg_pp1_iter0 <= ap_const_logic_0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_pgd_f32_fu_195_ap_done = ap_const_logic_1))) then 
                    ap_enable_reg_pp1_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp1_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp1_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_condition_pp1_exit_iter0_state6) and (ap_const_boolean_0 = ap_block_pp1_stage0_subdone))) then 
                    ap_enable_reg_pp1_iter1 <= (ap_const_logic_1 xor ap_condition_pp1_exit_iter0_state6);
                elsif ((ap_const_boolean_0 = ap_block_pp1_stage0_subdone)) then 
                    ap_enable_reg_pp1_iter1 <= ap_enable_reg_pp1_iter0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_pgd_f32_fu_195_ap_done = ap_const_logic_1))) then 
                    ap_enable_reg_pp1_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    grp_pgd_f32_fu_195_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_pgd_f32_fu_195_ap_start_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
                    grp_pgd_f32_fu_195_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_pgd_f32_fu_195_ap_ready = ap_const_logic_1)) then 
                    grp_pgd_f32_fu_195_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    tmp_s_pop_stream_fu_233_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                tmp_s_pop_stream_fu_233_ap_start_reg <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln87_fu_259_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    tmp_s_pop_stream_fu_233_ap_start_reg <= ap_const_logic_1;
                elsif ((tmp_s_pop_stream_fu_233_ap_ready = ap_const_logic_1)) then 
                    tmp_s_pop_stream_fu_233_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i1_0_reg_184_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln98_fu_276_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then 
                i1_0_reg_184 <= i_1_fu_282_p2;
            elsif (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_pgd_f32_fu_195_ap_done = ap_const_logic_1))) then 
                i1_0_reg_184 <= ap_const_lv5_0;
            end if; 
        end if;
    end process;

    i_0_reg_172_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln87_reg_309 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                i_0_reg_172 <= i_reg_313;
            elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                i_0_reg_172 <= ap_const_lv5_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                i_reg_313 <= i_fu_265_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln98_fu_276_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then
                icmp_ln101_reg_332 <= icmp_ln101_fu_293_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln87_reg_309 <= icmp_ln87_fu_259_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then
                icmp_ln98_reg_318 <= icmp_ln98_fu_276_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, icmp_ln87_fu_259_p2, ap_enable_reg_pp0_iter0, icmp_ln98_fu_276_p2, ap_enable_reg_pp1_iter0, ap_block_pp0_stage0_subdone, ap_CS_fsm_state5, grp_pgd_f32_fu_195_ap_done, ap_block_pp1_stage0_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if (not(((icmp_ln87_fu_259_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone)))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif (((icmp_ln87_fu_259_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_pgd_f32_fu_195_ap_done = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when ap_ST_fsm_pp1_stage0 => 
                if (not(((icmp_ln98_fu_276_p2 = ap_const_lv1_1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_subdone)))) then
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage0;
                elsif (((icmp_ln98_fu_276_p2 = ap_const_lv1_1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_state8;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage0;
                end if;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXXX";
        end case;
    end process;

    INPUT_STREAM_TDATA_blk_n_assign_proc : process(tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln87_reg_309)
    begin
        if (((icmp_ln87_reg_309 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            INPUT_STREAM_TDATA_blk_n <= tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n;
        else 
            INPUT_STREAM_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    INPUT_STREAM_TREADY_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln87_reg_309, tmp_s_pop_stream_fu_233_INPUT_STREAM_TREADY)
    begin
        if (((icmp_ln87_reg_309 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            INPUT_STREAM_TREADY <= tmp_s_pop_stream_fu_233_INPUT_STREAM_TREADY;
        else 
            INPUT_STREAM_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    OUTPUT_STREAM_TDATA <= call_ret_push_stream_fu_252_ap_return_0;

    OUTPUT_STREAM_TDATA_blk_n_assign_proc : process(OUTPUT_STREAM_TREADY, ap_CS_fsm_pp1_stage0, ap_enable_reg_pp1_iter1, ap_block_pp1_stage0, icmp_ln98_reg_318)
    begin
        if (((ap_const_boolean_0 = ap_block_pp1_stage0) and (icmp_ln98_reg_318 = ap_const_lv1_0) and (ap_enable_reg_pp1_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage0))) then 
            OUTPUT_STREAM_TDATA_blk_n <= OUTPUT_STREAM_TREADY;
        else 
            OUTPUT_STREAM_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    OUTPUT_STREAM_TDEST <= ap_const_lv5_0;
    OUTPUT_STREAM_TID <= ap_const_lv5_0;
    OUTPUT_STREAM_TKEEP <= ap_const_lv4_F;
    OUTPUT_STREAM_TLAST <= call_ret_push_stream_fu_252_ap_return_1;
    OUTPUT_STREAM_TSTRB <= ap_const_lv4_F;
    OUTPUT_STREAM_TUSER <= ap_const_lv4_0;

    OUTPUT_STREAM_TVALID_assign_proc : process(ap_CS_fsm_pp1_stage0, ap_enable_reg_pp1_iter1, icmp_ln98_reg_318, ap_block_pp1_stage0_11001)
    begin
        if (((icmp_ln98_reg_318 = ap_const_lv1_0) and (ap_enable_reg_pp1_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then 
            OUTPUT_STREAM_TVALID <= ap_const_logic_1;
        else 
            OUTPUT_STREAM_TVALID <= ap_const_logic_0;
        end if; 
    end process;

    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1);
    ap_CS_fsm_pp1_stage0 <= ap_CS_fsm(4);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state4 <= ap_CS_fsm(2);
    ap_CS_fsm_state5 <= ap_CS_fsm(3);
    ap_CS_fsm_state8 <= ap_CS_fsm(5);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_11001_assign_proc : process(tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n, ap_enable_reg_pp0_iter1, icmp_ln87_reg_309)
    begin
                ap_block_pp0_stage0_11001 <= ((icmp_ln87_reg_309 = ap_const_lv1_0) and (tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;

        ap_block_pp0_stage0_11001_ignoreCallOp22 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_subdone_assign_proc : process(tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n, ap_enable_reg_pp0_iter1, icmp_ln87_reg_309)
    begin
                ap_block_pp0_stage0_subdone <= ((icmp_ln87_reg_309 = ap_const_lv1_0) and (tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;

        ap_block_pp1_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp1_stage0_01001 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp1_stage0_11001_assign_proc : process(ap_enable_reg_pp1_iter1, ap_block_state7_io)
    begin
                ap_block_pp1_stage0_11001 <= ((ap_enable_reg_pp1_iter1 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state7_io));
    end process;


    ap_block_pp1_stage0_subdone_assign_proc : process(ap_enable_reg_pp1_iter1, ap_block_state7_io)
    begin
                ap_block_pp1_stage0_subdone <= ((ap_enable_reg_pp1_iter1 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state7_io));
    end process;

        ap_block_state2_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter0_ignore_call3 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state3_pp0_stage0_iter1_assign_proc : process(tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n, icmp_ln87_reg_309)
    begin
                ap_block_state3_pp0_stage0_iter1 <= ((icmp_ln87_reg_309 = ap_const_lv1_0) and (tmp_s_pop_stream_fu_233_INPUT_STREAM_TDATA_blk_n = ap_const_logic_0));
    end process;

        ap_block_state3_pp0_stage0_iter1_ignore_call3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp1_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state7_io_assign_proc : process(OUTPUT_STREAM_TREADY, icmp_ln98_reg_318)
    begin
                ap_block_state7_io <= ((icmp_ln98_reg_318 = ap_const_lv1_0) and (ap_const_logic_0 = OUTPUT_STREAM_TREADY));
    end process;

        ap_block_state7_pp1_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_pp0_exit_iter0_state2_assign_proc : process(icmp_ln87_fu_259_p2)
    begin
        if ((icmp_ln87_fu_259_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_condition_pp1_exit_iter0_state6_assign_proc : process(icmp_ln98_fu_276_p2)
    begin
        if ((icmp_ln98_fu_276_p2 = ap_const_lv1_1)) then 
            ap_condition_pp1_exit_iter0_state6 <= ap_const_logic_1;
        else 
            ap_condition_pp1_exit_iter0_state6 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state8)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state8) or ((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_pp1 <= (ap_idle_pp1 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter0)
    begin
        if (((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp1_assign_proc : process(ap_enable_reg_pp1_iter1, ap_enable_reg_pp1_iter0)
    begin
        if (((ap_enable_reg_pp1_iter1 = ap_const_logic_0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_0))) then 
            ap_idle_pp1 <= ap_const_logic_1;
        else 
            ap_idle_pp1 <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_i_0_phi_fu_176_p4_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln87_reg_309, i_0_reg_172, i_reg_313)
    begin
        if (((icmp_ln87_reg_309 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_phi_mux_i_0_phi_fu_176_p4 <= i_reg_313;
        else 
            ap_phi_mux_i_0_phi_fu_176_p4 <= i_0_reg_172;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state8)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state8)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    b_address0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, ap_CS_fsm_state5, grp_pgd_f32_fu_195_y_address0, zext_ln89_fu_271_p1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            b_address0 <= zext_ln89_fu_271_p1(4 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            b_address0 <= grp_pgd_f32_fu_195_y_address0;
        else 
            b_address0 <= "XXXX";
        end if; 
    end process;


    b_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001, ap_CS_fsm_state5, grp_pgd_f32_fu_195_y_ce0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            b_ce0 <= ap_const_logic_1;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            b_ce0 <= grp_pgd_f32_fu_195_y_ce0;
        else 
            b_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    b_we0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, icmp_ln87_reg_309, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln87_reg_309 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            b_we0 <= ap_const_logic_1;
        else 
            b_we0 <= ap_const_logic_0;
        end if; 
    end process;

    grp_pgd_f32_fu_195_ap_start <= grp_pgd_f32_fu_195_ap_start_reg;
    i_1_fu_282_p2 <= std_logic_vector(unsigned(i1_0_reg_184) + unsigned(ap_const_lv5_1));
    i_fu_265_p2 <= std_logic_vector(unsigned(ap_phi_mux_i_0_phi_fu_176_p4) + unsigned(ap_const_lv5_1));
    icmp_ln101_fu_293_p2 <= "1" when (i1_0_reg_184 = ap_const_lv5_F) else "0";
    icmp_ln87_fu_259_p2 <= "1" when (ap_phi_mux_i_0_phi_fu_176_p4 = ap_const_lv5_10) else "0";
    icmp_ln98_fu_276_p2 <= "1" when (i1_0_reg_184 = ap_const_lv5_10) else "0";

    tmp_s_pop_stream_fu_233_ap_ce_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001_ignoreCallOp22)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001_ignoreCallOp22) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            tmp_s_pop_stream_fu_233_ap_ce <= ap_const_logic_1;
        else 
            tmp_s_pop_stream_fu_233_ap_ce <= ap_const_logic_0;
        end if; 
    end process;

    tmp_s_pop_stream_fu_233_ap_start <= tmp_s_pop_stream_fu_233_ap_start_reg;

    x_address0_assign_proc : process(ap_CS_fsm_pp1_stage0, ap_block_pp1_stage0, ap_enable_reg_pp1_iter0, ap_CS_fsm_state5, grp_pgd_f32_fu_195_x_out_address0, zext_ln101_fu_288_p1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp1_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1))) then 
            x_address0 <= zext_ln101_fu_288_p1(4 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            x_address0 <= grp_pgd_f32_fu_195_x_out_address0;
        else 
            x_address0 <= "XXXX";
        end if; 
    end process;


    x_ce0_assign_proc : process(ap_CS_fsm_pp1_stage0, ap_block_pp1_stage0_11001, ap_enable_reg_pp1_iter0, ap_CS_fsm_state5, grp_pgd_f32_fu_195_x_out_ce0)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then 
            x_ce0 <= ap_const_logic_1;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            x_ce0 <= grp_pgd_f32_fu_195_x_out_ce0;
        else 
            x_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    x_we0_assign_proc : process(ap_CS_fsm_state5, grp_pgd_f32_fu_195_x_out_we0)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            x_we0 <= grp_pgd_f32_fu_195_x_out_we0;
        else 
            x_we0 <= ap_const_logic_0;
        end if; 
    end process;

    zext_ln101_fu_288_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i1_0_reg_184),64));
    zext_ln89_fu_271_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_0_reg_172),64));
end behav;