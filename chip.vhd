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

entity chip is port (
    cpu_add    : in  std_logic_vector(7 downto 0);
    cpu_data   : inout  std_logic_vector(7 downto 0);
    cpu_rd_wrn : in  std_logic;
    start      : in  std_logic;
    clk        : in  std_logic;
    reset      : in  std_logic;
    mem_data   : in  std_logic_vector(7 downto 0);
    Vdd	       : in  std_logic;
    Gnd        : in  std_logic;
    busy       : out std_logic;
    mem_en     : out std_logic;
    mem_add    : out std_logic_vector(7 downto 0));
end chip;

architecture structural of chip is

    component state_machine port (
        START : in std_logic;
        RESET : in std_logic;
        HitMiss : in std_logic;
        RdWr : in std_logic;
        CLOCK : in std_logic;
        BUSY : out std_logic;
        CacheEnable : out std_logic;
        MemEnable : out std_logic);
    end component;

    component set_associative_cache_2 port (
        enable         : in std_logic;
        w_r            : in std_logic;
        address        : in std_logic_vector( 7 downto 0 );
        data_w         : in std_logic_vector( 7 downto 0 );
        hit_miss       : out std_logic;
        data_r         : out std_logic_vector( 7 downto 0 ));
    end component;

    for state_machine_0 : state_machine use entity work.state_machine(structural);

    for cache_0 : set_associative_cache_2 use entity work.set_associative_cache_2(structural);

    signal cache_enable, hit_miss : std_logic;
    signal data : std_logic_vector( 7 downto 0 );

begin

    -- TODO: need to mux cpu data and mem_data into data

    state_machine_0 : state_machine port map (start, reset, hit_miss, cpu_rd_wrn, clk, busy, cache_enable, mem_en);

    cache_0 : set_associative_cache_2 port map (cache_enable, cpu_rd_wrn, cpu_add(7 downto 0),  data(7 downto 0), reset, hit_miss, data_r(7 downto 0));

    -- TODO: add 8 bit dlatches for mem_add -> cpu_add
    -- TODO: add 8 bit dlatches for data_r -> cpu_data

end structural;

----------------------------------------------------------------------------------------------
