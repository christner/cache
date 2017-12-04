-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture test of jkff_tb is

  component jkff
  port (
  J : in std_logic;
  K : in std_logic;
  Clk : in std_logic;
  rst : in std_logic;
  Q : out std_logic
  ); end component;

  for jkff_1 : jkff use entity work.jkff(structural);

  signal j_i, k_i, q_o, rst : std_logic;
  signal clock : std_logic;

  begin
    jkff_1 : jkff port map (j_i, k_i, clock, rst, q_o);

    clk : process
    begin
      clock <='0', '1' after 5 ns;
      wait for 10 ns;
    end process clk;

  test1: process begin
    rst <= '1';
    wait until falling_edge(clock);
    wait for 2 ns;
    rst <= '0';
    j_i <= '0';
    k_i <= '1';
    wait until falling_edge(clock);
    wait until falling_edge(clock);
    wait for 2 ns;
    j_i <= '1';
    k_i <= '0';
    wait until falling_edge(clock);

    wait for 2 ns;
    j_i <= '0';
    k_i <= '0';
    wait until falling_edge(clock);

    wait for 2 ns;
    j_i <= '1';
    k_i <= '1';
    wait until falling_edge(clock);
    wait until falling_edge(clock);
    wait until falling_edge(clock);
    wait for 2 ns;
    j_i <= '1';
    k_i <= '0';
    wait until falling_edge(clock);
    rst <= '1';
    wait until falling_edge(clock);
    wait until falling_edge(clock);
    wait for 2 ns;
    rst <= '0';
    j_i <= '0';
    k_i <= '1';
    wait until falling_edge(clock);
    wait for 3 ns;
    j_i <= '1';
    k_i <= '0';
    wait for 3 ns;
    j_i <= '0';
    k_i <= '1';
    wait until falling_edge(clock);

  end process test1;
end test;
