--Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
--Date        : Sat Feb 19 21:37:37 2022
--Host        : Alienware17R3 running 64-bit major release  (build 9200)
--Command     : generate_target bd_0.bd
--Design      : bd_0
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_0 is
  port (
    ap_clk : in STD_LOGIC;
    ap_ctrl_done : out STD_LOGIC;
    ap_ctrl_idle : out STD_LOGIC;
    ap_ctrl_ready : out STD_LOGIC;
    ap_ctrl_start : in STD_LOGIC;
    ap_local_block : out STD_LOGIC;
    ap_local_deadlock : out STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    inputs_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inputs_tready : out STD_LOGIC;
    inputs_tvalid : in STD_LOGIC;
    outputs_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outputs_tready : in STD_LOGIC;
    outputs_tvalid : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of bd_0 : entity is "bd_0,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_0,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=1,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of bd_0 : entity is "bd_0.hwdef";
end bd_0;

architecture STRUCTURE of bd_0 is
  component bd_0_hls_inst_0 is
  port (
    ap_local_block : out STD_LOGIC;
    ap_local_deadlock : out STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    inputs_TVALID : in STD_LOGIC;
    inputs_TREADY : out STD_LOGIC;
    inputs_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    outputs_TVALID : out STD_LOGIC;
    outputs_TREADY : in STD_LOGIC;
    outputs_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component bd_0_hls_inst_0;
  signal ap_clk_0_1 : STD_LOGIC;
  signal ap_ctrl_0_1_done : STD_LOGIC;
  signal ap_ctrl_0_1_idle : STD_LOGIC;
  signal ap_ctrl_0_1_ready : STD_LOGIC;
  signal ap_ctrl_0_1_start : STD_LOGIC;
  signal ap_rst_n_0_1 : STD_LOGIC;
  signal hls_inst_ap_local_block : STD_LOGIC;
  signal hls_inst_ap_local_deadlock : STD_LOGIC;
  signal hls_inst_outputs_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal hls_inst_outputs_TREADY : STD_LOGIC;
  signal hls_inst_outputs_TVALID : STD_LOGIC;
  signal inputs_0_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal inputs_0_1_TREADY : STD_LOGIC;
  signal inputs_0_1_TVALID : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ap_clk : signal is "xilinx.com:signal:clock:1.0 CLK.AP_CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ap_clk : signal is "XIL_INTERFACENAME CLK.AP_CLK, ASSOCIATED_BUSIF inputs:outputs, ASSOCIATED_RESET ap_rst_n, CLK_DOMAIN bd_0_ap_clk_0, FREQ_HZ 333000000.0, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of ap_ctrl_done : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ";
  attribute X_INTERFACE_INFO of ap_ctrl_idle : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ";
  attribute X_INTERFACE_INFO of ap_ctrl_ready : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ";
  attribute X_INTERFACE_INFO of ap_ctrl_start : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ";
  attribute X_INTERFACE_INFO of ap_rst_n : signal is "xilinx.com:signal:reset:1.0 RST.AP_RST_N RST";
  attribute X_INTERFACE_PARAMETER of ap_rst_n : signal is "XIL_INTERFACENAME RST.AP_RST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of inputs_tready : signal is "xilinx.com:interface:axis:1.0 inputs ";
  attribute X_INTERFACE_INFO of inputs_tvalid : signal is "xilinx.com:interface:axis:1.0 inputs ";
  attribute X_INTERFACE_INFO of outputs_tready : signal is "xilinx.com:interface:axis:1.0 outputs ";
  attribute X_INTERFACE_INFO of outputs_tvalid : signal is "xilinx.com:interface:axis:1.0 outputs ";
  attribute X_INTERFACE_INFO of inputs_tdata : signal is "xilinx.com:interface:axis:1.0 inputs ";
  attribute X_INTERFACE_PARAMETER of inputs_tdata : signal is "XIL_INTERFACENAME inputs, CLK_DOMAIN bd_0_ap_clk_0, FREQ_HZ 333000000.0, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of outputs_tdata : signal is "xilinx.com:interface:axis:1.0 outputs ";
  attribute X_INTERFACE_PARAMETER of outputs_tdata : signal is "XIL_INTERFACENAME outputs, CLK_DOMAIN bd_0_ap_clk_0, FREQ_HZ 333000000.0, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
begin
  ap_clk_0_1 <= ap_clk;
  ap_ctrl_0_1_start <= ap_ctrl_start;
  ap_ctrl_done <= ap_ctrl_0_1_done;
  ap_ctrl_idle <= ap_ctrl_0_1_idle;
  ap_ctrl_ready <= ap_ctrl_0_1_ready;
  ap_local_block <= hls_inst_ap_local_block;
  ap_local_deadlock <= hls_inst_ap_local_deadlock;
  ap_rst_n_0_1 <= ap_rst_n;
  hls_inst_outputs_TREADY <= outputs_tready;
  inputs_0_1_TDATA(31 downto 0) <= inputs_tdata(31 downto 0);
  inputs_0_1_TVALID <= inputs_tvalid;
  inputs_tready <= inputs_0_1_TREADY;
  outputs_tdata(31 downto 0) <= hls_inst_outputs_TDATA(31 downto 0);
  outputs_tvalid <= hls_inst_outputs_TVALID;
hls_inst: component bd_0_hls_inst_0
     port map (
      ap_clk => ap_clk_0_1,
      ap_done => ap_ctrl_0_1_done,
      ap_idle => ap_ctrl_0_1_idle,
      ap_local_block => hls_inst_ap_local_block,
      ap_local_deadlock => hls_inst_ap_local_deadlock,
      ap_ready => ap_ctrl_0_1_ready,
      ap_rst_n => ap_rst_n_0_1,
      ap_start => ap_ctrl_0_1_start,
      inputs_TDATA(31 downto 0) => inputs_0_1_TDATA(31 downto 0),
      inputs_TREADY => inputs_0_1_TREADY,
      inputs_TVALID => inputs_0_1_TVALID,
      outputs_TDATA(31 downto 0) => hls_inst_outputs_TDATA(31 downto 0),
      outputs_TREADY => hls_inst_outputs_TREADY,
      outputs_TVALID => hls_inst_outputs_TVALID
    );
end STRUCTURE;
