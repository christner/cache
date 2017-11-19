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

entity cache_set_tb is

end cache_set_tb;

architecture test of cache_set_tb is

    component cache_set port (
        enable_set: in std_logic;
        w_r       : in std_logic;
        address   : in std_logic_vector( 7 downto 0 );
        data_w    : in std_logic_vector( 7 downto 0 );
        rst       : in std_logic;
        valid_r   : out std_logic;
        tag_r     : out std_logic_vector( 2 downto 0 );
        data_r    : out std_logic_vector( 7 downto 0 ));
    end component;

    constant CLK_PERIOD : time := 10 ns;

    for set_0 : cache_set use entity work.cache_set(structural);

    signal clock : std_logic;
    signal rst : std_logic := '1';
    signal enable_set, w_r : std_logic := '0';
    signal address : std_logic_vector( 7 downto 0 ) := ( others => '0' );
    signal data_w : std_logic_vector( 7 downto 0 ) := ( others => '0' );

    signal valid_r : std_logic := '0';
    signal tag_r : std_logic_vector( 2 downto 0 )  := ( others => '0' );
    signal data_r : std_logic_vector( 7 downto 0 ) := ( others => '0' );

    signal write_enable : std_logic := '1';
    signal read_enable : std_logic := '0';
    signal byte_max : std_logic_vector ( 7 downto 0 ) := ( others => '1' );

begin

    -- map inputs and ouputs
    set_0 : cache_set port map (enable_set, w_r, address(7 downto 0), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));

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

        for i in 0 to 1 loop
            enable_set <= std_logic(to_unsigned(i, 1)(0));

            w_r <= read_enable;
            wait for CLK_PERIOD;

            for j in 0 to 255 loop

                -- put address and data in place
                address <= std_logic_vector(to_unsigned(j, 8));
                data_w <= std_logic_vector(to_unsigned(j, 8));

                -- write
                w_r <= write_enable;
                wait for CLK_PERIOD;

                -- read
                w_r <= read_enable;
                wait for CLK_PERIOD;

            end loop;

        end loop;

        wait; -- done

    end process io;

end test;
