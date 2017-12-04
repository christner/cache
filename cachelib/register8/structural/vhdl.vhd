-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of register8 is

    component dff port (
        d   : in  std_logic;
        clk : in  std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    for bit_0, bit_1, bit_2, bit_3, bit_4, bit_5, bit_6, bit_7 : dff use entity work.dff(structural);

begin

    bit_0 : dff port map (input(0), clk, output(0), open);
    bit_1 : dff port map (input(1), clk, output(1), open);
    bit_2 : dff port map (input(2), clk, output(2), open);
    bit_3 : dff port map (input(3), clk, output(3), open);
    bit_4 : dff port map (input(4), clk, output(4), open);
    bit_5 : dff port map (input(5), clk, output(5), open);
    bit_6 : dff port map (input(6), clk, output(6), open);
    bit_7 : dff port map (input(7), clk, output(7), open);

end structural;
