----------------------------------------------------------------------------------------------
--
-- Entity: cache_block
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/10/2017
-- Description: logical grouping of a valid bit, a tag, and 4 cache byte
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity cache_block is port (
    enable_w: in std_logic_vector( 3 downto 0 );
    enable_r: in std_logic_vector( 3 downto 0 );
    data_w  : in std_logic_vector( 35 downto 0);
    data_r  : out std_logic_vector( 35 downto 0));
end cache_block;

architecture structural of cache_block is
    component or4 port (
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        output: out std_logic);
    end component;

    component and4 port (
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        output: out std_logic);
    end component;

    component cache_cell port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic;
        data_r  : out std_logic);
    end component;

    component tag port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic_vector( 2 downto 0);
        data_r  : out std_logic_vector( 2 downto 0 ));
    end component;

    component cache_byte port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic_vector( 7 downto 0);
        data_r  : out std_logic_vector( 7 downto 0 ));
    end component;

    for or4_0 : or4 use entity work.or4(structural);
    for and4_0 : and4 use entity work.and4(structural);
    for valid_0 : cache_cell use entity work.cache_cell(structural);
    for tag_0 : tag use entity work.tag(structural);
    for byte_0, byte_1, byte_2, byte_3 : cache_byte use entity work.cache_byte(structural);

    signal reading : std_logic := '0';
    signal overwrite : std_logic := '0';

begin

    -- we will read if even one of our cells are enabled
    or4_0: or4 port map (enable_r(0), enable_r(1), enable_r(2), enable_r(3), reading);

    -- we will overwrite our tag and valid bit only if we are writing all 4 bytes (i.e.
    -- after fetching from memory)
    and4_0: and4 port map (enable_w(0), enable_w(1), enable_w(2), enable_w(3), overwrite);

    valid_0: cache_cell port map (overwrite, reading, data_w(35), data_r(35));

    tag_0  : tag port map (overwrite, reading, data_w(34 downto 32), data_r(34 downto 32));

    byte_0 : cache_byte port map (enable_w(0), enable_r(0), data_w(31 downto 24), data_r(31 downto 24));
    byte_1 : cache_byte port map (enable_w(1), enable_r(1), data_w(23 downto 16), data_r(23 downto 16));
    byte_2 : cache_byte port map (enable_w(2), enable_r(2), data_w(15 downto 8), data_r(15 downto 8));
    byte_3 : cache_byte port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));


end structural;

----------------------------------------------------------------------------------------------
