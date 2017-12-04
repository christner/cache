-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of decoder_2 is

    component inverter port (
        input : in  std_logic;
        output: out std_logic);
    end component;

    component and_2 port (
        input1 : in std_logic;
        input2 : in std_logic;
        output: out std_logic);
    end component;

    for inverter_0, inverter_1 : inverter use entity work.inverter(structural);

    for and_2_0, and_2_1, and_2_2, and_2_3 : and_2 use entity work.and_2(structural);

    signal tmp_not : std_logic_vector( 1 downto 0 );

begin

  inverter_0 : inverter port map (address(0), tmp_not(0));
  inverter_1 : inverter port map (address(1), tmp_not(1));

  and_2_0 : and_2 port map (tmp_not(0), tmp_not(1), output(0));
  and_2_1 : and_2 port map (address(0), tmp_not(1), output(1));
  and_2_2 : and_2 port map (tmp_not(0), address(1), output(2));
  and_2_3 : and_2 port map (address(0), address(1), output(3));

end structural;
