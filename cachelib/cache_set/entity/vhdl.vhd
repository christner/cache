-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity cache_set is port (
    enable_set     : in std_logic;
    w_r            : in std_logic;
    address        : in std_logic_vector( 7 downto 0 );
    data_w         : in std_logic_vector( 7 downto 0 );
    rst            : in std_logic;
    valid_r        : out std_logic;
    tag_r          : out std_logic_vector( 2 downto 0 );
    data_r         : out std_logic_vector( 7 downto 0 ));
end cache_set;
