-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of xnor_2 is

  component inverter port (
      input : in std_logic;
      output: out std_logic);
  end component;

  component xor_2 port (
      input1   : in  std_logic;
      input2   : in  std_logic;
      output   : out std_logic);
  end component;

    for inverter_0 : inverter use entity work.inverter(structural);

    for xor_2_0 : xor_2 use entity work.xor_2(structural);

    signal tmp : std_logic;

begin

    xor_2_0 : xor_2 port map (input1, input2, tmp);

    inverter_0 : inverter port map (tmp, output);

end structural;
