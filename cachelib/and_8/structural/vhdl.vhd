-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Mon Dec  4 18:55:03 2017


architecture structural of and_8 is

    component and_2 port (
        input1 : in std_logic;
        input2 : in std_logic;
        output: out std_logic);
    end component;

    component and_4 port (
        input1 : in std_logic;
        input2 : in std_logic;
        input3 : in std_logic;
        input4 : in std_logic;
        output: out std_logic);
    end component;

    for and_4_0, and_4_1  : and_4 use entity work.and_4(structural);

    for and_2_0 : and_2 use entity work.and_2(structural);

    signal tmp_and_4_0, tmp_and_4_1 : std_logic;

begin

    and_4_0 : and_4 port map(input1, input2, input3, input4, tmp_and_4_0);
    and_4_1 : and_4 port map(input5, input6, input7, input8, tmp_and_4_1);

    and_2_0 : and_2 port map(tmp_and_4_0, tmp_and_4_1, output);


end structural;
