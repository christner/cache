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

    component inverter port (
        input : in std_logic;
        output: out std_logic);
    end component;

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

    component and_8 port (
        input1: in std_logic;
        input2: in std_logic;
        input3: in std_logic;
        input4: in std_logic;
        input5: in std_logic;
        input6: in std_logic;
        input7: in std_logic;
        input8: in std_logic;
        output: out std_logic);
    end component;

    component inverter8_1 port (
        input: in std_logic_vector( 7 downto 0 );
        output: out std_logic_vector( 7 downto 0 ));
    end component;

    component and8_2 port (
        input1: in std_logic_vector( 7 downto 0 );
        input2: in std_logic_vector( 7 downto 0 );
        output: out std_logic_vector( 7 downto 0 ));
    end component;

    component comparator_3 port (
        input1: in std_logic_vector( 2 downto 0 );
        input2: in std_logic_vector( 2 downto 0 );
        output: out std_logic);
    end component;

    component decoder_3 port (
        address: in std_logic_vector( 2 downto 0 );
        output: out std_logic_vector( 7 downto 0));
    end component;

    component cache_cell port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic;
        data_r  : out std_logic);
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

    for inverter_0, inverter_1 : inverter use entity work.inverter(structural);

    for inverter8_1_0 : inverter8_1 use entity work.inverter8_1(structural);

    for or_2_0 : or_2 use entity work.or_2(structural);

    for and_2_tag_eq_0, and_2_tag_eq_1 : and_2 use entity work.and_2(structural);

    for cache_cell_lru0, cache_cell_lru1, cache_cell_lru2, cache_cell_lru3, cache_cell_lru4, cache_cell_lru5, cache_cell_lru6, cache_cell_lru7 : cache_cell use entity work.cache_cell(structural);

    for comparator_3_tag0, comparator_3_tag1 : comparator_3 use entity work.comparator_3(structural);

    for decoder_3_0 : decoder_3 use entity work.decoder_3(structural);

    for cache_set_0, cache_set_1 : cache_set use entity work.cache_set(structural);

    signal tmp_r : std_logic;
    signal tmp_enable : std_logic_vector( 1 downto 0 );

    signal tmp_blk : std_logic_vector( 7 downto 0 );
    signal tmp_bitmask_se0, tmp_bitmask_se1 : std_logic_vector( 7 downto 0);


    signal tmp_se : std_logic_vector( 1 downto 0 ); -- temporary set enable
    signal se : std_logic_vector( 1 downto 0 ); -- set enable

    signal valid_out_0, valid_out_1 : std_logic;
    signal tag_out_0, tag_out_1 : std_logic_vector( 2 downto 0 );
    signal tmp_hit_miss : std_logic;

    signal tmp_tag_eq0, tmp_tag_eq1 : std_logic; -- tag equal
    signal tmp_teq_v0, tmp_teq_v1 : std_logic; -- tag equal and valid

    signal tmp_lru_re : std_logic := '0'; -- we want to tie the lru read enable high
    signal tmp_lru_we : std_logic_vector( 7 downto 0);
    signal tmp_lru_w : std_logic;
    signal tmp_lru_r, tmp_lru_r_not : std_logic_vector( 7 downto 0 );

