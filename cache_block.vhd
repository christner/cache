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
    enable_blk: in std_logic;
    enable_w: in std_logic_vector( 3 downto 0 );
    enable_r: in std_logic_vector( 3 downto 0 );
    tag_w   : in std_logic_vector( 2 downto 0 );
    data_w  : in std_logic_vector( 7 downto 0 );
    rst     : in std_logic;
    valid_r : out std_logic;
    tag_r   : out std_logic_vector( 2 downto 0 );
    data_r  : out std_logic_vector( 7 downto 0 ));
end cache_block;

architecture structural of cache_block is

    component and_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component or_4 port (
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        output: out std_logic);
    end component;

    component and_4 port (
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
        rst     : in std_logic;
        data_r  : out std_logic);
    end component;

    component tag_3 port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic_vector( 2 downto 0 );
        rst     : in std_logic;
        data_r  : out std_logic_vector( 2 downto 0 ));
    end component;

    component cache_byte port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic_vector( 7 downto 0 );
        rst     : in std_logic;
        data_r  : out std_logic_vector( 7 downto 0 ));
    end component;

    for and_2_r0, and_2_r1, and_2_r2, and_2_r3 : and_2 use entity work.and_2(structural);
    for and_2_w0, and_2_w1, and_2_w2, and_2_w3 : and_2 use entity work.and_2(structural);
    for or_4_0 : or_4 use entity work.or_4(structural);
    for or_4_1 : or_4 use entity work.or_4(structural);
    for valid_0 : cache_cell use entity work.cache_cell(structural);
    for tag_0 : tag_3 use entity work.tag_3(structural);
    for byte_0, byte_1, byte_2, byte_3 : cache_byte use entity work.cache_byte(structural);

    signal reading : std_logic;
    signal overwrite : std_logic;
    signal valid_c : std_logic := '1'; -- constant, tying to vdd

    signal tmp_enable_w : std_logic_vector( 3 downto 0 );
    signal tmp_enable_r : std_logic_vector( 3 downto 0 );

begin

    -- only enable write if the block is enabled
    and_2_w0: and_2 port map (enable_blk, enable_w(0), tmp_enable_w(0));
    and_2_w1: and_2 port map (enable_blk, enable_w(1), tmp_enable_w(1));
    and_2_w2: and_2 port map (enable_blk, enable_w(2), tmp_enable_w(2));
    and_2_w3: and_2 port map (enable_blk, enable_w(3), tmp_enable_w(3));

    -- only enable read if the block is enabled
    and_2_r0: and_2 port map (enable_blk, enable_r(0), tmp_enable_r(0));
    and_2_r1: and_2 port map (enable_blk, enable_r(1), tmp_enable_r(1));
    and_2_r2: and_2 port map (enable_blk, enable_r(2), tmp_enable_r(2));
    and_2_r3: and_2 port map (enable_blk, enable_r(3), tmp_enable_r(3));

    -- we will overwrite our tag and valid bit only if we are writing all 4 bytes (i.e.
    -- after fetching from memory)
    or_4_1: or_4 port map (tmp_enable_w(0), tmp_enable_w(1), tmp_enable_w(2), tmp_enable_w(3), overwrite);

    -- we will read tag and valid bit if even one of our cells are enabled
    or_4_0: or_4 port map (tmp_enable_r(0), tmp_enable_r(1), tmp_enable_r(2), tmp_enable_r(3), reading);

    -- if we are writing the entire block, we can mark it as valid
    valid_0: cache_cell port map (overwrite, reading, valid_c, rst, valid_r);

    -- if we are writing the entire block, we need to update the tag, when we read,
    -- we always want to grab the tag as well
    tag_0  : tag_3 port map (overwrite, reading, tag_w(2 downto 0), rst, tag_r(2 downto 0));

    -- read/write to selected cache bytes
    byte_0 : cache_byte port map (tmp_enable_w(0), tmp_enable_r(0), data_w(7 downto 0), rst, data_r(7 downto 0));
    byte_1 : cache_byte port map (tmp_enable_w(1), tmp_enable_r(1), data_w(7 downto 0), rst, data_r(7 downto 0));
    byte_2 : cache_byte port map (tmp_enable_w(2), tmp_enable_r(2), data_w(7 downto 0), rst, data_r(7 downto 0));
    byte_3 : cache_byte port map (tmp_enable_w(3), tmp_enable_r(3), data_w(7 downto 0), rst, data_r(7 downto 0));

end structural;

----------------------------------------------------------------------------------------------
