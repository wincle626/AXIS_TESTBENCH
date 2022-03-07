----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2021 16:06:22
-- Design Name: 
-- Module Name: tb_axi_master_slave - Behavioral
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

entity tb_axi_master_slave is
	generic (
		NUMBER_OF_OUTPUT_WORDS	: integer	:= 32;
		NUMBER_OF_INPUT_WORDS	: integer	:= 32;
		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M00_AXIS_START_COUNT	: integer	:= 32;
		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32
	);
--  Port ( );
end tb_axi_master_slave;

architecture Behavioral of tb_axi_master_slave is

component axis_slave_v1_0 is
	generic (
		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32;
		NUMBER_OF_INPUT_WORDS  : integer := 32
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn	: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic
	);
end component axis_slave_v1_0;

component axis_master_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M00_AXIS_START_COUNT	: integer	:= 32;
		NUMBER_OF_OUTPUT_WORDS : integer := 32
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic
	);
end component axis_master_v1_0;

signal m00_axis_aclk	:  std_logic;
signal m00_axis_aresetn	:  std_logic;
signal m00_axis_tvalid	:  std_logic;
signal m00_axis_tdata	:  std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
signal m00_axis_tstrb	:  std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
signal m00_axis_tlast	:  std_logic;
signal m00_axis_tready	:  std_logic;

signal s00_axis_aclk	:  std_logic;
signal s00_axis_aresetn	:  std_logic;
signal s00_axis_tready	:  std_logic;
signal s00_axis_tdata	:  std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
signal s00_axis_tstrb	:  std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
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

-- clock & resetn
m00_axis_aclk       <= clk;
s00_axis_aclk       <= clk;
m00_axis_aresetn    <= resetn;
s00_axis_aresetn    <= resetn;

axis_master_inst0: axis_master_v1_0 
	generic map(
		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	=> C_M00_AXIS_TDATA_WIDTH,
		C_M00_AXIS_START_COUNT	=> C_M00_AXIS_START_COUNT,
		NUMBER_OF_OUTPUT_WORDS  => NUMBER_OF_INPUT_WORDS
	)
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
	
s00_axis_tvalid <= m00_axis_tvalid;
s00_axis_tdata <= m00_axis_tdata;
m00_axis_tready <= s00_axis_tready;
s00_axis_tstrb <= m00_axis_tstrb;
s00_axis_tlast <= m00_axis_tlast;

axis_slave_inst0: axis_slave_v1_0 
	generic map(
		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	=> C_S00_AXIS_TDATA_WIDTH,
		NUMBER_OF_INPUT_WORDS  => NUMBER_OF_INPUT_WORDS
	)
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
