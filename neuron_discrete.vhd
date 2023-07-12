------------------------------------------------------------------
--Copyright 2019 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Engineer: Andrey S. Ionisyan <anserion@gmail.com>
-- 
-- Description: vhdl description of discrete neuron
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity neuron_discrete is
	generic (n:integer:=4; bitwide:integer:=8);
    Port ( 
		X: in std_logic_vector(n-1 downto 0);
		W: in std_logic_vector(bitwide*n-1 downto 0);
		A: out std_logic
	 );
end neuron_discrete;

architecture Behavioral of neuron_discrete is

component scalar_function is
	generic (n:integer:=4; bitwide:integer:=8);
    Port ( 
		X: in std_logic_vector(n-1 downto 0);
		W: in std_logic_vector(bitwide*n-1 downto 0);
		res: out std_logic_vector(bitwide-1 downto 0)
	 );
end component;
signal scalar_res: std_logic_vector(bitwide-1 downto 0):=(others=>'0');

component sgn_function is
	generic (bitwide:integer:=8);
    Port ( 
		X: in std_logic_vector(bitwide-1 downto 0);
		res: out std_logic
	 );
end component;

begin
	scalar_chip: scalar_function generic map(n,bitwide) port map (X, W, scalar_res);
	sgn_chip: sgn_function generic map(bitwide) port map (scalar_res, A);
end Behavioral;