begin

    -- decode which block is being written/read
    decoder_3_0 : decoder_3 port map (address(4 downto 2), tmp_blk(7 downto 0));

    -- for overwriting blocks, we do not want to just blindly enable a set/block combination
    -- we need to make the enable contigent on the LRU value
    inverter_0 : inverter port map (w_r, tmp_r);

    -- inverter lru for and'ing
    inverter8_1_0 : inverter8_1 port map (tmp_lru_r(7 downto 0));

    -- to find out if our blocks are enabled we do a simple (tmp_block & lru) || ~w_r
    and8_2_se0 : and8_2 port map (tmp_blk, tmp_lru_r_not(7 downto 0), tmp_bitmask_se0(7 downto 0));
    and8_2_se1 : and8_2 port map (tmp_blk, tmp_lru_r(7 downto 0), tmp_bitmask_se1(7 downto 0));

    and8_se0 : and_8 port map (tmp_bitmask_se0(0), tmp_bitmask_se0(1), tmp_bitmask_se0(2), tmp_bitmask_se0(3), tmp_bitmask_se0(4), tmp_bitmask_se0(5), tmp_bitmask_se0(6), tmp_bitmask_se0(7), tmp_se(0));
    and8_se1 : and_8 port map (tmp_bitmask_se1(0), tmp_bitmask_se1(1), tmp_bitmask_se1(2), tmp_bitmask_se1(3), tmp_bitmask_se1(4), tmp_bitmask_se1(5), tmp_bitmask_se1(6), tmp_bitmask_se1(7), tmp_se(1));

    -- if we are writing to the set in question, or reading mark set enabled
    or_2_se0 : or_2 port map (tmp_se(0), tmp_r, se(0));
    or_2_se1 : or_2 port map (tmp_se(1), tmp_r, se(1));

    -- map onto each set
    cache_set_0 : cache_set port map (se(0), write_whole_blk, w_r, address(4 downto 0), data_w(31 downto 0), valid_out_0, tag_out_0(2 downto 0), data_r(31 downto 0));
    cache_set_1 : cache_set port map (se(1), write_whole_blk, w_r, address(4 downto 0), data_w(31 downto 0), valid_out_1, tag_out_1(2 downto 0), data_r(31 downto 0));

    -- check if we have a tag match
    comparator_3_tag0 : comparator_3 port map (address(4 downto 2), tag_out_0(2 downto 0), tmp_tag_eq0);
    comparator_3_tag1 : comparator_3 port map (address(4 downto 2), tag_out_1(2 downto 0), tmp_tag_eq1);

    -- check if tags are valid
    and_2_tag_eq_0 : and_2 port map (tmp_tag_eq0, valid_out_0, tmp_teq_v0);
    and_2_tag_eq_1 : and_2 port map (tmp_tag_eq1, valid_out_1, tmp_teq_v1);

    -- if one of the tags is a hit and is valid, we hit, otherwise, miss
    or_2_0 : or_2 port map (tmp_teq_v1, tmp_teq_v1, tmp_hit_miss);

    hit_miss <= tmp_hit_miss; -- TODO: Ask Dr. Patel about this

    -- need to and each blk with hit miss to decide which lru to use
    and_2_lru_e0 : and_2 port map (tmp_blk(0), tmp_hit_miss, tmp_lru_we(0));
    and_2_lru_e1 : and_2 port map (tmp_blk(1), tmp_hit_miss, tmp_lru_we(1));
    and_2_lru_e2 : and_2 port map (tmp_blk(2), tmp_hit_miss, tmp_lru_we(2));
    and_2_lru_e3 : and_2 port map (tmp_blk(3), tmp_hit_miss, tmp_lru_we(3));
    and_2_lru_e4 : and_2 port map (tmp_blk(4), tmp_hit_miss, tmp_lru_we(4));
    and_2_lru_e5 : and_2 port map (tmp_blk(5), tmp_hit_miss, tmp_lru_we(5));
    and_2_lru_e6 : and_2 port map (tmp_blk(6), tmp_hit_miss, tmp_lru_we(6));
    and_2_lru_e7 : and_2 port map (tmp_blk(7), tmp_hit_miss, tmp_lru_we(7));

    -- we need to map tmp_teq_v0 (1,0) -> 0 and tmp_teq_v1 (0,1) -> 1, we can just use
    -- ~tmp_teq_v0, if we have a (0,0) case we wont write, and we can't get a (1,1) case
    inverter_1 : inverter port map (tmp_teq_v0, tmp_lru_w);

    -- TODO: since this is always reading, there is no reason it couldn't just be a dlatch
    -- if we have a hit on a tag, then it is no longer the least recently used
    -- since there are only 2 possibilities for LRU, it must no be the other set that is LRU
    cache_cell_lru0 : cache_cell port map (tmp_lru_we(0), tmp_lru_re, tmp_lru_w, tmp_lru_r(0));
    cache_cell_lru1 : cache_cell port map (tmp_lru_we(1), tmp_lru_re, tmp_lru_w, tmp_lru_r(1));
    cache_cell_lru2 : cache_cell port map (tmp_lru_we(2), tmp_lru_re, tmp_lru_w, tmp_lru_r(2));
    cache_cell_lru3 : cache_cell port map (tmp_lru_we(3), tmp_lru_re, tmp_lru_w, tmp_lru_r(3));
    cache_cell_lru4 : cache_cell port map (tmp_lru_we(4), tmp_lru_re, tmp_lru_w, tmp_lru_r(4));
    cache_cell_lru5 : cache_cell port map (tmp_lru_we(5), tmp_lru_re, tmp_lru_w, tmp_lru_r(5));
    cache_cell_lru6 : cache_cell port map (tmp_lru_we(6), tmp_lru_re, tmp_lru_w, tmp_lru_r(6));
    cache_cell_lru7 : cache_cell port map (tmp_lru_we(7), tmp_lru_re, tmp_lru_w, tmp_lru_r(7));

end structural;

----------------------------------------------------------------------------------------------
