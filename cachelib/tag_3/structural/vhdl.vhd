-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of tag_3 is

    component cache_cell port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic;
        rst     : in std_logic;
        data_r  : out std_logic);
    end component;

    for bit_0, bit_1, bit_2: cache_cell use entity work.cache_cell(structural);

begin

    bit_0: cache_cell port map (enable_w, enable_r, data_w(0), rst, data_r(0));
    bit_1: cache_cell port map (enable_w, enable_r, data_w(1), rst, data_r(1));
    bit_2: cache_cell port map (enable_w, enable_r, data_w(2), rst, data_r(2));

end structural;
