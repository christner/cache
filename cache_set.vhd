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
    enable_set     : in std_logic;
    w_r            : in std_logic;
    address        : in std_logic_vector( 7 downto 0 );
    data_w         : in std_logic_vector( 7 downto 0 );
    rst            : in std_logic;
    valid_r        : out std_logic;
    tag_r          : out std_logic_vector( 2 downto 0 );
    data_r         : out std_logic_vector( 7 downto 0 ));
end cache_set;

architecture structural of cache_set is

    component inverter port (
        input : in std_logic;
        output: out std_logic);
    end component;

    component or_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component and_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component decoder_2 port (
        address: in std_logic_vector( 1 downto 0 );
        output: out std_logic_vector( 3 downto 0 ));
    end component;

    component decoder_3 port (
        address: in std_logic_vector( 2 downto 0 );
        output: out std_logic_vector( 7 downto 0 ));
    end component;

    component cache_block port (
        enable_blk: in std_logic;
        enable_w  : in std_logic_vector( 3 downto 0 );
        enable_r  : in std_logic_vector( 3 downto 0 );
        tag_w     : in std_logic_vector( 2 downto 0 );
        data_w    : in std_logic_vector( 7 downto 0 );
        rst       : in std_logic;
        valid_r   : out std_logic;
        tag_r     : out std_logic_vector( 2 downto 0 );
        data_r    : out std_logic_vector( 7 downto 0 ));
    end component;

    for inverter_r : inverter use entity work.inverter(structural);

    for and_2_we0, and_2_we1, and_2_we2, and_2_we3 : and_2 use entity work.and_2(structural);
    for and_2_re0, and_2_re1, and_2_re2, and_2_re3 : and_2 use entity work.and_2(structural);
    for and_2_be0, and_2_be1, and_2_be2, and_2_be3, and_2_be4, and_2_be5, and_2_be6, and_2_be7 : and_2 use entity work.and_2(structural);

    for decoder_2_0 : decoder_2 use entity work.decoder_2(structural);

    for decoder_3_0 : decoder_3 use entity work.decoder_3(structural);

    for block_0, block_1, block_2, block_3, block_4, block_5, block_6, block_7 : cache_block use entity work.cache_block(structural);

    signal tmp_r : std_logic;

    signal tmp_byte_e : std_logic_vector( 3 downto 0 ); -- byte enable ( address % 4)
    signal we : std_logic_vector( 3 downto 0 ); -- write enable
    signal re : std_logic_vector( 3 downto 0 ); -- read enable

    signal tmp_be : std_logic_vector( 7 downto 0 ); -- temporary lock enable
    signal be : std_logic_vector( 7 downto 0 ); -- block enable

begin

    -- since create a read signal
    inverter_r : inverter port map (w_r, tmp_r);

    -- lets find out which bytes are going to be read/written (lower 2 bits of address 1 -0)
    decoder_2_0 : decoder_2 port map (address(1 downto 0), tmp_byte_e(3 downto 0));

    -- TODO: Another place for an and4_2 entity
    -- enable the bytes we are writing
    and_2_we0 : and_2 port map (tmp_byte_e(0), w_r, we(0));
    and_2_we1 : and_2 port map (tmp_byte_e(1), w_r, we(1));
    and_2_we2 : and_2 port map (tmp_byte_e(2), w_r, we(2));
    and_2_we3 : and_2 port map (tmp_byte_e(3), w_r, we(3));

    -- while reading and writing are mutually exclusive, simply because aren't
    -- writing a byte doesn't mean we are reading, so we can't just invert the
    -- write enable. check which bytes are to be written manually.
    and_2_re0 : and_2 port map (tmp_byte_e(0), tmp_r, re(0));
    and_2_re1 : and_2 port map (tmp_byte_e(1), tmp_r, re(1));
    and_2_re2 : and_2 port map (tmp_byte_e(2), tmp_r, re(2));
    and_2_re3 : and_2 port map (tmp_byte_e(3), tmp_r, re(3));

    -- next we need to decode which block we are enabling (middle 3 bits of address 4 - 2)
    decoder_3_0 : decoder_3 port map(address(4 downto 2), tmp_be(7 downto 0));

    -- and set enable signal with each block enable)
    and_2_be0 : and_2 port map(tmp_be(0), enable_set, be(0));
    and_2_be1 : and_2 port map(tmp_be(1), enable_set, be(1));
    and_2_be2 : and_2 port map(tmp_be(2), enable_set, be(2));
    and_2_be3 : and_2 port map(tmp_be(3), enable_set, be(3));
    and_2_be4 : and_2 port map(tmp_be(4), enable_set, be(4));
    and_2_be5 : and_2 port map(tmp_be(5), enable_set, be(5));
    and_2_be6 : and_2 port map(tmp_be(6), enable_set, be(6));
    and_2_be7 : and_2 port map(tmp_be(7), enable_set, be(7));

    -- enable correct block and subset of bytes; write tag and data if write; retrive valid bit,
    -- tag, and data if read. upper 3 bits of address can be used as the tag
    block_0 : cache_block port map (be(0), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_1 : cache_block port map (be(1), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_2 : cache_block port map (be(2), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_3 : cache_block port map (be(3), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_4 : cache_block port map (be(4), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_5 : cache_block port map (be(5), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_6 : cache_block port map (be(6), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));
    block_7 : cache_block port map (be(7), we(3 downto 0), re(3 downto 0), address (7 downto 5), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));

end structural;

----------------------------------------------------------------------------------------------
