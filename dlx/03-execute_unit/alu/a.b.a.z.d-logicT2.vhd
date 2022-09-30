library ieee;
use ieee.std_logic_1164.all;

entity logic_t2 is
  generic (NBIT: integer := 32);
  port (R1, R2         : in  std_logic_vector(NBIT-1 downto 0);
        S0, S1, S2, S3 : in  std_logic;                          
        Y              : out std_logic_vector(NBIT-1 downto 0));
end entity;

architecture structural of logic_t2 is

  component IVX
  port(A : in  std_logic;
       Y : out std_logic);
  end component;
  
  component NAND3
  port(A,B,C : in  std_logic;
       Y 	 : out std_logic);
  end component;
  
  component NAND4
  port(A, B, C, D : in  std_logic;
       Y          : out std_logic);
  end component;
  
  signal negR1, negR2, L0, L1, L2, L3: std_logic_vector(NBIT-1 downto 0);
  
begin
  
  -- INV operations applicated to R1 and R2 to obain negR1 and negR2
  IVX_R1: for i in 0 to NBIT-1 generate
    IVX_i: IVX port map(R1(i), negR1(i));
  end generate;
  IVX_R2: for i in 0 to NBIT-1 generate
    IVX_i: IVX port map(R2(i), negR2(i));
  end generate;
  
  -- NAND operations applicated to obtain L0 L1 L2 L3 (outputs of first level nands)
  NAND_L0: for i in 0 to NBIT-1 generate
    NAND3_0i: NAND3 port map(negR1(i), negR2(i), S0, L0(i));
  end generate;
  NAND_L1: for i in 0 to NBIT-1 generate
    NAND3_1i: NAND3 port map(negR1(i), R2(i), S1, L1(i));
  end generate;
  NAND_L2: for i in 0 to NBIT-1 generate
    NAND3_2i: NAND3 port map(R1(i), negR2(i), S2, L2(i));
  end generate;
  NAND_L3: for i in 0 to NBIT-1 generate
    NAND3_3i: NAND3 port map(R1(i), R2(i), S3, L3(i));
  end generate;
  
  -- NAND operation applicated to obtain final output
  NAND_Y: for i in 0 to NBIT-1 generate
    NAND4_i: NAND4 port map(L0(i), L1(i), L2(i), L3(i), Y(i));
  end generate;
  
end architecture;