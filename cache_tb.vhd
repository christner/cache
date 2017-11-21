----------------------------------------------------------------------------------------------
--
-- Entity: cache_tb
-- Architecture : test
-- Author: danielc3
-- Created On: 11/20/2017
-- Description: Testbench for checking validity of direct mapped cache
--
----------------------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

use IEEE.numeric_std.all;

use STD.textio.all;

entity cache_tb is

end cache_tb;

architecture test of cache_tb is

    component cache port (
        enable         : in std_logic;
        w_r            : in std_logic;
        address        : in std_logic_vector( 7 downto 0 );
        data_w         : in std_logic_vector( 7 downto 0 );
        overwrite      : in std_logic;
        rst            : in std_logic;
        hit_miss       : out std_logic;
        data_r         : out std_logic_vector( 7 downto 0 ));
    end component;

    constant CLK_PERIOD : time := 10 ns;
    constant WRITE_ENABLE : std_logic := '1';
    constant READ_ENABLE : std_logic := '0';
    constant BIT_ENABLE : std_logic := '1';
    constant BIT_DISABLE : std_logic := '0';

    for cache0 : cache use entity work.cache(structural);

    signal clock : std_logic;
    signal rst : std_logic := '1';
    signal enable, w_r, overwrite : std_logic := '0';
    signal address : std_logic_vector( 7 downto 0 ) := ( others => '0' );
    signal data_w : std_logic_vector( 7 downto 0 ) := ( others => '0' );
    signal hit_miss : std_logic := '0';
    signal data_r : std_logic_vector( 7 downto 0 ) := ( others => '0' );

begin

    -- map inputs and ouputs
    cache0 : cache port map (enable, w_r, address(7 downto 0), data_w(7 downto 0), overwrite, rst, hit_miss, data_r(7 downto 0));

    clk : process
    begin  -- process clk

        clock <= '0','1' after CLK_PERIOD / 2;
        wait for CLK_PERIOD;

    end process clk;

    io: process
    begin -- process io

        -- async reset
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;

        address <= "00000000";
        w_r <= WRITE_ENABLE;
        enable <= BIT_ENABLE;

        wait for CLK_PERIOD;
        wait for CLK_PERIOD;

        enable <= BIT_DISABLE;

        for i in 0 to 1 loop
            --enable <= std_logic(to_unsigned(i, 1)(0));  -- enabled works

            for j in 0 to 63 loop

                -- put address and data in place
                address <= std_logic_vector(to_unsigned(j, 8));
                data_w <= std_logic_vector(to_unsigned(j, 8));

                -- write
                overwrite <= not(std_logic(to_unsigned(i, 1)(0)));
                w_r <= WRITE_ENABLE;
                enable <= BIT_ENABLE;
                wait for CLK_PERIOD;
                wait for CLK_PERIOD;
                enable <= BIT_DISABLE;
                overwrite <= BIT_DISABLE;

                wait for CLK_PERIOD;

                -- read
                w_r <= READ_ENABLE;
                enable <= BIT_ENABLE;
                wait for CLK_PERIOD;
                wait for CLK_PERIOD;
                enable <= BIT_DISABLE;


            end loop;
            wait for CLK_PERIOD;

        end loop;

        wait; -- done

    end process io;

end test;
