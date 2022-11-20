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
use work.rx_package.all;

entity rx_cap_reg is
   port (
      clk            : in  std_logic;   -- clock
      rst            : in  std_logic;   -- reset
      cap_ctrl_wr    : in  std_logic;   -- control register write      
      cap_ctrl_rd    : in  std_logic;   -- control register read
      cap_data_rd    : in  std_logic;   -- data register read
      cap_din        : in  std_logic_vector(31 downto 0);  -- write data
      rx_block_start : in  std_logic;   -- start of block signal
      ch_data        : in  std_logic;   -- channel status/user data
      ud_a_en        : in  std_logic;   -- user data ch. A enable
      ud_b_en        : in  std_logic;   -- user data ch. B enable
      cs_a_en        : in  std_logic;   -- channel status ch. A enable
      cs_b_en        : in  std_logic;   -- channel status ch. B enable
      cap_dout       : out std_logic_vector(31 downto 0);  -- read data
      cap_evt        : out std_logic);  -- capture event (interrupt)
end rx_cap_reg;

architecture rtl of rx_cap_reg is

   signal cap_ctrl_bits, cap_ctrl_dout : std_logic_vector(31 downto 0);
   signal cap_reg, cap_new             : std_logic_vector(31 downto 0);
   signal bitlen, cap_len              : integer range 0 to 63;
   signal bitpos, cur_pos              : integer range 0 to 255;
   signal chid, cdata, compared        : std_logic;
   signal d_enable                     : std_logic_vector(3 downto 0);
   
begin

-- Data bus or'ing
   cap_dout <= cap_reg when cap_data_rd = '1' else cap_ctrl_dout;

-- Capture control register
   CREG : gen_control_reg
      generic map (
         DATA_WIDTH      => 32,
         ACTIVE_BIT_MASK => "11111111111111110000000000000000")
      port map (
         clk       => clk,
         rst       => rst,
         ctrl_wr   => cap_ctrl_wr,
         ctrl_rd   => cap_ctrl_rd,
         ctrl_din  => cap_din,
         ctrl_dout => cap_ctrl_dout,
         ctrl_bits => cap_ctrl_bits);

   chid  <= cap_ctrl_bits(6);
   cdata <= cap_ctrl_bits(7);

-- capture data register
   CDAT : process (clk, rst)
   begin
      if rst = '1' then
         cap_reg  <= (others => '0');
         cap_new  <= (others => '0');
         cur_pos  <= 0;
         cap_len  <= 0;
         cap_evt  <= '0';
         compared <= '0';
         bitpos   <= 0;
         bitlen   <= 0;
      else
         if rising_edge(clk) then
            bitlen <= to_integer(unsigned(cap_ctrl_bits(5 downto 0)));
            bitpos <= to_integer(unsigned(cap_ctrl_bits(15 downto 8)));
            if bitlen > 0 then  -- bitlen = 0 disables the capture function
               -- bit counter, 0 to 191
               if rx_block_start = '1' then
                  cur_pos  <= 0;
                  cap_len  <= 0;
                  cap_new  <= (others => '0');
                  compared <= '0';
               elsif cs_b_en = '1' then  -- ch. status #2 comes last, count then
                  cur_pos <= cur_pos + 1;
               end if;
               -- capture bits
               if cur_pos >= bitpos and cap_len < bitlen then
                  case d_enable is
                     when "0001" =>     -- user data channel A
                        if cdata = '0' and chid = '0' then
                           cap_new(cap_len) <= ch_data;
                           cap_len          <= cap_len + 1;
                        end if;
                     when "0010" =>     -- user data channel B
                        if cdata = '0' and chid = '1' then
                           cap_new(cap_len) <= ch_data;
                           cap_len          <= cap_len + 1;
                        end if;
                     when "0100" =>     -- channel status ch. A
                        if cdata = '1' and chid = '0' then
                           cap_new(cap_len) <= ch_data;
                           cap_len          <= cap_len + 1;
                        end if;
                     when "1000" =>     -- channel status ch. B
                        if cdata = '1' and chid = '1' then
                           cap_new(cap_len) <= ch_data;
                           cap_len          <= cap_len + 1;
                        end if;
                     when others => null;
                  end case;
               end if;
               -- if all bits captured, check with previous data
               if cap_len = bitlen and compared = '0' then
                  compared <= '1';
                  -- event generated if captured bits differ
                  if cap_reg /= cap_new then
                     cap_evt <= '1';
                  end if;
                  cap_reg <= cap_new;
               else
                  cap_evt <= '0';
               end if;
            end if;
         end if;
      end if;
   end process CDAT;

   d_enable(0) <= ud_a_en;
   d_enable(1) <= ud_b_en;
   d_enable(2) <= cs_a_en;
   d_enable(3) <= cs_b_en;

end rtl;
