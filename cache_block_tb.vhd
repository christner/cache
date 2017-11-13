----------------------------------------------------------------------------------------------
--
-- Entity: cache_block_tb
-- Architecture : test
-- Author: danielc3
-- Created On: 11/11/2017
-- Description: Testbench for writing and reading to a cache block consisting
--              of a valid bit, a 3 bit tag, and 4 bytes of data storage
--
----------------------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

use IEEE.numeric_std.all;

use STD.textio.all;

entity cache_block_tb is

end cache_block_tb;

architecture test of cache_block_tb is

    component cache_block port (
        enable_w: in std_logic_vector( 3 downto 0 );
        enable_r: in std_logic_vector( 3 downto 0 );
        data_w  : in std_logic_vector( 35 downto 0 );
        data_r  : out std_logic_vector( 35 downto 0 ));
    end component;

    constant CLK_PERIOD : time := 10 ns;

    for block_0 : cache_block use entity work.cache_block(structural);

    signal clock : std_logic;
    signal enable_w : std_logic_vector( 3 downto 0 ) := ( others => '0' );
    signal enable_r : std_logic_vector( 3 downto 0 ) := ( others => '0' );

    signal data_w : std_logic_vector( 35 downto 0 ) := ( others => '0' );
    signal data_r : std_logic_vector( 35 downto 0 ) := ( others => '0' );

    signal tmp : std_logic_vector( 35 downto 0 ) := ( others => '0' );

begin

    -- map inputs and ouputs
    block_0 : cache_block port map (enable_w(3 downto 0), enable_r(3 downto 0), data_w(35 downto 0), data_r(35 downto 0));

    clk : process
    begin  -- process clk

        clock <= '0','1' after CLK_PERIOD / 2;
        wait for CLK_PERIOD;

    end process clk;

    io: process
    begin -- process io

        -- writing all possible values for data_w (2^36 = 68719476736) is probably
        -- overkill, lets just shift bits in 1 @ a time until we have filled all
        -- 35 bits. sadly, sla and sll are deprecated, so I will have to do it
        -- semi-manually
        for i in 0 to 35 loop
            data_w <= std_logic_vector(shift_left(signed(data_w), 1));
            data_w(0) <= '1';

            wait for CLK_PERIOD;
            enable_w <= (others => '1'); -- write value entire block (overwrite)
            wait for CLK_PERIOD;
            enable_w <= (others => '0');
            wait for CLK_PERIOD;
            enable_r <= (others => '1'); -- read value from block
            wait for CLK_PERIOD;
            enable_r <= (others => '0');

        end loop;

        -- now lets shift in 0's using sll (which shifts in 0s from right)
        for i in 0 to 35 loop
            data_w <= std_logic_vector(shift_left(signed(data_w), 1));
            wait for CLK_PERIOD;
            enable_w <= (others => '1'); -- write value entire block (overwrite)
            wait for CLK_PERIOD;
            enable_w <= (others => '0');
            wait for CLK_PERIOD;
            enable_r <= (others => '1'); -- read value from block
            wait for CLK_PERIOD;
            enable_r <= (others => '0');

        end loop;

        wait; -- done

    end process io;

end test;
