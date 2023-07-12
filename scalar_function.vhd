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
-- Description: vhdl description of scalar multiplication inside neuron
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_signed.all;

entity scalar_function is
	generic (n:integer:= 4; bitwide:integer:=8);
    Port ( 
		X: in std_logic_vector(n-1 downto 0);
		W: in std_logic_vector(bitwide*n-1 downto 0);
		res: out std_logic_vector(bitwide-1 downto 0)
	 );
end scalar_function;

architecture Behavioral of scalar_function is
signal summa: std_logic_vector(bitwide*n-1 downto 0):=(others=>'0');
begin
   
   summa(bitwide-1 downto 0)<=(others=>'0') when X(0)='0' else W(bitwide-1 downto 0);
adders:   
   for i in 1 to n-1 generate
   begin
      summa((i+1)*bitwide-1 downto i*bitwide) <=
           summa(i*bitwide-1 downto (i-1)*bitwide)+W((i+1)*bitwide-1 downto i*bitwide)
      when X(i)='1'
      else summa(i*bitwide-1 downto (i-1)*bitwide)-W((i+1)*bitwide-1 downto i*bitwide);
   end generate;

   res<=summa(n*bitwide-1 downto (n-1)*bitwide);
  
end Behavioral;
