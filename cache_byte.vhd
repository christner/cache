----------------------------------------------------------------------------------------------
--
-- Entity: cache_byte
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/10/2017
-- Description: logical grouping of 8 cache cells into a single r/w enablable byte
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity cache_byte is port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    data_w  : in std_logic_vector( 7 downto 0 );
    data_r  : out std_logic_vector( 7 downto 0 ));
end cache_byte;

architecture structural of cache_byte is
    component cache_cell port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic;
        data_r  : out std_logic);
    end component;

    for bit_0, bit_1, bit_2, bit_3, bit_4, bit_5, bit_6, bit_7 : cache_cell use entity work.cache_cell(structural);

begin

    bit_0: cache_cell port map (enable_w, enable_r, data_w(0), data_r(0));
    bit_1: cache_cell port map (enable_w, enable_r, data_w(1), data_r(1));
    bit_2: cache_cell port map (enable_w, enable_r, data_w(2), data_r(2));
    bit_3: cache_cell port map (enable_w, enable_r, data_w(3), data_r(3));
    bit_4: cache_cell port map (enable_w, enable_r, data_w(4), data_r(4));
    bit_5: cache_cell port map (enable_w, enable_r, data_w(5), data_r(5));
    bit_6: cache_cell port map (enable_w, enable_r, data_w(6), data_r(6));
    bit_7: cache_cell port map (enable_w, enable_r, data_w(7), data_r(7));

end structural;

----------------------------------------------------------------------------------------------
