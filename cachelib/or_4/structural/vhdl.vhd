-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sat Dec  9 20:29:51 2017


architecture structural of or_4 is

  component or_2 port (
      input1: in std_logic;
      input2: in std_logic;
      output: out std_logic);
  end component;

  for or_2_0, or_2_1, or_2_2 : or_2 use entity work.or_2(structural);

  signal tmp_or_2_0, tmp_or_2_1 : std_logic;

begin

  or_2_0 : or_2 port map(input1, input2, tmp_or_2_0);
  or_2_1 : or_2 port map(input3, input4, tmp_or_2_1);
  or_2_2 : or_2 port map(tmp_or_2_0, tmp_or_2_1, output);

end structural;
