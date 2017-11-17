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

entity set_associative_cache_2 is port (
    enable         : in std_logic;
    write_whole_blk: in std_logic;
    w_r            : in std_logic;
    address        : in std_logic_vector( 4 downto 0 );
    data_w         : in std_logic_vector( 31 downto 0 );
    hit_miss       : out std_logic;
    data_r         : out std_logic_vector( 31 downto 0 ));
end set_associative_cache_2;

architecture structural of set_associative_cache_2 is

    component and_2 port (
        input1 : in std_logic;
        input2 : in std_logic;
        output: out std_logic);
    end component;

    component or_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component comparator_3 port (
        input1: in std_logic_vector( 2 downto 0 );
        input2: in std_logic_vector( 2 downto 0 );
        output: out std_logic);
    end component;

    component cache_set port (
        enable_set     : in std_logic;
        write_whole_blk: in std_logic;
        w_r            : in std_logic;
        address        : in std_logic_vector( 4 downto 0 );
        data_w         : in std_logic_vector( 31 downto 0 );
        valid_r        : out std_logic;
        tag_r          : out std_logic_vector( 2 downto 0 );
        data_r         : out std_logic_vector( 31 downto 0 ));
    end component;

    for or_2_0 : or_2 use entity work.or_2(structural);

    for and_2_0, and_2_1 : and_2 use entity work.and_2(structural);

    for comparator_3_tag0, comparator_3_tag1 : comparator_3 use entity work.comparator_3(structural);

    for cache_set_0, cache_set_1 : cache_set use entity work.cache_set(structural);

    signal tmp_te0, tmp_te1 : std_logic;
    signal tmp_te_v0, tmp_te_v1 : std_logic;

    signal valid_out_0, valid_out_1 : std_logic;
    signal tag_out_0, tag_out_1 : std_logic_vector( 2 downto 0 );

begin

    cache_set_0 : cache_set port map (enable, write_whole_blk, w_r, address(4 downto 0), data_w(31 downto 0), valid_out_0, tag_out_0(2 downto 0), data_r(31 downto 0));
    cache_set_1 : cache_set port map (enable, write_whole_blk, w_r, address(4 downto 0), data_w(31 downto 0), valid_out_1, tag_out_1(2 downto 0), data_r(31 downto 0));

    comparator_3_tag0 : comparator_3 port map (address(4 downto 2), tag_out_0(2 downto 0), tmp_te0);
    comparator_3_tag1 : comparator_3 port map (address(4 downto 2), tag_out_1(2 downto 0), tmp_te1);

    and_2_0 : and_2 port map (tmp_te0, valid_out_0, tmp_te_v0);
    and_2_1 : and_2 port map (tmp_te0, valid_out_1, tmp_te_v1);

    or_2_0 : or_2 port map (tmp_te0, tmp_te1, hit_miss);

end structural;

----------------------------------------------------------------------------------------------
