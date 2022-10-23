library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tiny_fifo is
  generic (
    GC_WIDTH : integer :=  8;  -- FIFO data width
    GC_DEPTH : integer := 32); -- FIFO data depth, <= 32
  port (
    clk            : in std_logic;
    
    -- FIFO data input
    fifo_in_data   : in  std_logic_vector(GC_WIDTH-1 downto 0);
    fifo_in_valid  : in  std_logic;
    fifo_in_ready  : out std_logic := '0';
    -- FIFO data output
    fifo_out_data  : out std_logic_vector(GC_WIDTH-1 downto 0) := (others => '0');
    fifo_out_valid : out std_logic := '0';
    fifo_out_ready : in  std_logic;
    
    -- status signals
    fifo_index     : out signed(5 downto 0));
end entity;
architecture arch of tiny_fifo is
  type ram_type is array (GC_DEPTH-1 downto 0) of std_logic_vector (GC_WIDTH-1 downto 0);
  signal fifo            : ram_type := (others => (others => '0'));
  signal fifo_index_i    : signed (5 downto 0) := to_signed(-1, 6);
  signal fifo_empty      : boolean;
  signal fifo_full       : boolean;
  signal fifo_in_enable  : boolean;
  signal fifo_out_enable : boolean;
begin
  fifo_full       <= (fifo_index_i = GC_DEPTH-1);  
  fifo_empty      <= (fifo_index_i = -1);
   
  fifo_in_ready   <= '1' when (not  fifo_full) else '0';
  fifo_out_valid  <= '1' when (not fifo_empty) else '0';
  fifo_in_enable  <= (fifo_in_valid  = '1') and (not fifo_full );
  fifo_out_enable <= (fifo_out_ready = '1') and (not fifo_empty);
  
  fifo_out_data   <= fifo(to_integer(unsigned(fifo_index_i(4 downto 0))));  
  fifo_index      <= fifo_index_i;
  
  process (clk)
  begin
    if rising_edge(clk) then
      if fifo_in_enable then
        fifo(GC_DEPTH-1 downto 1) <= fifo(GC_DEPTH-2 downto 0);
        fifo(0)                   <= fifo_in_data;
        if not fifo_out_enable then fifo_index_i <= fifo_index_i + 1; end if;
      elsif fifo_out_enable then fifo_index_i <= fifo_index_i - 1;
      end if;
    end if;  
  end process;
 
end architecture;