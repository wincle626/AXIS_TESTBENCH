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
use IEEE.NUMERIC_STD.ALL;

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
		M_AXIS_TREADY	: in	std_logic;
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
		DEBUG           : out std_logic_vector(3 downto 0)
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
    
    component HLS_accel is
        port (
            ap_clk : IN STD_LOGIC:= '0';
            ap_rst_n : IN STD_LOGIC:= '0';
            ap_start : IN STD_LOGIC:= '0';
            ap_done : OUT STD_LOGIC:= '0';
            ap_idle : OUT STD_LOGIC:= '0';
            ap_ready : OUT STD_LOGIC:= '0';
            INPUT_STREAM_TDATA : IN STD_LOGIC_VECTOR (31 downto 0)   := (others => '0');
            INPUT_STREAM_TVALID : IN STD_LOGIC  := '0';
            INPUT_STREAM_TREADY : OUT STD_LOGIC := '0';
            INPUT_STREAM_TKEEP : IN STD_LOGIC_VECTOR (3 downto 0)    := (others => '0');
            INPUT_STREAM_TSTRB : IN STD_LOGIC_VECTOR (3 downto 0)    := (others => '0');
            INPUT_STREAM_TUSER : IN STD_LOGIC_VECTOR (3 downto 0)    := (others => '0');
            INPUT_STREAM_TLAST : IN STD_LOGIC_VECTOR (0 downto 0)    := (others => '0');
            INPUT_STREAM_TID : IN STD_LOGIC_VECTOR (4 downto 0)      := (others => '0');
            INPUT_STREAM_TDEST : IN STD_LOGIC_VECTOR (4 downto 0)    := (others => '0');
            OUTPUT_STREAM_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
            OUTPUT_STREAM_TVALID : OUT STD_LOGIC := '0';
            OUTPUT_STREAM_TREADY : IN STD_LOGIC  := '0';
            OUTPUT_STREAM_TKEEP : OUT STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            OUTPUT_STREAM_TSTRB : OUT STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            OUTPUT_STREAM_TUSER : OUT STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
            OUTPUT_STREAM_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
            OUTPUT_STREAM_TID : OUT STD_LOGIC_VECTOR (4 downto 0)   := (others => '0');
            OUTPUT_STREAM_TDEST : OUT STD_LOGIC_VECTOR (4 downto 0) := (others => '0')
        );
    end component HLS_accel;
    
   -- Total number of output data
   constant NUMBER_OF_INPUT_WORDS  : natural := 16;   
   constant NUMBER_OF_OUTPUT_WORDS : natural := 16;   
   signal nr_of_writes : natural range 0 to NUMBER_OF_OUTPUT_WORDS - 1 := 0;
   -- TLAST signal
   signal tlast : std_logic := '0';   

begin

    ap_ctrl_start <= '1';
--    ap_ctrl_start <= '0' when state = Idle else '1';
    ap_done <= ap_ctrl_done;
    ap_idle <= ap_ctrl_idle;
    ap_ready <= ap_ctrl_ready;
    bd_0_i: component HLS_accel
        port map (
            ap_clk => ACLK,
            ap_rst_n => ARESETN,
            ap_start => ap_ctrl_start,
            ap_done => ap_ctrl_done,
            ap_idle => ap_ctrl_idle,
            ap_ready => ap_ctrl_ready,
            INPUT_STREAM_TDATA(31 downto 0) => input_r_tdata(31 downto 0),
            INPUT_STREAM_TVALID => input_r_tvalid,
            INPUT_STREAM_TREADY => input_r_tready,
            INPUT_STREAM_TKEEP => open,
            INPUT_STREAM_TSTRB => open,
            INPUT_STREAM_TUSER => open,
            INPUT_STREAM_TLAST => open,
            OUTPUT_STREAM_TDATA(31 downto 0) => output_r_tdata(31 downto 0),
            OUTPUT_STREAM_TVALID => output_r_tvalid,
            OUTPUT_STREAM_TREADY => output_r_tready,
            OUTPUT_STREAM_TKEEP => open,
            OUTPUT_STREAM_TSTRB => open,
            OUTPUT_STREAM_TUSER => open,
            OUTPUT_STREAM_TLAST => open,
            OUTPUT_STREAM_TID => open,
            OUTPUT_STREAM_TDEST => open
    );
    
-----------------------------------------------FSM Free---------------------------------------------                                           
    process(ACLK)                                                                        
    begin                                                                                       
        if (rising_edge (ACLK)) then 
            input_r_tvalid <= S_AXIS_TVALID;       
            S_AXIS_TREADY <= input_r_tready; 
            M_AXIS_TVALID <= output_r_tvalid;
            output_r_tready <= M_AXIS_TREADY;
        end if;
    end process;      
    process(ACLK)                                                                        
    begin                                                                                       
        if (rising_edge (ACLK)) then
            if(S_AXIS_TVALID='1' and input_r_tready='1') then
                input_r_tdata <= S_AXIS_TDATA;
            end if; 
        end if;
    end process;     
    process(ACLK)                                                                        
    begin                                                                                       
        if (rising_edge (ACLK)) then
            if(output_r_tvalid='1' and M_AXIS_TREADY='1') then
                M_AXIS_TDATA <= output_r_tdata;
            end if; 
        end if;
    end process; 
    DEBUG <= std_logic_vector(to_unsigned(nr_of_writes, DEBUG'length));
    process(ACLK)                                                                        
    begin                                                                    
        if (rising_edge (ACLK)) then
            -- geenerate last signal 
            if (nr_of_writes = 1) then
                tlast <= '1';
            else
                -- assert TLAST on last transmitted word
                tlast <= '0';
            end if;
        end if;
    end process;   
    process(ACLK)                                                                        
    begin                                                                                       
        if (rising_edge (ACLK)) then 
            if (output_r_tvalid='1' and M_AXIS_TREADY='1') then
                nr_of_writes <= nr_of_writes - 1;
            else
                nr_of_writes <= NUMBER_OF_OUTPUT_WORDS - 1;
            end if;
        end if;
    end process;
        
--    input_r_tdata <= S_AXIS_TDATA when (S_AXIS_TVALID='1' and input_r_tready='1') else (others=>'0');
--    input_r_tvalid <= S_AXIS_TVALID;       
--    S_AXIS_TREADY <= input_r_tready; 
--    input_r_tdata <= S_AXIS_TDATA when (S_AXIS_TVALID='1' and input_r_tready='1');
    
--    M_AXIS_TDATA <= output_r_tdata when (output_r_tvalid='1' and M_AXIS_TREADY='1');  
--    M_AXIS_TVALID <= output_r_tvalid;
--    output_r_tready <= M_AXIS_TREADY;
--    M_AXIS_TDATA <= output_r_tdata when (output_r_tvalid='1' and M_AXIS_TREADY='1') else (others=>'0'); 
    M_AXIS_TLAST <= ap_ctrl_done;
--    M_AXIS_TLAST <= tlast;
--------------------------------------------------------------------------------------------------------------
   

end Behavioral;