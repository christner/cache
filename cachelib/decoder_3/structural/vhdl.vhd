-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of decoder_3 is

    component inverter port (
        input : in  std_logic;
        output: out std_logic);
    end component;

    component and_3 port (
        input1 : in std_logic;
        input2 : in std_logic;
        input3 : in std_logic;
        output: out std_logic);
    end component;

    for inverter_0, inverter_1, inverter_2 : inverter use entity work.inverter(structural);

    for and_3_0, and_3_1, and_3_2, and_3_3, and_3_4, and_3_5, and_3_6, and_3_7 : and_3 use entity work.and_3(structural);

    signal tmp_not : std_logic_vector( 2 downto 0 );

begin

  inverter_0 : inverter port map (address(0), tmp_not(0));
  inverter_1 : inverter port map (address(1), tmp_not(1));
  inverter_2 : inverter port map (address(2), tmp_not(2));

  and_3_0 : and_3 port map (tmp_not(0), tmp_not(1), tmp_not(2), output(0));
  and_3_1 : and_3 port map (address(0), tmp_not(1), tmp_not(2), output(1));
  and_3_2 : and_3 port map (tmp_not(0), address(1), tmp_not(2), output(2));
  and_3_3 : and_3 port map (address(0), address(1), tmp_not(2), output(3));
  and_3_4 : and_3 port map (tmp_not(0), tmp_not(1), address(2), output(4));
  and_3_5 : and_3 port map (address(0), tmp_not(1), address(2), output(5));
  and_3_6 : and_3 port map (tmp_not(0), address(1), address(2), output(6));
  and_3_7 : and_3 port map (address(0), address(1), address(2), output(7));

end structural;
