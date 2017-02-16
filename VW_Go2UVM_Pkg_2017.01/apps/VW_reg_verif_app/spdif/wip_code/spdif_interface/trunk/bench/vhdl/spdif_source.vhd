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

entity spdif_source is
   generic (FREQ : natural);            -- Sampling frequency in Hz
   port (                               -- Bitrate is 64x sampling frequency
      reset : in  std_logic;
      spdif : out std_logic);           -- Output bi-phase encoded signal
end spdif_source;

architecture behav of spdif_source is

   constant X_Preamble : std_logic_vector(7 downto 0) := "11100010";
   constant Y_Preamble : std_logic_vector(7 downto 0) := "11100100";
   constant Z_Preamble : std_logic_vector(7 downto 0) := "11101000";
   signal clk, ispdif  : std_logic;
   signal fcnt         : natural range 0 to 191;  -- frame counter
   signal bcnt         : natural range 0 to 63;   -- subframe bit counter
   signal pcnt         : natural range 0 to 63;   -- parity counter
   signal toggle       : integer range 0 to 1;
   -- Channel A: sinewave with frequency=Freq/12
   type sine16 is array (0 to 15) of std_logic_vector(15 downto 0);
   signal channel_a : sine16 := ((x"8000"), (x"b0fb"), (x"da82"), (x"f641"),
                                 (x"ffff"), (x"f641"), (x"da82"), (x"b0fb"),
                                 (x"8000"), (x"4f04"), (x"257d"), (x"09be"),
                                 (x"0000"), (x"09be"), (x"257d"), (x"4f04"));
   -- channel B: sinewave with frequency=Freq/24
   type sine8 is array (0 to 7) of std_logic_vector(15 downto 0);
   signal channel_b : sine8 := ((x"8000"), (x"da82"), (x"ffff"), (x"da82"),
                                (x"8000"), (x"257d"), (x"0000"), (x"257d"));
   signal channel_status : std_logic_vector(0 to 191);

begin

   spdif          <= ispdif;
   channel_status <= (others => '0');

-- Generate SPDIF signal 
   SGEN : process (clk, reset)
   begin
      if reset = '1' then
         fcnt   <= 184;  -- start just before block to shorten simulation
         bcnt   <= 0;
         toggle <= 0;
         ispdif <= '0';
         pcnt   <= 0;
      elsif rising_edge(clk) then
         if toggle = 1 then
            -- frame counter: 0 to 191
            if fcnt < 191 then
               if bcnt = 63 then
                  fcnt <= fcnt + 1;
               end if;
            else
               fcnt <= 0;
            end if;
            -- subframe bit counter: 0 to 63
            if bcnt < 63 then
               bcnt <= bcnt + 1;
            else
               bcnt <= 0;
            end if;
         end if;
         if toggle = 0 then
            toggle <= 1;
         else
            toggle <= 0;
         end if;
         -- subframe generation
         if fcnt = 0 and bcnt < 4 then
            ispdif <= Z_Preamble(7 - 2* bcnt - toggle);
         elsif fcnt > 0 and bcnt < 4 then
            ispdif <= X_Preamble(7 - 2 * bcnt - toggle);
         elsif bcnt > 31 and bcnt < 36 then
            ispdif <= Y_Preamble(71 - 2 * bcnt - toggle);
         end if;
         -- aux data, and 4 LSB are zero
         if (bcnt > 3 and bcnt < 12) or (bcnt > 35 and bcnt < 44) then
            if toggle = 0 then
               ispdif <= not ispdif;
            end if;
         end if;
         -- chanmel A data
         if (bcnt > 11) and (bcnt < 28) then
            if channel_a(fcnt mod 16)(bcnt - 12) = '0' then
               if toggle = 0 then
                  ispdif <= not ispdif;
               end if;
            else
               ispdif <= not ispdif;
               if toggle = 0 then
                  pcnt <= pcnt + 1;
               end if;
            end if;
         end if;
         -- channel B data
         if (bcnt > 43) and (bcnt < 60) then
            if channel_b(fcnt mod 8)(bcnt - 44) = '0' then
               if toggle = 0 then
                  ispdif <= not ispdif;
               end if;
            else
               ispdif <= not ispdif;
               if toggle = 0 then
                  pcnt <= pcnt + 1;
               end if;
            end if;
         end if;
         -- validity bit always 0
         if bcnt = 28 or bcnt = 60 then
            if toggle = 0 then
               ispdif <= not ispdif;
            end if;
         end if;
         -- user data always 0
         if bcnt = 29 or bcnt = 61 then
            if toggle = 0 then
               ispdif <= not ispdif;
            end if;
         end if;
         -- channel status bit
         if bcnt = 30 or bcnt = 62 then
            if channel_status(fcnt) = '0' then
               if toggle = 0 then
                  ispdif <= not ispdif;
               end if;
            else
               ispdif <= not ispdif;
               if toggle = 0 then
                  pcnt <= pcnt + 1;
               end if;
            end if;
         end if;
         -- parity bit, even parity
         if bcnt = 0 or bcnt = 32 then
            pcnt <= 0;
         end if;
         if bcnt = 31 or bcnt = 63 then
            if (pcnt mod 2) = 1 then
               ispdif <= not ispdif;
            else
               if toggle = 0 then
                  ispdif <= not ispdif;
               end if;
            end if;
         end if;
      end if;
   end process SGEN;

-- Clock process, generate a clock based on the desired sampling frequency    
   CLKG : process
      variable t1 : time := 1.0e12/real(FREQ*256) * 1 ps;
   begin
      clk <= '0';
      wait for t1;
      clk <= '1';
      wait for t1;
   end process CLKG;
   
end behav;
