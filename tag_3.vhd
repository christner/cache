----------------------------------------------------------------------------------------------
--
-- Entity: tag_3
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/10/2017
-- Description:
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity tag_3 is port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    rst     : in std_logic;
    data_w  : in std_logic_vector( 2 downto 0);
    data_r  : out std_logic_vector( 2 downto 0));
end tag_3;

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

----------------------------------------------------------------------------------------------
