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
        enable_blk: in std_logic;
        enable_w: in std_logic_vector( 3 downto 0 );
        enable_r: in std_logic_vector( 3 downto 0 );
        tag_w   : in std_logic_vector( 2 downto 0 );
        data_w  : in std_logic_vector( 7 downto 0 );
        rst     : in std_logic;
        valid_r : out std_logic;
        tag_r   : out std_logic_vector( 2 downto 0 );
        data_r  : out std_logic_vector( 7 downto 0 ));
    end component;

    constant CLK_PERIOD : time := 10 ns;

    for block_0 : cache_block use entity work.cache_block(structural);

    signal clock : std_logic;
    signal rst : std_logic := '1';
    signal enable_blk : std_logic := '0';
    signal enable_w : std_logic_vector( 3 downto 0 ) := ( others => '0' );
    signal enable_r : std_logic_vector( 3 downto 0 ) := ( others => '0' );

    signal tag_w : std_logic_vector( 2 downto 0 )  := ( others => '0' );
    signal data_w : std_logic_vector( 7 downto 0 ) := ( others => '0' );

    signal valid_r : std_logic := '0';
    signal tag_r : std_logic_vector( 2 downto 0 ) := ( others => '0' );
    signal data_r : std_logic_vector( 7 downto 0 ) := ( others => '0' );

begin

    -- map inputs and ouputs
    block_0 : cache_block port map (enable_blk, enable_w(3 downto 0), enable_r(3 downto 0), tag_w(2 downto 0), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));

    clk : process
    begin  -- process clk

        clock <= '0','1' after CLK_PERIOD / 2;
        wait for CLK_PERIOD;

    end process clk;

    io: process

        variable be : std_logic_vector ( 3 downto 0 ) := ( 0 => '1', others => '0' ); -- I should have been using variables all this time

        variable bit_disable : std_logic := '0';
        variable bit_enable : std_logic := '1';


    begin -- process io
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;

        -- writing all possible values for data_w (2^36 = 68719476736) is probably
        -- overkill, lets just shift bits in 1 @ a time until we have filled all
        -- 35 bits. sadly, sla and sll are deprecated, so I will have to do it
        -- semi-manually
        for i in 0 to 1 loop
            enable_blk <= std_logic(to_unsigned(i, 1)(0));

            -- attempt to read each before writing to verify invalid on reset
            wait for CLK_PERIOD;
            enable_r <= be(3 downto 0);

            -- reset read signal
            wait for CLK_PERIOD;
            enable_r <= "0000"; -- reset to 0

            for j in 0 to 3 loop

                for k in 0 to 7 loop
                    -- write the value of k to the tag
                    tag_w <= std_logic_vector(to_unsigned(j, 3));

                    -- cycle through 7 values instead of the full 255
                    data_w <= std_logic_vector(shift_left(signed(data_w), 1));
                    data_w(0) <= '1';
                    wait for CLK_PERIOD;
                    enable_w <= be(3 downto 0);

                    -- reset write signal
                    wait for CLK_PERIOD;
                    enable_w <= "0000";

                    wait for CLK_PERIOD;
                    enable_r <= be(3 downto 0);

                    -- reset read signal
                    wait for CLK_PERIOD;
                    enable_r <= "0000"; -- reset to 0

                    be := std_logic_vector(shift_left(unsigned(be), 1));
                end loop;

                data_w <= ( others => '0');
                be := ( 0 => '1', others => '0' );
                wait for CLK_PERIOD;
            end loop;

        end loop;

        -- now lets shift in 0's using sll (which shifts in 0s from right)
        for i in 0 to 1 loop
            enable_blk <= std_logic(to_unsigned(i, 1)(0));

            for j in 0 to 3 loop
                for k in 0 to 7 loop
                    -- write the value of k to the tag
                    tag_w <= std_logic_vector(to_unsigned(j, 3));

                    -- cycle through 7 values instead of the full 255, this time even ones
                    data_w <= std_logic_vector(shift_left(signed(data_w), 1));
                    wait for CLK_PERIOD;
                    enable_w <= be(3 downto 0);

                    -- reset write signal
                    wait for CLK_PERIOD;
                    enable_w <= "0000";

                    wait for CLK_PERIOD;
                    enable_r <= be(3 downto 0);

                    -- reset read signal
                    wait for CLK_PERIOD;
                    enable_r <= "0000"; -- reset to 0

                    be := std_logic_vector(shift_left(unsigned(be), 1));
                end loop;

                data_w <= ( 1 => '1', others => '0');
                be := ( 0 => '1', others => '0' );
                wait for CLK_PERIOD;

            end loop;

        end loop;

        wait; -- done

    end process io;

end test;
