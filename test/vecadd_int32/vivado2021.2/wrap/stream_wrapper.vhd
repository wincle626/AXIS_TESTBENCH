----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.07.2021 12:36:46
-- Design Name: 
-- Module Name: stream_wrapper - Behavioral
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stream_wrapper is
     generic(
            -- Users to add parameters here
            C_S_AXIS_TDATA_COUNT    : integer := 16;
            C_M_AXIS_TDATA_COUNT    : integer := 16;
            -- User parameters ends
            -- Do not modify the parameters beyond this line
    
            -- Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
            C_S_AXIS_TDATA_WIDTH	: integer	:= 32;
            -- Width of M_AXIS address bus. The master accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
            C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
            
            -- Parameters of Axi Master Bus Interface M00_AXIS
            C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
            C_M00_AXIS_START_COUNT	: integer	:= 32;
            -- Parameters of Axi Slave Bus Interface S00_AXIS
            C_S00_AXIS_TDATA_WIDTH	: integer	:= 32
     );
    Port ( 
        -- Users to add ports here
        ap_clk : IN STD_LOGIC;
        ap_rst_n : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_local_block : out STD_LOGIC;
        ap_local_deadlock : out STD_LOGIC;
        -- User ports ends
        -- Do not modify the ports beyond this line

        -- AXI4Stream sink: Clock
--		S_AXIS_ACLK	: in std_logic;
        -- AXI4Stream sink: Reset
--		S_AXIS_ARESETN	: in std_logic;
        -- Ready to accept data in
        S_AXIS_TREADY	: out std_logic;
        -- Data in
        S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
        -- Byte qualifier
        S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
        -- Indicates boundary of last packet
        S_AXIS_TLAST	: in std_logic;
        -- Data is in valid
        S_AXIS_TVALID	: in std_logic;
        
        -- Global ports
--		M_AXIS_ACLK	: in std_logic;
        -- 
--		M_AXIS_ARESETN	: in std_logic;
        -- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
        M_AXIS_TVALID	: out std_logic;
        -- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
        M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
        -- TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
        M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
        -- TLAST indicates the boundary of a packet.
        M_AXIS_TLAST	: out std_logic;
        -- TREADY indicates that the slave can accept a transfer in the current cycle.
        M_AXIS_TREADY	: in std_logic
    );
end stream_wrapper;

architecture Behavioral of stream_wrapper is

component bd_0_wrapper is
  port (
    ap_clk : in STD_LOGIC;
    ap_ctrl_done : out STD_LOGIC;
    ap_ctrl_idle : out STD_LOGIC;
    ap_ctrl_ready : out STD_LOGIC;
    ap_ctrl_start : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_local_block : out STD_LOGIC;
    ap_local_deadlock : out STD_LOGIC;
    inputs_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inputs_tready : out STD_LOGIC;
    inputs_tvalid : in STD_LOGIC;
    outputs_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outputs_tready : in STD_LOGIC;
    outputs_tvalid : out STD_LOGIC
  );
end component bd_0_wrapper;

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


-- Total number of input data.
constant NUMBER_OF_INPUT_WORDS  : natural := 16;
-- Total number of output data
constant NUMBER_OF_OUTPUT_WORDS : natural := 16;
type STATE_TYPE is (Idle, Read_Inputs, Write_Outputs);
signal state        : STATE_TYPE := Idle;
-- Counters to store the number inputs read & outputs written
signal nr_of_reads  : natural range 0 to NUMBER_OF_INPUT_WORDS - 1 := 0;
signal nr_of_writes : natural range 0 to NUMBER_OF_OUTPUT_WORDS - 1 := 0;
-- TLAST signal
signal tlast : std_logic := '0';

begin

    bd_0_i: component bd_0_wrapper
         port map (
          ap_clk => ap_clk,
          ap_ctrl_done => ap_ctrl_done,
          ap_ctrl_idle => ap_ctrl_idle,
          ap_ctrl_ready => ap_ctrl_ready,
          ap_ctrl_start => ap_ctrl_start,
          ap_rst_n => ap_rst_n,
          ap_local_block => ap_local_block,
          ap_local_deadlock => ap_local_deadlock,
          inputs_tdata(31 downto 0) => input_r_tdata(31 downto 0),
          inputs_tready => input_r_tready,
          inputs_tvalid => input_r_tvalid,
          outputs_tdata(31 downto 0) => output_r_tdata(31 downto 0),
          outputs_tready => output_r_tready,
          outputs_tvalid => output_r_tvalid
        );

--   ap_ctrl_start <= ap_start;
   ap_ctrl_start <= '0' when state = Idle else '1';
   ap_done <= ap_ctrl_done;
   ap_idle <= ap_ctrl_idle;
   ap_ready <= ap_ctrl_ready;

   input_r_tdata <= S_AXIS_TDATA;
   input_r_tvalid <= S_AXIS_TVALID;
--   S_AXIS_TREADY  <= '0' when state = Write_Outputs else input_r_tready;
   S_AXIS_TREADY  <= input_r_tready when state /= Write_Outputs else '0';
--   S_AXIS_TREADY  <= input_r_tready;
--   M_AXIS_TVALID <= output_r_tvalid when state = Write_Outputs else '0';
   M_AXIS_TVALID <= output_r_tvalid;
   output_r_tready <= M_AXIS_TREADY;
   M_AXIS_TDATA <= output_r_tdata;
   
   M_AXIS_TLAST <= tlast;
   
   
   The_SW_accelerator : process (ap_clk) is
   begin  -- process The_SW_accelerator
    if ap_clk'event and ap_clk = '1' then     -- Rising clock edge
      if ap_rst_n = '0' or ap_start = '0' then               -- Synchronous reset (active low)
        -- CAUTION: make sure your reset polarity is consistent with the
        -- system reset polarity
--        state        <= Idle;
--        nr_of_reads  <= 0;
--        nr_of_writes <= 0;
--        sum          <= (others => '0');
--        tlast        <= '0';
      else
        case state is
          when Idle =>
            if (S_AXIS_TVALID = '1') then
              state       <= Read_Inputs;
              nr_of_reads <= NUMBER_OF_INPUT_WORDS - 1;
            end if;

          when Read_Inputs =>
            if (S_AXIS_TVALID = '1') then
              if (S_AXIS_TLAST = '1' or nr_of_reads=1) then
                state        <= Write_Outputs;
                nr_of_writes <= NUMBER_OF_OUTPUT_WORDS - 1;
              else
                nr_of_reads <= nr_of_reads - 1;
              end if;
            end if;

          when Write_Outputs =>
            if (M_AXIS_TREADY = '1' and output_r_tvalid = '1') then
              if (nr_of_writes = 0) then
                state <= Idle;
                tlast <= '0';
              else
                -- assert TLAST on last transmitted word
                if (nr_of_writes = 1) then
                  tlast <= '1';
                end if;
                nr_of_writes <= nr_of_writes - 1;
              end if;
            end if;
        end case;
      end if;
    end if;
   end process The_SW_accelerator;
   
end Behavioral;
