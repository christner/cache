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
    write_whole_blk: in std_logic;
    w_r            : in std_logic;
    address        : in std_logic_vector( 4 downto 0 );
    data_w         : in std_logic_vector( 32 downto 0 );
    data_r         : out std_logic_vector( 32 downto 0));
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

    component and_3 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component cache_block port (
        enable_w: in std_logic_vector( 3 downto 0 );
        enable_r: in std_logic_vector( 3 downto 0 );
        data_w  : in std_logic_vector( 35 downto 0);
        data_r  : out std_logic_vector( 35 downto 0));
    end component;

    for inverter_0, inverter_1 : inverter use entity work.inverter(structural);

    for and_2_0, and_2_1, and_2_2, and_2_3 : and_3 use entity work.inverter(structural);
    for or_2_0, or_2_0, or_2_0, or_2_0 : or_2 use entity work.or_2(structural);

    for and_3_be0, and_3_be1, and_3_be2, and_3_be3, and_3_be4, and_3_be5, and_3_be6, and_3_be7 : and_3 use entity work.and_3(structural);

    for block_0, block_1, block_2, block_3, block_4, block_5, block_6, block_7 : cache_block use entity work.cache_block(structural);

    signal tmp_not_0, tmp_not_1, tmp_not_2 : std_logic;
    signal tmp_and_0, tmp_and_1, tmp_and_2 : std_logic;
    signal tmp_or_0, tmp_or_1, tmp_or_2 : std_logic;

    signal tmp_r : std_logic;
    signal tmp_w : std_logic;

    signal be : std_logic_vector( 7 downto 0 ); -- block enable
    signal re : std_logic_vector( 7 downto 0 ); -- read enable

    signal tmp_we : std_logic_vector( 7 downto 0 ); -- temporary write enable
    signal we : std_logic_vector( 7 downto 0 ); -- write enable

begin

    -- invert all address' for decoding logic
    inverter_0 : inverter port map (address(0), tmp_not_0);
    inverter_1 : inverter port map (address(1), tmp_not_1);
    inverter_2 : inverter port map (address(1), tmp_not_1);
    inverter_3 : inverter port map (address(1), tmp_not_1);
    inverter_4 : inverter port map (address(1), tmp_not_1);

    -- since create a read signal
    inverter_r : inverter port map (w, tmp_r);

    -- lets find out which bytes are going to be read/written
    and_2_byte0_e : and_2 port map (tmp_not_0, tmp_not_1, tmp_byte0_e);
    and_2_byte1_e : and_2 port map (address(0), tmp_not_1, tmp_byte1_e);
    and_2_byte2_e : and_2 port map (tmp_not_0, address(1), tmp_byte2_e);
    and_2_byte3_e : and_2 port map (address(0), address(1), tmp_byte3_e);

    -- enable the bytes we are writing
    and_2_we0 : and_2 port map (tmp_byte0_e, w_r, tmp_we(0));
    and_2_we1 : and_2 port map (tmp_byte1_e, w_r, tmp_we(1));
    and_2_we2 : and_2 port map (tmp_byte2_e, w_r, tmp_we(2));
    and_2_we3 : and_2 port map (tmp_byte3_e, w_r, tmp_we(2));

    -- if we are writing the whole block, tick all the blocks
    or_2_we0 : or_2 port map (tmp_we(0), write_whole_blk, we(0));
    or_2_we1 : or_2 port map (tmp_we(1), write_whole_blk, we(1));
    or_2_we2 : or_2 port map (tmp_we(2), write_whole_blk, we(2));
    or_2_we3 : or_2 port map (tmp_we(3), write_whole_blk, we(3));

    -- while reading and writing are mutually exclusive, simply because aren't
    -- writing a byte doesn't mean we are reading, so we can't just invert the
    -- write enable. check which bytes are to be written manually.
    and_2_re0 : and_2 port map (tmp_byte0_e, tmp_r, re(0));
    and_2_re1 : and_2 port map (tmp_byte1_e, tmp_r, re(1));
    and_2_re2 : and_2 port map (tmp_byte2_e, tmp_r, re(2));
    and_2_re3 : and_2 port map (tmp_byte3_e, tmp_r, re(2));

    -- next we need to decode which block we are enabling (upper 3 bits of address)
    and_3_be0 : and_3 port map(tmp_not_2,   tmp_not_3,  tmp_not_4,  be(0));
    and_3_be1 : and_3 port map(address(2),  tmp_not_3,  tmp_not_4,  be(1));
    and_3_be2 : and_3 port map(tmp_not_2,   address(3), tmp_not_4,  be(2));
    and_3_be3 : and_3 port map(address(2),  address(3), tmp_not_4,  be(3));
    and_3_be4 : and_3 port map(tmp_not_2,   tmp_not_3,  address(4), be(4));
    and_3_be5 : and_3 port map(address(2),  tmp_not_3,  address(4), be(5));
    and_3_be6 : and_3 port map(tmp_not_2,   address(3), address(4), be(6));
    and_3_be7 : and_3 port map(tmp_not_2,   tmp_not_3,  tmp_not_4,  be(7));

    -- enable correct block and subset of bytes
    block_0 : cache_block port map (be(0), we(3 downto 0), re(3 downto 0), data_w(31 downto 24), data_r(31 downto 24));
    block_1 : cache_block port map (be(1), we(3 downto 0), re(3 downto 0), data_w(23 downto 16), data_r(23 downto 16));
    block_2 : cache_block port map (be(2), we(3 downto 0), re(3 downto 0), data_w(15 downto 8), data_r(15 downto 8));
    block_3 : cache_block port map (be(3), we(3 downto 0), re(3 downto 0), data_w(7 downto 0), data_r(7 downto 0));
    block_4 : cache_block port map (be(4), we(3 downto 0), re(3 downto 0), data_w(7 downto 0), data_r(7 downto 0));
    block_5 : cache_block port map (be(5), we(3 downto 0), re(3 downto 0), data_w(7 downto 0), data_r(7 downto 0));
    block_6 : cache_block port map (be(6), we(3 downto 0), re(3 downto 0), data_w(7 downto 0), data_r(7 downto 0));
    block_7 : cache_block port map (be(7), we(3 downto 0), re(3 downto 0), data_w(7 downto 0), data_r(7 downto 0));

end structural;

----------------------------------------------------------------------------------------------
