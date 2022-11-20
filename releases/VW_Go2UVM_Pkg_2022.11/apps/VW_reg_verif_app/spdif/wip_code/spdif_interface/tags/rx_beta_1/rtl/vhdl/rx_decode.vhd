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

entity rx_decode is             
  generic (DATA_WIDTH: integer range 16 to 32;
           ADDR_WIDTH: integer range 8 to 64);   
  port (
    wb_clk_i: in std_logic;
    conf_rxen: in std_logic;
    conf_sample: in std_logic;
    conf_valid: in std_logic;
    conf_mode: in std_logic_vector(3 downto 0);
    conf_blken: in std_logic;
    conf_valen: in std_logic;
    conf_useren: in std_logic;
    conf_staten: in std_logic;
    conf_paren: in std_logic;
    lock: in std_logic;
    rx_data: in std_logic;
    rx_data_en: in std_logic;
    rx_block_start: in std_logic;
    rx_frame_start: in std_logic;
    rx_channel_a: in std_logic; 
    wr_en: out std_logic;
    wr_addr: out std_logic_vector(ADDR_WIDTH - 2 downto 0);
    wr_data: out std_logic_vector(DATA_WIDTH - 1 downto 0);
    stat_paritya: out std_logic;
    stat_parityb: out std_logic;
    stat_lsbf: out std_logic;
    stat_hsbf: out std_logic);
end rx_decode;

architecture rtl of rx_decode is

  signal adr_cnt : integer range 0 to 2**(ADDR_WIDTH - 1) - 1;
  type samp_states is (IDLE, CHA_SYNC, GET_SAMP, PAR_CHK);
  signal sampst : samp_states;
  signal bit_cnt, par_cnt : integer range 0 to 31;
  signal samp_start : integer range 0 to 15;
  signal tmp_data : std_logic_vector(26 downto 0);
  signal tmp_stat : std_logic_vector(4 downto 0);
  signal valid, next_is_a, blk_start : std_logic;
  
begin
  
-- output data
  OD32: if DATA_WIDTH = 32 generate
    wr_data(31 downto 27) <= tmp_stat;
    wr_data(26 downto 0) <= tmp_data(26 downto 0);
  end generate OD32;
  OD16: if DATA_WIDTH = 16 generate
    wr_data(15 downto 0) <= tmp_data(15 downto 0);
  end generate OD16;
  
-- State machine extracting audio samples
  SAEX: process (wb_clk_i, conf_rxen)
  begin  -- process SAEX
    if conf_rxen = '0' then            
      adr_cnt <= 0;
      next_is_a <= '1';
      wr_en <= '0';
      wr_addr <= (others => '0');
      tmp_data <= (others => '0');
      par_cnt <= 0;
      blk_start <= '0';
      stat_paritya <= '0';
      stat_parityb <= '0';
      stat_lsbf <= '0';
      stat_hsbf <= '0';
      valid <= '0';
    elsif rising_edge(wb_clk_i) then
      --extract and store samples
      case sampst is
        when IDLE =>
          next_is_a <= '1';
          if lock = '1' and conf_sample = '1' then
            sampst <= CHA_SYNC;
          end if;
        when CHA_SYNC =>
          wr_addr <= std_logic_vector(to_unsigned(adr_cnt, ADDR_WIDTH - 1));
          wr_en <= '0';
          bit_cnt <= 0;
          valid <= '0';
          par_cnt <= 0;
          stat_paritya <= '0';
          stat_parityb <= '0';
          stat_lsbf <= '0';
          stat_hsbf <= '0';
          tmp_data(26 downto 0) <= (others => '0');
          if rx_block_start = '1' and conf_blken = '1' then
            blk_start <= '1';
          end if;
          if rx_frame_start = '1' and rx_channel_a = next_is_a then
            next_is_a <= not next_is_a;
            sampst <= GET_SAMP;
          end if;
        when GET_SAMP =>
          tmp_stat(0) <= blk_start;
          if rx_data_en = '1' then
            bit_cnt <= bit_cnt + 1;
            -- audio part
            if bit_cnt >= samp_start and bit_cnt <= 23 then
              tmp_data(bit_cnt - samp_start) <= rx_data;
            end if;
            -- status bits
            case bit_cnt is
              when 24 =>                -- validity bit
                valid <= rx_data;
                if conf_valen = '1' then
                  tmp_stat(1) <= rx_data;
                else
                  tmp_stat(1) <= '0';
                end if;
              when 25 =>                -- user data
                if conf_useren = '1' then
                  tmp_stat(2) <= rx_data;
                else
                  tmp_stat(2) <= '0';
                end if;
              when 26 =>                -- channel status
                if conf_staten = '1' then  
                  tmp_stat(3) <= rx_data;
                else
                  tmp_stat(3) <= '0';
                end if;
              when 27 =>                -- parity bit
                if conf_paren = '1' then
                  tmp_stat(4) <= rx_data;
                else
                  tmp_stat(4) <= '0';
                end if;  
              when others =>
                null;
            end case;
            -- parity: count number of 1's
            if rx_data = '1' then
              par_cnt <= par_cnt + 1;
            end if;
          end if;
          if bit_cnt = 28 then
            sampst <= PAR_CHK;
          end if;
        when PAR_CHK =>
          blk_start <= '0';
          if (valid = '0' and conf_valid = '1') or conf_valid = '0' then
            wr_en <= '1';
          end if;
          -- parity check
          if par_cnt mod 2 /= 0 then
            if rx_channel_a = '1' then
              stat_paritya <= '1';
            else
              stat_parityb <= '1';
            end if;
          end if;
          -- address counter
          if adr_cnt < 2**(ADDR_WIDTH - 1) - 1 then
            adr_cnt <= adr_cnt + 1;
          else
            adr_cnt <= 0;
            stat_hsbf <= '1';           -- signal high buffer full
          end if;
          if adr_cnt = 2**(ADDR_WIDTH - 2) - 1 then
            stat_lsbf <= '1';           -- signal low buffer full
          end if;
          sampst <= CHA_SYNC;
        when others =>
          sampst <= IDLE;
      end case;
    end if;
  end process SAEX;

-- determine sample resolution from mode bits in 32bit mode
  M32: if DATA_WIDTH = 32 generate
    samp_start <= 8 when conf_mode = "0000" else
                  7 when conf_mode = "0001" else
                  6 when conf_mode = "0010" else
                  5 when conf_mode = "0011" else
                  4 when conf_mode = "0100" else
                  3 when conf_mode = "0101" else
                  2 when conf_mode = "0110" else
                  1 when conf_mode = "0111" else
                  0 when conf_mode = "1000" else
                  8;
  end generate M32;
-- in 16bit mode only 16bit of audio is supported 
  M16: if DATA_WIDTH = 16 generate
    samp_start <= 8;
  end generate M16;

  
end rtl;
