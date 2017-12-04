-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity state_machine is port (
  START : in std_logic;
  RESET : in std_logic;
  HitMiss : in std_logic;
  RdWr : in std_logic;
  CLOCK : in std_logic;
  BUSY : out std_logic;
  CacheEnable : out std_logic;
  OverwriteBlk : out std_logic;
  MemEnable : out std_logic
); end state_machine;
