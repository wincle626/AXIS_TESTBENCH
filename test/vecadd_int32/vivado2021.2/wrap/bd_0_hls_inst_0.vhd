-- (c) Copyright 1995-2022 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:hls:vecadd_fp32_stream:1.0
-- IP Revision: 2112384216

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bd_0_hls_inst_0 IS
  PORT (
    ap_local_block : OUT STD_LOGIC;
    ap_local_deadlock : OUT STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    inputs_TVALID : IN STD_LOGIC;
    inputs_TREADY : OUT STD_LOGIC;
    inputs_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    outputs_TVALID : OUT STD_LOGIC;
    outputs_TREADY : IN STD_LOGIC;
    outputs_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END bd_0_hls_inst_0;

ARCHITECTURE bd_0_hls_inst_0_arch OF bd_0_hls_inst_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF bd_0_hls_inst_0_arch: ARCHITECTURE IS "yes";
  COMPONENT vecadd_fp32_stream IS
    PORT (
      ap_local_block : OUT STD_LOGIC;
      ap_local_deadlock : OUT STD_LOGIC;
      ap_clk : IN STD_LOGIC;
      ap_rst_n : IN STD_LOGIC;
      ap_start : IN STD_LOGIC;
      ap_done : OUT STD_LOGIC;
      ap_idle : OUT STD_LOGIC;
      ap_ready : OUT STD_LOGIC;
      inputs_TVALID : IN STD_LOGIC;
      inputs_TREADY : OUT STD_LOGIC;
      inputs_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      outputs_TVALID : OUT STD_LOGIC;
      outputs_TREADY : IN STD_LOGIC;
      outputs_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT vecadd_fp32_stream;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF bd_0_hls_inst_0_arch: ARCHITECTURE IS "vecadd_fp32_stream,Vivado 2021.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF bd_0_hls_inst_0_arch : ARCHITECTURE IS "bd_0_hls_inst_0,vecadd_fp32_stream,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF bd_0_hls_inst_0_arch: ARCHITECTURE IS "bd_0_hls_inst_0,vecadd_fp32_stream,{x_ipProduct=Vivado 2021.2,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=vecadd_fp32_stream,x_ipVersion=1.0,x_ipCoreRevision=2112384216,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  ATTRIBUTE SDX_KERNEL : STRING;
  ATTRIBUTE SDX_KERNEL OF vecadd_fp32_stream: COMPONENT IS "true";
  ATTRIBUTE SDX_KERNEL_TYPE : STRING;
  ATTRIBUTE SDX_KERNEL_TYPE OF vecadd_fp32_stream: COMPONENT IS "hls";
  ATTRIBUTE SDX_KERNEL_SYNTH_INST : STRING;
  ATTRIBUTE SDX_KERNEL_SYNTH_INST OF vecadd_fp32_stream: COMPONENT IS "U0";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF bd_0_hls_inst_0_arch: ARCHITECTURE IS "HLS";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF outputs_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 outputs TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF outputs_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 outputs TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF outputs_TVALID: SIGNAL IS "XIL_INTERFACENAME outputs, TDATA_NUM_BYTES 4, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 333000000.0, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF outputs_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 outputs TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF inputs_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 inputs TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF inputs_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 inputs TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF inputs_TVALID: SIGNAL IS "XIL_INTERFACENAME inputs, TDATA_NUM_BYTES 4, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 333000000.0, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF inputs_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 inputs TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF ap_ready: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready";
  ATTRIBUTE X_INTERFACE_INFO OF ap_idle: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle";
  ATTRIBUTE X_INTERFACE_INFO OF ap_done: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done";
  ATTRIBUTE X_INTERFACE_INFO OF ap_start: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start";
  ATTRIBUTE X_INTERFACE_PARAMETER OF ap_rst_n: SIGNAL IS "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF ap_rst_n: SIGNAL IS "xilinx.com:signal:reset:1.0 ap_rst_n RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF ap_clk: SIGNAL IS "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF inputs:outputs, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 333000000.0, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF ap_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 ap_clk CLK";
BEGIN
  U0 : vecadd_fp32_stream
    PORT MAP (
      ap_local_block => ap_local_block,
      ap_local_deadlock => ap_local_deadlock,
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      ap_start => ap_start,
      ap_done => ap_done,
      ap_idle => ap_idle,
      ap_ready => ap_ready,
      inputs_TVALID => inputs_TVALID,
      inputs_TREADY => inputs_TREADY,
      inputs_TDATA => inputs_TDATA,
      outputs_TVALID => outputs_TVALID,
      outputs_TREADY => outputs_TREADY,
      outputs_TDATA => outputs_TDATA
    );
END bd_0_hls_inst_0_arch;
