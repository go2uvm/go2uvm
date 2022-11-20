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

entity rx_status_reg is	 
  generic (DATA_WIDTH: integer);
  port (
    wb_clk_i: in std_logic;             -- clock
    status_rd: in std_logic;            -- status register read
    lock: in std_logic;                 -- signal lock status
    chas: in std_logic;                 -- channel A or B select
    rx_block_start: in std_logic;       -- start of block signal
    ch_data: in std_logic;              -- channel status/user data
    cs_a_en: in std_logic;              -- channel status ch. A enable
    cs_b_en: in std_logic;              -- channel status ch. B enable
    status_dout: out std_logic_vector(DATA_WIDTH - 1 downto 0));
end rx_status_reg;

architecture rtl of rx_status_reg is

  signal status_vector : std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal cur_pos : integer range 0 to 255;
  signal pro_mode : std_logic;
  
begin
	
  status_dout <= status_vector when status_rd = '1' else (others => '0');

  D32: if DATA_WIDTH = 32 generate
    status_vector(31 downto 16) <= (others => '0');
  end generate D32;

  status_vector(0) <= lock;
  status_vector(15 downto 7) <= (others => '0');
  
-- extract channel status bits to be used
  CDAT: process (wb_clk_i, lock)
    begin
      if lock = '0' then
        cur_pos <= 0;
        pro_mode <= '0';
        status_vector(6 downto 1) <= (others => '0');
      else
        if rising_edge(wb_clk_i) then
          -- bit counter, 0 to 191
          if rx_block_start = '1' then
            cur_pos <= 0;
          elsif cs_b_en = '1' then -- ch. status #2 comes last, count then
            cur_pos <= cur_pos + 1;
          end if;
          -- extract status bits used in status register
          if (chas = '0' and cs_b_en = '1') or
            (chas = '1' and cs_a_en = '1') then
            case cur_pos is
              when 0 =>                 -- PRO bit
                status_vector(1) <= ch_data;
                pro_mode <= ch_data;
              when 1 =>                 -- AUDIO bit
                status_vector(2) <= not ch_data;
              when 2 =>                 -- emphasis/copy bit
                if pro_mode = '1' then
                  status_vector(5) <= ch_data;
                else
                  status_vector(6) <= ch_data;
                end if;
              when 3 =>                 -- emphasis
                if pro_mode = '1'  then
                  status_vector(4) <= ch_data;
                else
                  status_vector(5) <= ch_data;
                end if;
              when 4 =>                 -- emphasis
                if pro_mode = '1'  then
                  status_vector(3) <= ch_data;
                else
                  status_vector(4) <= ch_data;
                end if;
              when 5 =>                 -- emphasis
                if pro_mode = '0' then
                  status_vector(3) <= ch_data;
                end if;
              when others =>
                null;
            end case;
          end if;
        end if;
      end if;
    end process CDAT;
    
end rtl;
