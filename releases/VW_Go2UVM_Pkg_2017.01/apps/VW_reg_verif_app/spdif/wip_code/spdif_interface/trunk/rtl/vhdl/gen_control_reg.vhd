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

entity gen_control_reg is
   generic (DATA_WIDTH      : integer;
            -- note that this vector is (0 to xx), reverse order
            ACTIVE_BIT_MASK : std_logic_vector); 
   port (
      clk       : in  std_logic;        -- clock  
      rst       : in  std_logic;        -- reset
      ctrl_wr   : in  std_logic;        -- control register write  
      ctrl_rd   : in  std_logic;        -- control register read
      ctrl_din  : in  std_logic_vector(DATA_WIDTH - 1 downto 0);  -- write data
      ctrl_dout : out std_logic_vector(DATA_WIDTH - 1 downto 0);  -- read data
      ctrl_bits : out std_logic_vector(DATA_WIDTH - 1 downto 0));  -- control bits
end gen_control_reg;

architecture rtl of gen_control_reg is

   signal ctrl_internal : std_logic_vector(DATA_WIDTH - 1 downto 0);

begin

   ctrl_dout <= ctrl_internal when ctrl_rd = '1' else (others => '0');
   ctrl_bits <= ctrl_internal;

-- control register generation
   CTRLREG : for k in ctrl_din'range generate
      -- active bits can be written to
      ACTIVE : if ACTIVE_BIT_MASK(k) = '1' generate
         CBIT : process (clk, rst)
         begin
            if rst = '1' then
               ctrl_internal(k) <= '0';
            else
               if rising_edge(clk) then
                  if ctrl_wr = '1' then
                     ctrl_internal(k) <= ctrl_din(k);
                  end if;
               end if;
            end if;
         end process CBIT;
      end generate ACTIVE;
      -- inactive bits are always 0
      INACTIVE : if ACTIVE_BIT_MASK(k) = '0' generate
         ctrl_internal(k) <= '0';
      end generate INACTIVE;
   end generate CTRLREG;
   
end rtl;
