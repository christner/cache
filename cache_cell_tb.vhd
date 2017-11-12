----------------------------------------------------------------------------------------------
--
-- Entity: cache_cell_tb
-- Architecture : test
-- Author: danielc3
-- Created On: 11/11/2017
-- Description: Testbench for writing and reading to a single cache cell
--
----------------------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity cache_cell_tb is

end cache_cell_tb;

architecture test of cache_cell_tb is

component cache_cell port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    data_w  : in std_logic;
    data_r  : out std_logic);
end component;

constant CLK_PERIOD : time := 10 ns;

for cell_1 : cache_cell use entity work.cache_cell(structural);

signal clock : std_logic;

signal enable_w : std_logic := '0';
signal enable_r : std_logic := '0';
signal data_w : std_logic := '0';
signal data_r : std_logic := '0';

begin

    cell_1 : cache_cell port map (enable_w, enable_r, data_w, data_r);

    clk : process
    begin  -- process clk

        clock <= '0','1' after CLK_PERIOD / 2;
        wait for CLK_PERIOD;

    end process clk;

    io: process
    begin -- process io

        -- write 0 and read
        wait for CLK_PERIOD;
        enable_w <= '1';

        wait for CLK_PERIOD;
        enable_w <= '0';

        wait for CLK_PERIOD;
        enable_r <= '1';

        wait for CLK_PERIOD;
        enable_r <= '0';

        -- write 1 and read
        data_w <= '1';
        wait for CLK_PERIOD;
        enable_w <= '1';

        wait for CLK_PERIOD;
        enable_w <= '0';

        wait for CLK_PERIOD;
        enable_r <= '1';

        wait for CLK_PERIOD;
        enable_r <= '0';

        wait; -- done

    end process io;

end test;
