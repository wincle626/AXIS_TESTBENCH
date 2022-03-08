----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 14:11:40
-- Design Name: 
-- Module Name: axis_wrap - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity axis_wrap is
	port 
	(
		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add or delete. 
		ACLK	: in	std_logic;
		ARESETN	: in	std_logic;
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(31 downto 0);
		S_AXIS_TLAST	: in	std_logic;
		S_AXIS_TVALID	: in	std_logic;
		M_AXIS_TVALID	: out	std_logic;
		M_AXIS_TDATA	: out	std_logic_vector(31 downto 0);
		M_AXIS_TLAST	: out	std_logic;
		M_AXIS_TREADY	: in	std_logic;
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_local_block : out STD_LOGIC;
        ap_local_deadlock : out STD_LOGIC
	);
end axis_wrap;

architecture Behavioral of axis_wrap is

   
    signal ap_ctrl_done : STD_LOGIC;
    signal ap_ctrl_idle : STD_LOGIC;
    signal ap_ctrl_ready : STD_LOGIC;
    signal ap_ctrl_start : STD_LOGIC;
    signal output_r_tdata : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal output_r_tready : STD_LOGIC;
    signal output_r_tvalid : STD_LOGIC;
    signal input_r_tdata : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal input_r_tready : STD_LOGIC;
    signal input_r_tvalid : STD_LOGIC;
    
    component PIDS is
        port (
            ap_local_block : OUT STD_LOGIC;
            ap_local_deadlock : OUT STD_LOGIC;
            ap_clk : IN STD_LOGIC;
            ap_rst_n : IN STD_LOGIC;
            ap_start : IN STD_LOGIC;
            ap_done : OUT STD_LOGIC;
            ap_idle : OUT STD_LOGIC;
            ap_ready : OUT STD_LOGIC;
            inputs_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
            inputs_TVALID : IN STD_LOGIC;
            inputs_TREADY : OUT STD_LOGIC;
            outputs_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
            outputs_TVALID : OUT STD_LOGIC;
            outputs_TREADY : IN std_logic 
        );
    end component PIDS;

begin

    ap_ctrl_start <= '1';
--    ap_ctrl_start <= '0' when state = Idle else '1';
    ap_done <= ap_ctrl_done;
    ap_idle <= ap_ctrl_idle;
    ap_ready <= ap_ctrl_ready;
    bd_0_i: component PIDS
        port map (
            ap_local_block => ap_local_block,
            ap_local_deadlock => ap_local_deadlock,
            ap_clk => ACLK,
            ap_rst_n => ARESETN,
            ap_start => ap_ctrl_start,
            ap_done => ap_ctrl_done,
            ap_idle => ap_ctrl_idle,
            ap_ready => ap_ctrl_ready,
            inputs_TDATA(31 downto 0) => input_r_tdata(31 downto 0),
            inputs_TVALID => input_r_tvalid,
            inputs_TREADY => input_r_tready,
            outputs_TDATA(31 downto 0) => output_r_tdata(31 downto 0),
            outputs_TVALID => output_r_tvalid,
            outputs_TREADY => output_r_tready
    );
        
    input_r_tdata <= S_AXIS_TDATA when (S_AXIS_TVALID='1' and input_r_tready='1') else (others=>'0');
--    input_r_tdata <= S_AXIS_TDATA when (S_AXIS_TVALID='1' and input_r_tready='1');
    input_r_tvalid <= S_AXIS_TVALID;       
    S_AXIS_TREADY <= input_r_tready; 
    
    M_AXIS_TVALID <= output_r_tvalid;
    output_r_tready <= M_AXIS_TREADY;
--    M_AXIS_TDATA <= output_r_tdata when (output_r_tvalid='1' and M_AXIS_TREADY='1') else (others=>'0'); 
    M_AXIS_TDATA <= output_r_tdata when (output_r_tvalid='1' and M_AXIS_TREADY='1');  
    M_AXIS_TLAST <= ap_ctrl_done;
   

end Behavioral;
