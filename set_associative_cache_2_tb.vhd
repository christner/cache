----------------------------------------------------------------------------------------------
--
-- Entity: cache_set_tb
-- Architecture : test
-- Author: danielc3
-- Created On: 11/11/2017
-- Description: Testbench for checking validity of tag, reading, and writing to
--               blocks within set
--
----------------------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

use IEEE.numeric_std.all;

use STD.textio.all;

entity set_associative_cache_2_tb is

end set_associative_cache_2_tb;

architecture test of set_associative_cache_2_tb is

    component set_associative_cache_2 port (
        enable         : in std_logic;
        w_r            : in std_logic;
        address        : in std_logic_vector( 4 downto 0 );
        data_w         : in std_logic_vector( 7 downto 0 );
        hit_miss       : out std_logic;
        data_r         : out std_logic_vector( 7 downto 0 ));
    end component;

    constant CLK_PERIOD : time := 10 ns;

    for cache0 : set_associative_cache_2 use entity work.set_associative_cache_2(structural);

    signal clock : std_logic;

    signal enable, w_r : std_logic := '0';
    signal address : std_logic_vector( 4 downto 0 ) := ( others => '0' );
    signal data_w : std_logic_vector( 7 downto 0 ) := ( others => '0' );
    signal hit_miss : std_logic := '0';
    signal data_r : std_logic_vector( 7 downto 0 ) := ( others => '0' );

begin

    -- map inputs and ouputs
    cache0 : set_associative_cache_2 port map (enable, w_r, address(4 downto 0), data_w(7 downto 0), hit_miss, data_r(7 downto 0));

    clk : process
    begin  -- process clk

        clock <= '0','1' after CLK_PERIOD / 2;
        wait for CLK_PERIOD;

    end process clk;

    io: process
    begin -- process io

        wait; -- done

    end process io;

end test;
