-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1.3
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VEC_SUB_float_16_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    V1_address0 : OUT STD_LOGIC_VECTOR (3 downto 0);
    V1_ce0 : OUT STD_LOGIC;
    V1_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    V2_address0 : OUT STD_LOGIC_VECTOR (3 downto 0);
    V2_ce0 : OUT STD_LOGIC;
    V2_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    V3_address0 : OUT STD_LOGIC_VECTOR (3 downto 0);
    V3_ce0 : OUT STD_LOGIC;
    V3_we0 : OUT STD_LOGIC;
    V3_d0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of VEC_SUB_float_16_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_ST_fsm_state15 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_lv5_10 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv5_1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (2 downto 0) := "001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal i_0_reg_77 : STD_LOGIC_VECTOR (4 downto 0);
    signal icmp_ln148_fu_92_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_state2_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter4 : BOOLEAN;
    signal ap_block_state7_pp0_stage0_iter5 : BOOLEAN;
    signal ap_block_state8_pp0_stage0_iter6 : BOOLEAN;
    signal ap_block_state9_pp0_stage0_iter7 : BOOLEAN;
    signal ap_block_state10_pp0_stage0_iter8 : BOOLEAN;
    signal ap_block_state11_pp0_stage0_iter9 : BOOLEAN;
    signal ap_block_state12_pp0_stage0_iter10 : BOOLEAN;
    signal ap_block_state13_pp0_stage0_iter11 : BOOLEAN;
    signal ap_block_state14_pp0_stage0_iter12 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal icmp_ln148_reg_110_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter3_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter5_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter6_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter7_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter8_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter9_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter10_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln148_reg_110_pp0_iter11_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal i_fu_98_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal zext_ln150_fu_104_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter1_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter2_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter3_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter4_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter5_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter6_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter7_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter8_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter9_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter10_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln150_reg_119_pp0_iter11_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal a_val_reg_134 : STD_LOGIC_VECTOR (31 downto 0);
    signal b_val_reg_139 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_88_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_reg_144 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state2 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter4 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter5 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter6 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter7 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter8 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter9 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter10 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter11 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter12 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_CS_fsm_state15 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state15 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;

    component HLS_accel_fsub_32dEe IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;



