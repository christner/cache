-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of dlatch_3 is

    component dlatch port (
        d   : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    for dlatch_0, dlatch_1, dlatch_2 : dlatch use entity work.dlatch(structural);

begin

    dlatch_0 : dlatch port map (data(0), clk, rst, output(0), output_bar(0));
    dlatch_1 : dlatch port map (data(1), clk, rst, output(1), output_bar(1));
    dlatch_2 : dlatch port map (data(2), clk, rst, output(2), output_bar(2));

end structural;
