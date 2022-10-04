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
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
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
		M_AXIS_TREADY	: in	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
end axis_wrap;

architecture Behavioral of axis_wrap is

   
    signal ap_ctrl_done : STD_LOGIC;
--    signal ap_ctrl_done_delay : STD_LOGIC;
    signal ap_ctrl_idle : STD_LOGIC;
    signal ap_ctrl_ready : STD_LOGIC;
    signal ap_ctrl_start : STD_LOGIC;
    signal output_r_tdata : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal output_r_tready : STD_LOGIC;
    signal output_r_tvalid : STD_LOGIC;
    signal input_r_tdata : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
    signal input_r_tready : STD_LOGIC;
    signal input_r_tvalid : STD_LOGIC;
    
    component pgdstr is
        port (
            ap_clk : IN STD_LOGIC;
            ap_rst_n : IN STD_LOGIC;
            ap_start : IN STD_LOGIC;
            ap_done : OUT STD_LOGIC;
            ap_idle : OUT STD_LOGIC;
            ap_ready : OUT STD_LOGIC;
            input_r_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
            input_r_TVALID : IN STD_LOGIC;
            input_r_TREADY : OUT STD_LOGIC;
            output_r_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
            output_r_TVALID : OUT STD_LOGIC;
            output_r_TREADY : IN STD_LOGIC
        );
    end component pgdstr;

begin

    ap_ctrl_start <= '1';
--    ap_ctrl_start <= '0' when state = Idle else '1';
    ap_done <= ap_ctrl_done;
    ap_idle <= ap_ctrl_idle;
    ap_ready <= ap_ctrl_ready;
    bd_0_i: component pgdstr
        port map (
            ap_clk => ACLK,
            ap_rst_n => ARESETN,
            ap_start => ap_ctrl_start,
            ap_done => ap_ctrl_done,
            ap_idle => ap_ctrl_idle,
            ap_ready => ap_ctrl_ready,
            input_r_TDATA(31 downto 0) => input_r_tdata(31 downto 0),
            input_r_TVALID => input_r_tvalid,
            input_r_TREADY => input_r_tready,
            output_r_TDATA(31 downto 0) => output_r_tdata(31 downto 0),
            output_r_TVALID => output_r_tvalid,
            output_r_TREADY => output_r_tready
    );
                                           
--    process(ACLK)                                                                        
--    begin                                                                                       
--        if (rising_edge (ACLK)) then 
--            ap_ctrl_done_delay <= ap_ctrl_done;    
--        end if;
--    end process;
        
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
