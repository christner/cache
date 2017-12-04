-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity decoder_2 is port (
    address: in std_logic_vector( 1 downto 0 );
    output : out std_logic_vector( 3 downto 0 ));
end decoder_2;
