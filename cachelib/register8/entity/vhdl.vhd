-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity register8 is port (
    clk   : in std_logic;
    input : in std_logic_vector( 7 downto 0 );
    output: out std_logic_vector( 7 downto 0 ));
end register8;
