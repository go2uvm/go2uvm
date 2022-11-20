-- Copyright (c) 2004-2017 VerifWorks, Bangalore, India
-- http://www.verifworks.com 
-- Contact: support@verifworks.com 
-- 
-- This program is part of Go2UVM at www.go2uvm.org
-- Some portions of Go2UVM are free software.
-- You can redistribute it and/or modify  
-- it under the terms of the GNU Lesser General Public License as   
-- published by the Free Software Foundation, version 3.
--
-- VerifWorks reserves the right to obfuscate part or full of the code
-- at any point in time. 
-- We also support a comemrical licensing option for an enhanced version
-- of Go2UVM, please contact us via support@verifworks.com
--
-- This program is distributed in the hope that it will be useful, but 
-- WITHOUT ANY WARRANTY; without even the implied warranty of 
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
-- Lesser General Lesser Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.


library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity rx_ver_reg is	 
  generic (DATA_WIDTH: integer;
           ADDR_WIDTH: integer;
           CH_ST_CAPTURE: integer);
  port (
    ver_rd: in std_logic; -- version register read
    ver_dout: out std_logic_vector(DATA_WIDTH - 1 downto 0)); -- read data
end rx_ver_reg;

architecture rtl of rx_ver_reg is

  signal version : std_logic_vector(DATA_WIDTH - 1 downto 0);

begin
  ver_dout <= version when ver_rd = '1' else (others => '0');

  -- version vector generation
  version(3 downto 0) <= "0001";        -- version 1
  G32: if DATA_WIDTH = 32 generate
    version(4) <= '1';
    version(31 downto 20) <= (others => '0');
    version(19 downto 16) <=
      std_logic_vector(to_unsigned(CH_ST_CAPTURE, 4));
  end generate G32;
  G16: if DATA_WIDTH = 16 generate
    version(4) <= '0';
  end generate G16;
  version(11 downto 5) <= std_logic_vector(to_unsigned(ADDR_WIDTH, 7));
  version(15 downto 12) <= (others => '0');
 
end rtl;
