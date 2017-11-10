library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity jkff_tb is

end jkff_tb;

architecture test of jkff_tb is

  component jkff
  port (
  J : in std_logic;
  K : in std_logic;
  Clk : in std_logic;
  Q : out std_logic
  ); end component;

  for jkff_1 : jkff use entity work.jkff(structural);

  signal j_i, k_i, q_o : std_logic;
  signal clock : std_logic;

  begin
    jkff_1 : jkff port map (j_i, k_i, clock, q_o);

    clk : process
    begin
      clock <='0', '1' after 5 ns;
      wait for 10 ns;
    end process clk;

  test1: process begin
    j_i <= '0';
    k_i <= '1';
    wait until falling_edge(clock);

    j_i <= '1';
    k_i <= '0';
    wait until falling_edge(clock);


    j_i <= '0';
    k_i <= '0';
    wait until falling_edge(clock);
    wait until falling_edge(clock);

    j_i <= '1';
    k_i <= '1';
    wait until falling_edge(clock);

    j_i <= '1';
    k_i <= '0';
    wait until falling_edge(clock);

    j_i <= '0';
    k_i <= '1';
    wait until falling_edge(clock);

    j_i <= '0';
    k_i <= '1';
    wait until falling_edge(clock);

  end process test1;
end test;
