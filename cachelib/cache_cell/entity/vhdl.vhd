-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sat Dec  9 22:53:23 2017


library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity cache_cell is port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    data_w  : in std_logic;
    rst     : in std_logic;
    data_r  : out std_logic);
end cache_cell;
