library STD;
library IEEE;
use IEEE.std_logic_1164.all;
entity WaitCounter is port (
  currstate : in std_logic_vector(2 downto 0);
  nextstate : in std_logic_vector(2 downto 0);
  clk : in std_logic;
  reset : in std_logic;
  Ready : out std_logic
); end WaitCounter;

architecture structural of WaitCounter is
  component and_2 port (
  input1   : in  std_logic;
  input2   : in  std_logic;
  output   : out std_logic);
  end component;

  component and_3 port (
  input1 : in std_logic;
  input2 : in std_logic;
  input3 : in std_logic;
  output : out std_logic
  ); end component;

  component and_4 port (
  input1 : in std_logic;
  input2 : in std_logic;
  input3 : in std_logic;
  input4 : in std_logic;
  output : out std_logic
  ); end component;

  component xor_2 port (
  input1 : in std_logic;
  input2 : in std_logic;
  output : out std_logic
  ); end component;

  component or_2 port (
  input1   : in  std_logic;
  input2   : in  std_logic;
  output   : out std_logic);
  end component;

  component or_3 port (
  input1   : in  std_logic;
  input2   : in  std_logic;
  input3   : in  std_logic;
  output   : out std_logic);
  end component;

  component xnor_2 port (
  input1 : in std_logic;
  input2 : in std_logic;
  output : out std_logic
  ); end component;

  component jkff port (
  J : in std_logic;
  K : in std_logic;
  Clk : in std_logic;
  rst : in std_logic;
  Q : out std_logic );
  end component;

  component inverter port (
  input : in std_logic;
  output: out std_logic
  ); end component;

  for invclock, invc1, invc2, invc3 : inverter use entity work.inverter(structural);
  for and_crst : and_3 use entity work.and_3(structural);
  for xor_crst1, xor_crst2, xor_crst3 : xor_2 use entity work.xor_2(structural);
  for or_crst, or_crst_o : or_3 use entity work.or_3(structural);
  for counter1, counter2, counter3, counter4 : jkff use entity work.jkff(structural);
  for xnorrdy1, xnorrdy2, xnorrdy3, xnorrdy4 : xnor_2 use entity work.xnor_2(structural);
  for andready : and_4 use entity work.and_4(structural);
  for waitTime3, waitTime2, waitTime0a : inverter use entity work.inverter(structural);
  for waitTime3a, waitTime1, waitTime0b : and_2 use entity work.and_2(structural);
  for waitTime0 : or_2 use entity work.or_2(structural);

  signal invclk, c1, c2, c3, notabc, c_xor_n_1, c_xor_n_2, c_xor_n_3 : std_logic;
  signal c_or_n, outq1, outq2, outq3, outq4, ready1, ready2, ready3, ready4 : std_logic;
  signal wt1, wt3, wt4, counterReset : std_logic;
  signal waitTime : std_logic_vector(3 downto 0);
  signal one  : std_logic := '1';
  signal zero : std_logic := '0';
  begin
    -- Set counterReset
    invclock : inverter port map (clk, invclk);
    invc1 : inverter port map (currstate(0), c1);
    invc2 : inverter port map (currstate(1), c2);
    invc3 : inverter port map (currstate(2), c3);
    and_crst : and_3 port map (c1, c2, c3, notabc);
    xor_crst1 : xor_2 port map (currstate(0), nextstate(0), c_xor_n_1);
    xor_crst2 : xor_2 port map (currstate(1), nextstate(1), c_xor_n_2);
    xor_crst3 : xor_2 port map (currstate(2), nextstate(2), c_xor_n_3);
    or_crst : or_3 port map (c_xor_n_1, c_xor_n_2, c_xor_n_3, c_or_n);
    or_crst_o : or_3 port map (notabc, reset, c_or_n, counterReset);

    counter1 : jkff port map (one, one, invclk, counterReset, outq1);
    counter2 : jkff port map (one, one, outq1, counterReset, outq2);
    counter3 : jkff port map (one, one, outq2, counterReset, outq3);
    counter4 : jkff port map (one, one, outq3, counterReset, outq4);

    xnorrdy1 : xnor_2 port map (outq4, waitTime(3), ready1);
    xnorrdy2 : xnor_2 port map (outq3, zero, ready2);
    xnorrdy3 : xnor_2 port map (outq2, waitTime(1), ready3);
    xnorrdy4 : xnor_2 port map (outq1, waitTime(0), ready4);

    andready : and_4 port map (ready1, ready2, ready3, ready4, Ready);

    waitTime3 : inverter port map (currstate(1), wt1);
    waitTime3a: and_2 port map (currstate(2), wt1, waitTime(3));
    waitTime2: inverter port map (one, waitTime(2));
    waitTime1: and_2 port map (currstate(2), currstate(1), waitTime(1));
    waitTime0: or_2 port map (currstate(1), currstate(0), wt3);
    waitTime0a: inverter port map (currstate(2), wt4);
    waitTime0b: and_2 port map (wt3, wt4, waitTime(0));
    -- End counter logic
  end structural;
