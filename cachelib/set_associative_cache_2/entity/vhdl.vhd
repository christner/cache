-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity set_associative_cache_2 is port (
    enable         : in std_logic;
    w_r            : in std_logic;
    address        : in std_logic_vector( 7 downto 0 );
    data_w         : in std_logic_vector( 7 downto 0 );
    overwrite      : in std_logic;
    rst            : in std_logic;
    hit_miss       : out std_logic;
    data_r         : out std_logic_vector( 7 downto 0 ));
end set_associative_cache_2;
