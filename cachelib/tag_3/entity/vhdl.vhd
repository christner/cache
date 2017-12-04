-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity tag_3 is port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    data_w  : in std_logic_vector( 2 downto 0 );
    rst     : in std_logic;
    data_r  : out std_logic_vector( 2 downto 0 ));
end tag_3;
