----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.01.2022 08:57:39
-- Design Name: 
-- Module Name: tb_axi_pgd_wrapper - Behavioral
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

entity tb_axis_wrap is
--  Port ( );
end tb_axis_wrap;

architecture Behavioral of tb_axis_wrap is

component axis_slave_v1_0 is
--	generic (
--		-- Parameters of Axi Slave Bus Interface S00_AXIS
--		C_S00_AXIS_TDATA_WIDTH	: integer;
--		NUMBER_OF_INPUT_WORDS  : integer
--	);
	port (
		-- Users to add ports here
		-- User ports ends
		-- Do not modify the ports beyond this line
		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(31 downto 0);
		s00_axis_tstrb	: in std_logic_vector(3 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic
	);
end component axis_slave_v1_0;

component axis_master_v1_0 is
--	generic (
--		-- Users to add parameters here
--		-- User parameters ends
--		-- Do not modify the parameters beyond this line
--		-- Parameters of Axi Master Bus Interface M00_AXIS
--		C_M00_AXIS_TDATA_WIDTH	: integer;
--		C_M00_AXIS_START_COUNT	: integer;
--		NUMBER_OF_OUTPUT_WORDS : integer
--	);
	port (
		-- Users to add ports here
		-- User ports ends
		-- Do not modify the ports beyond this line
		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(31 downto 0);
		m00_axis_tstrb	: out std_logic_vector(3 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic
	);
end component axis_master_v1_0;

component axis_wrap is
    Port ( 
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
end component axis_wrap;

signal m00_axis_aclk	:  std_logic := '0';
signal m00_axis_aresetn	:  std_logic := '0';
signal m00_axis_tvalid	:  std_logic := '0';
signal m00_axis_tdata	:  std_logic_vector(31 downto 0) := (others => '0');
signal m00_axis_tstrb	:  std_logic_vector(3 downto 0) := (others => '0');
signal m00_axis_tlast	:  std_logic := '0';
signal m00_axis_tready	:  std_logic := '0';

signal ACLK         	: 	std_logic := '0';
signal ARESETN	        : 	std_logic := '0';
signal DONE         	: 	std_logic := '0';
signal READY	        : 	std_logic := '0';
signal IDLE         	: 	std_logic := '0';
signal START	        : 	std_logic := '0';
signal ap_local_block_sig : std_logic := '0';
signal ap_local_deadlock_sig : std_logic := '0';
signal S_AXIS_TREADY	: 	std_logic := '0';
signal S_AXIS_TDATA	    : 	std_logic_vector(31 downto 0) := (others => '0');
signal S_AXIS_TSTRB     :   std_logic_vector(3 downto 0) := (others => '0');
signal S_AXIS_TLAST	    : 	std_logic := '0';
signal S_AXIS_TVALID	: 	std_logic := '0';
signal M_AXIS_TVALID	: 	std_logic := '0';
signal M_AXIS_TDATA	    : 	std_logic_vector(31 downto 0) := (others => '0');
signal M_AXIS_TSTRB	    :  std_logic_vector(3 downto 0) := (others => '0');
signal M_AXIS_TLAST	    : 	std_logic := '0';
signal M_AXIS_TREADY	: 	std_logic := '0';


signal s00_axis_aclk	:  std_logic;
signal s00_axis_aresetn	:  std_logic;
signal s00_axis_tready	:  std_logic;
signal s00_axis_tdata	:  std_logic_vector(31 downto 0) := (others => '0');
signal s00_axis_tstrb	:  std_logic_vector(3 downto 0) := (others => '0');
signal s00_axis_tlast	:  std_logic;
signal s00_axis_tvalid	:  std_logic;

constant T : time := 20 ns;
signal clk, resetn : std_logic;  -- input

begin

-- continuous clock & resetn
process
begin
    clk <= '0';
    wait for T/2;
    clk <= '1';
    wait for T/2;
end process;
resetn <= '0', '1' after T/2;
START <= '0', '1' after T/2;

--start_proc : process (clk) is
--begin  -- process The_SW_accelerator
--    if clk'event and clk = '1' then     -- Rising clock edge
--        if m00_axis_tvalid = '1' then
--            START <= '1';
--        end if;
--    end if;
--end process start_proc;

-- clock & resetn
m00_axis_aclk       <= clk;
ACLK                <= clk;
s00_axis_aclk       <= clk;
m00_axis_aresetn    <= resetn;
ARESETN             <= resetn;
s00_axis_aresetn    <= resetn;

-- axi master to stream generator
m00_axis_tready     <= S_AXIS_TREADY;
S_AXIS_TDATA        <= m00_axis_tdata;
S_AXIS_TVALID       <= m00_axis_tvalid;
S_AXIS_TLAST        <= m00_axis_tlast;

-- stream generator to axi slave
M_AXIS_TREADY       <= s00_axis_tready;
s00_axis_tdata      <= M_AXIS_TDATA;
s00_axis_tvalid     <= M_AXIS_TVALID;
s00_axis_tlast      <= M_AXIS_TLAST;

axis_master_inst0: axis_master_v1_0
--	generic map(
--		-- Parameters of Axi Master Bus Interface M00_AXIS
--		C_M00_AXIS_TDATA_WIDTH	=> 32,
--		C_M00_AXIS_START_COUNT	=> 32,
--		NUMBER_OF_OUTPUT_WORDS  => 10
--	)
	port map(
		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	    => m00_axis_aclk,
		m00_axis_aresetn	=> m00_axis_aresetn,
		m00_axis_tvalid	    => m00_axis_tvalid,
		m00_axis_tdata	    => m00_axis_tdata,
		m00_axis_tstrb      => m00_axis_tstrb,
		m00_axis_tlast      => m00_axis_tlast,
		m00_axis_tready     => m00_axis_tready
	);
	
axis_wrap_inst0: axis_wrap
    port map
	(
		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add or delete. 
		ACLK	         => ACLK,
		ARESETN	         => ARESETN,
		S_AXIS_TREADY	 => S_AXIS_TREADY,
		S_AXIS_TDATA	 => S_AXIS_TDATA,
		S_AXIS_TLAST	 => S_AXIS_TLAST,
		S_AXIS_TVALID	 => S_AXIS_TVALID,
		M_AXIS_TVALID	 => M_AXIS_TVALID,
		M_AXIS_TDATA	 => M_AXIS_TDATA,
		M_AXIS_TLAST	 => M_AXIS_TLAST,
		M_AXIS_TREADY	 => M_AXIS_TREADY,
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
        ap_done => DONE,
        ap_idle => IDLE,
        ap_ready => READY,
        ap_local_block => ap_local_block_sig,
        ap_local_deadlock => ap_local_deadlock_sig
	);

axis_slave_inst0: axis_slave_v1_0
--	generic map(
--		-- Parameters of Axi Slave Bus Interface S00_AXIS
--		C_S00_AXIS_TDATA_WIDTH	=> 32,
--		NUMBER_OF_INPUT_WORDS  => 5
--	)
	port map(
		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	    => s00_axis_aclk,
		s00_axis_aresetn	=> s00_axis_aresetn,
		s00_axis_tready	    => s00_axis_tready,
		s00_axis_tdata	    => s00_axis_tdata,
		s00_axis_tstrb	    => s00_axis_tstrb,
		s00_axis_tlast	    => s00_axis_tlast,
		s00_axis_tvalid	    => s00_axis_tvalid
	);

end Behavioral;
