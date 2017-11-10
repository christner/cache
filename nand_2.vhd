----------------------------------------------------------------------------------------------------
--
-- Entity: nand2
-- Architecture : structural
-- Author: katieb5
-- Created On: 11/10/2017
-- Description:
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity nand_2 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end nand_2;

architecture structural of nand_2 is
begin

  output <= input2 nand input1;

end structural;

----------------------------