begin
    HLS_accel_fsub_32dEe_U48 : component HLS_accel_fsub_32dEe
    generic map (
        ID => 1,
        NUM_STAGE => 10,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => a_val_reg_134,
        din1 => b_val_reg_139,
        ce => ap_const_logic_1,
        dout => grp_fu_88_p2);





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
                elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
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
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then
                    if ((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state2)) then 
                        ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state2);
                    elsif ((ap_const_boolean_1 = ap_const_boolean_1)) then 
                        ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                    end if;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter10_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter10 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter10 <= ap_enable_reg_pp0_iter9;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter11_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter11 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter11 <= ap_enable_reg_pp0_iter10;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter12_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter12 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter12 <= ap_enable_reg_pp0_iter11;
                elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_enable_reg_pp0_iter12 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter4_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter4 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter5_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter5 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter6_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter7_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter7 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter8_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter8 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter8 <= ap_enable_reg_pp0_iter7;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter9_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter9 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter9 <= ap_enable_reg_pp0_iter8;
                end if; 
            end if;
        end if;
    end process;


    i_0_reg_77_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln148_fu_92_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                i_0_reg_77 <= i_fu_98_p2;
            elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_0_reg_77 <= ap_const_lv5_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln148_reg_110 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                a_val_reg_134 <= V1_q0;
                b_val_reg_139 <= V2_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln148_reg_110 <= icmp_ln148_fu_92_p2;
                icmp_ln148_reg_110_pp0_iter1_reg <= icmp_ln148_reg_110;
                    zext_ln150_reg_119_pp0_iter1_reg(4 downto 0) <= zext_ln150_reg_119(4 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                icmp_ln148_reg_110_pp0_iter10_reg <= icmp_ln148_reg_110_pp0_iter9_reg;
                icmp_ln148_reg_110_pp0_iter11_reg <= icmp_ln148_reg_110_pp0_iter10_reg;
                icmp_ln148_reg_110_pp0_iter2_reg <= icmp_ln148_reg_110_pp0_iter1_reg;
                icmp_ln148_reg_110_pp0_iter3_reg <= icmp_ln148_reg_110_pp0_iter2_reg;
                icmp_ln148_reg_110_pp0_iter4_reg <= icmp_ln148_reg_110_pp0_iter3_reg;
                icmp_ln148_reg_110_pp0_iter5_reg <= icmp_ln148_reg_110_pp0_iter4_reg;
                icmp_ln148_reg_110_pp0_iter6_reg <= icmp_ln148_reg_110_pp0_iter5_reg;
                icmp_ln148_reg_110_pp0_iter7_reg <= icmp_ln148_reg_110_pp0_iter6_reg;
                icmp_ln148_reg_110_pp0_iter8_reg <= icmp_ln148_reg_110_pp0_iter7_reg;
                icmp_ln148_reg_110_pp0_iter9_reg <= icmp_ln148_reg_110_pp0_iter8_reg;
                    zext_ln150_reg_119_pp0_iter10_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter9_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter11_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter10_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter2_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter1_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter3_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter2_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter4_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter3_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter5_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter4_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter6_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter5_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter7_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter6_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter8_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter7_reg(4 downto 0);
                    zext_ln150_reg_119_pp0_iter9_reg(4 downto 0) <= zext_ln150_reg_119_pp0_iter8_reg(4 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln148_reg_110_pp0_iter10_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp_reg_144 <= grp_fu_88_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln148_fu_92_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                    zext_ln150_reg_119(4 downto 0) <= zext_ln150_fu_104_p1(4 downto 0);
            end if;
        end if;
    end process;
    zext_ln150_reg_119(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter1_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter2_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter3_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter4_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter5_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter6_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter7_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter8_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter9_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter10_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";
    zext_ln150_reg_119_pp0_iter11_reg(63 downto 5) <= "00000000000000000000000000000000000000000000000000000000000";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, icmp_ln148_fu_92_p2, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter11, ap_enable_reg_pp0_iter12)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((icmp_ln148_fu_92_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) and not(((ap_enable_reg_pp0_iter12 = ap_const_logic_1) and (ap_enable_reg_pp0_iter11 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((((icmp_ln148_fu_92_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) or ((ap_enable_reg_pp0_iter12 = ap_const_logic_1) and (ap_enable_reg_pp0_iter11 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone)))) then
                    ap_NS_fsm <= ap_ST_fsm_state15;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state15 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXX";
        end case;
    end process;
    V1_address0 <= zext_ln150_fu_104_p1(4 - 1 downto 0);

    V1_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            V1_ce0 <= ap_const_logic_1;
        else 
            V1_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    V2_address0 <= zext_ln150_fu_104_p1(4 - 1 downto 0);

    V2_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            V2_ce0 <= ap_const_logic_1;
        else 
            V2_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    V3_address0 <= zext_ln150_reg_119_pp0_iter11_reg(4 - 1 downto 0);

    V3_ce0_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter12)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter12 = ap_const_logic_1))) then 
            V3_ce0 <= ap_const_logic_1;
        else 
            V3_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    V3_d0 <= tmp_reg_144;

    V3_we0_assign_proc : process(ap_block_pp0_stage0_11001, icmp_ln148_reg_110_pp0_iter11_reg, ap_enable_reg_pp0_iter12)
    begin
        if (((icmp_ln148_reg_110_pp0_iter11_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter12 = ap_const_logic_1))) then 
            V3_we0 <= ap_const_logic_1;
        else 
            V3_we0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state15 <= ap_CS_fsm(2);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state10_pp0_stage0_iter8 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state11_pp0_stage0_iter9 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state12_pp0_stage0_iter10 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state13_pp0_stage0_iter11 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state14_pp0_stage0_iter12 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage0_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state7_pp0_stage0_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state8_pp0_stage0_iter6 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state9_pp0_stage0_iter7 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_pp0_exit_iter0_state2_assign_proc : process(icmp_ln148_fu_92_p2)
    begin
        if ((icmp_ln148_fu_92_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state15)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state15) or ((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6, ap_enable_reg_pp0_iter7, ap_enable_reg_pp0_iter8, ap_enable_reg_pp0_iter9, ap_enable_reg_pp0_iter10, ap_enable_reg_pp0_iter11, ap_enable_reg_pp0_iter12)
    begin
        if (((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter12 = ap_const_logic_0) and (ap_enable_reg_pp0_iter11 = ap_const_logic_0) and (ap_enable_reg_pp0_iter10 = ap_const_logic_0) and (ap_enable_reg_pp0_iter9 = ap_const_logic_0) and (ap_enable_reg_pp0_iter8 = ap_const_logic_0) and (ap_enable_reg_pp0_iter7 = ap_const_logic_0) and (ap_enable_reg_pp0_iter6 = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_0) and (ap_enable_reg_pp0_iter4 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state15)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state15)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    i_fu_98_p2 <= std_logic_vector(unsigned(i_0_reg_77) + unsigned(ap_const_lv5_1));
    icmp_ln148_fu_92_p2 <= "1" when (i_0_reg_77 = ap_const_lv5_10) else "0";
    zext_ln150_fu_104_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_0_reg_77),64));
end behav;
