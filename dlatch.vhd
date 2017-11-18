--------------------------------------------------------------------------------------------------
--
-- Entity: dlatch
-- Architecture : structural
-- Author: cpatel2
-- Created On:
-- Description:
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity dlatch is port (
    d   : in std_logic;
    clk : in std_logic;
    rst : in std_logic;
    q   : out std_logic;
    qbar: out std_logic);
end dlatch;

architecture structural of dlatch is
begin

    output: process (d,clk)
    begin
        if rst = '1'
        then

            q <= '0';
            qbar <= '1';

        elsif clk = '1'
        then

            q <= d;
            qbar <= not d ;

        end if;
    end process output;

end structural;

--------------------------------------------------------------------------------------------------
