----------------------------------------------------------------------------------------------
--
-- Entity: inverter_test
-- Architecture : vhdl
-- Author: cpatel2
-- Created On: 10/20/00 at 01:55
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

for cell_1 : cache_cellr use entity work.cache_cell(structural);

signal clock : std_logic;
signal enable_w, enable_r, data_w: std_logic;

begin

    cell_1 : cache_cell port map (enable_w, enable_r, data_w, data_r);

    clk : process
    begin  -- process clk

        clock<='0','1' after 5 ns;
        wait for 10 ns;

    end process clk;

    io_process: process
    begin

         enable_w <= 0;
         enable_r <= 0;
         data_w <= 0;

         wait for 10 ns;

         enable_w <= 0;
         enable_r <= 1;
         data_w <= 0;

    end process io_process;

end test;
