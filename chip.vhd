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

    component mux8_2 port (
        input1: in std_logic_vector( 7 downto 0 );
        input2: in std_logic_vector( 7 downto 0 );
        sel   : in std_logic;
        output: out std_logic_vector( 7 downto 0 ));
    end component;

    component register8 port (
        clk   : in std_logic;
        input : in std_logic_vector(7 downto 0 );
        output: out std_logic_vector( 7 downto 0 ));
    end component;

    component cache_byte port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic_vector( 7 downto 0 );
        rst     : in std_logic;
        data_r  : out std_logic_vector( 7 downto 0 ));
    end component;

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

    component cache port (
        enable   : in std_logic;
        w_r      : in std_logic;
        address  : in std_logic_vector( 7 downto 0 );
        data_w   : in std_logic_vector( 7 downto 0 );
        overwrite: in std_logic;
        rst      : in std_logic;
        hit_miss : out std_logic;
        data_r   : out std_logic_vector( 7 downto 0 ));
    end component;

    for mux8_2_0 : mux8_2 use entity work.mux8_2(structural);

    for cache_byte_0 : cache_byte use entity work.cache_byte(structural);

    for register8_0, register8_1 : register8 use entity work.register8(structural);

    for state_machine_0 : state_machine use entity work.state_machine(structural);

    for cache_0 : cache use entity work.cache(structural);

    signal cache_enable, hit_miss, overwrite : std_logic;
    signal tmp_data, data, data_r : std_logic_vector( 7 downto 0 );

begin

    -- mux cpu data and mem_data into data depending on if we are grabbing information from memory
    mux8_2_0 : mux8_2 port map (cpu_data, mem_data, mem_en, tmp_data);

    -- grab incoming data and hold
    register8_0 : register8 port map(clk, tmp_data, data);

    -- map inputs into the state machine
    state_machine_0 : state_machine port map (start, reset, hit_miss, cpu_rd_wrn, clk, busy, cache_enable, mem_en);

    -- map inputs into the cache
    -- TODO: put overwrite back
    cache_0 : cache port map (cache_enable, cpu_rd_wrn, cpu_add(7 downto 0),  data(7 downto 0), reset, hit_miss, data_r(7 downto 0));

    -- grab the address for later use mem_add -> cpu_add
    register8_1 : register8 port map(clk, cpu_add, mem_add);

    -- 8 bit cache cells for data_r -> cpu_data, this needs to go Z when not in use
    cache_byte_0 : cache_byte port map(start, start, data_r, reset, cpu_data);


end structural;

----------------------------------------------------------------------------------------------
