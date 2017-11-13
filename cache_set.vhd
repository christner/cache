----------------------------------------------------------------------------------------------
--
-- Entity: cache_set
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/12/2017
-- Description: complete set for cache consisting of 8 blocks
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity cache_set is port (
    enable_w: in std_logic_vector( 3 downto 0 );
    enable_r: in std_logic_vector( 3 downto 0 );
    data_w  : in std_logic_vector( 35 downto 0);
    data_r  : out std_logic_vector( 35 downto 0));
end cache_set;

architecture structural of cache_set is
    component cache_block port (
        enable_w: in std_logic_vector( 3 downto 0 );
        enable_r: in std_logic_vector( 3 downto 0 );
        data_w  : in std_logic_vector( 35 downto 0);
        data_r  : out std_logic_vector( 35 downto 0));
    end component;

    for block_0, block_1, block_2, block_3, block_4, block_5, block_6, block_7 : cache_block use entity work.cache_block(structural);

begin

    block_0 : cache_block port map (enable_w(0), enable_r(0), data_w(31 downto 24), data_r(31 downto 24));
    block_1 : cache_block port map (enable_w(1), enable_r(1), data_w(23 downto 16), data_r(23 downto 16));
    block_2 : cache_block port map (enable_w(2), enable_r(2), data_w(15 downto 8), data_r(15 downto 8));
    block_3 : cache_block port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));
    block_4 : cache_block port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));
    block_5 : cache_block port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));
    block_6 : cache_block port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));
    block_7 : cache_block port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));

end structural;

----------------------------------------------------------------------------------------------
