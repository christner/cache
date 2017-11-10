----------------------------------------------------------------------------------------------------
--
-- Entity: nand3
-- Architecture : structural
-- Author: katieb5
-- Created On: 11/10/2017
-- Description:
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity nand_3 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in std_logic;
    output   : out std_logic);
end nand_3;

architecture structural of nand_3 is
begin

  output <= not (input3 and input2 and input1);

end structural;

----------------------------
