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

library IEEE;
use IEEE.std_logic_1164.all;

entity gen_event_reg is
   generic (DATA_WIDTH : integer := 32);
   port (
      clk      : in  std_logic;         -- clock  
      rst      : in  std_logic;         -- reset
      evt_wr   : in  std_logic;         -- event register write     
      evt_rd   : in  std_logic;         -- event register read
      evt_din  : in  std_logic_vector(DATA_WIDTH - 1 downto 0);  -- write data
      event    : in  std_logic_vector(DATA_WIDTH - 1 downto 0);  -- event vector
      evt_mask : in  std_logic_vector(DATA_WIDTH - 1 downto 0);  -- irq mask
      evt_en   : in  std_logic;         -- irq enable
      evt_dout : out std_logic_vector(DATA_WIDTH - 1 downto 0);  -- read data
      evt_irq  : out std_logic);        -- interrupt  request
end gen_event_reg;

architecture rtl of gen_event_reg is

   signal evt_internal, zero : std_logic_vector(DATA_WIDTH - 1 downto 0);

begin

   evt_dout <= evt_internal when evt_rd = '1' else (others => '0');
   zero     <= (others                                     => '0');

-- IRQ generation:
-- IRQ signal will pulse low when writing to the event register. This will
-- capture situations when not all active events are cleared or an event happens
-- at the same time as it is cleared.
   IR : process (clk)
   begin
      if rising_edge(clk) then
         if ((evt_internal and evt_mask) /= zero) and evt_wr = '0'
            and evt_en = '1' then
            evt_irq <= '1';
         else
            evt_irq <= '0';
         end if;
      end if;
   end process IR;

-- event register generation   
   EVTREG : for k in evt_din'range generate
      EBIT : process (clk, rst)
      begin
         if rst = '1' then
            evt_internal(k) <= '0';
         else
            if rising_edge(clk) then
               if event(k) = '1' then                        -- set event
                  evt_internal(k) <= '1';
               elsif evt_wr = '1' and evt_din(k) = '1' then  -- clear event
                  evt_internal(k) <= '0';
               end if;
            end if;
         end if;
      end process EBIT;
   end generate EVTREG;
   
end rtl;
