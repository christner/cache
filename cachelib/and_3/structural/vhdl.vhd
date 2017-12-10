-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sat Dec  9 20:47:14 2017


architecture structural of and_3 is

    component and_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    for and_2_0, and_2_1 : and_2 use entity work.and_2(structural);

    signal tmp_and_2_0 : std_logic;

begin

    and_2_0 : and_2 port map(input1, input2, tmp_and_2_0);
    and_2_1 : and_2 port map(input3, tmp_and_2_0, output);

end structural;
