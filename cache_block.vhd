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
    data_w  : in std_logic_vector( 35 downto 0);
    data_r  : out std_logic_vector( 35 downto 0));
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

    for and_2_r0, and_2_r1, and_2_r2, and_2_r3 : and_2 use entity work.and_2(structural);
    for and_2_w0, and_2_w1, and_2_w2, and_2_w3 : and_2 use entity work.and_2(structural);
    for or_4_0 : or_4 use entity work.or_4(structural);
    for and_4_0 : and_4 use entity work.and_4(structural);
    for valid_0 : cache_cell use entity work.cache_cell(structural);
    for tag_0 : tag use entity work.tag(structural);
    for byte_0, byte_1, byte_2, byte_3 : cache_byte use entity work.cache_byte(structural);

    signal reading : std_logic := '0';
    signal overwrite : std_logic := '0';
    signal valid : std_logic := '1';

    signal tmp_enable_r_0, tmp_enable_r_1, tmp_enable_r_2, tmp_enable_r_3 : std_logic;
    signal tmp_enable_w_0, tmp_enable_w_1, tmp_enable_w_2, tmp_enable_w_3 : std_logic;

begin

    -- only enable write if the block is enabled
    and_2_r0: and_2 port map (enable_blk, enable_r(0), tmp_enable_r_0);
    and_2_r1: and_2 port map (enable_blk, enable_r(1), tmp_enable_r_1);
    and_2_r2: and_2 port map (enable_blk, enable_r(2), tmp_enable_r_2);
    and_2_r3: and_2 port map (enable_blk, enable_r(3), tmp_enable_r_3);

    -- only enable write if the block is enabled
    and_2_w0: and_2 port map (enable_blk, enable_w(0), tmp_enable_w_0);
    and_2_w1: and_2 port map (enable_blk, enable_w(1), tmp_enable_w_1);
    and_2_w2: and_2 port map (enable_blk, enable_w(2), tmp_enable_w_2);
    and_2_w3: and_2 port map (enable_blk, enable_w(3), tmp_enable_w_3);

    -- we will read tag and valid bit if even one of our cells are enabled
    or_4_0: or_4 port map (tmp_enable_r_0, tmp_enable_r_1, tmp_enable_r_2, tmp_enable_r_3, reading);

    -- we will overwrite our tag and valid bit only if we are writing all 4 bytes (i.e.
    -- after fetching from memory)
    and_4_0: and_4 port map (tmp_enable_w_0, tmp_enable_w_1, tmp_enable_w_2, tmp_enable_w_3, overwrite);

    -- if we are writing the entire block, we can mark it as valid
    -- TODO: Make sure this initializes as '0'
    valid_0: cache_cell port map (overwrite, reading, valid, valid);

    -- if we are writing the entire block, we need to update the tag, when we read,
    -- we always want to grab the tag as well
    tag_0  : tag port map (overwrite, reading, data_w(34 downto 32), data_r(34 downto 32));

    -- read/write to selected cache bytes
    byte_0 : cache_byte port map (enable_w(0), enable_r(0), data_w(31 downto 24), data_r(31 downto 24));
    byte_1 : cache_byte port map (enable_w(1), enable_r(1), data_w(23 downto 16), data_r(23 downto 16));
    byte_2 : cache_byte port map (enable_w(2), enable_r(2), data_w(15 downto 8), data_r(15 downto 8));
    byte_3 : cache_byte port map (enable_w(3), enable_r(3), data_w(7 downto 0), data_r(7 downto 0));

end structural;

----------------------------------------------------------------------------------------------
