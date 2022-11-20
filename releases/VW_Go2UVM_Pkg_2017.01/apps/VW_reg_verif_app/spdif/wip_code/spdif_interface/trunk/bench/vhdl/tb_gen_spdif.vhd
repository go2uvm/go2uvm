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

entity tb_gen_spdif is

end tb_gen_spdif;

architecture behav of tb_gen_spdif is

   component spdif_source
      generic (FREQ : natural);         -- Sampling frequency in Hz
      port (                            -- Bitrate is 64x sampling frequency
         reset : in  std_logic;
         spdif : out std_logic);        -- Output bi-phase encoded signal
   end component;

   component rx_phase_det
      generic (WISHBONE_FREQ : natural);   -- WishBone frequency in MHz
      port (
         wb_clk_i       : in  std_logic;
         rxen           : in  std_logic;
         spdif          : in  std_logic;
         lock           : out std_logic;
         rx_data        : out std_logic;
         rx_data_en     : out std_logic;
         rx_block_start : out std_logic;
         rx_frame_start : out std_logic;
         rx_channel_a   : out std_logic;
         rx_error       : out std_logic;
         ud_a_en        : out std_logic;   -- user data ch. A enable
         ud_b_en        : out std_logic;   -- user data ch. B enable
         cs_a_en        : out std_logic;   -- channel status ch. A enable
         cs_b_en        : out std_logic);  -- channel status ch. B enable);
   end component;

   component rx_decode
      generic (DATA_WIDTH : integer range 16 to 32;
               ADDR_WIDTH : integer range 8 to 64);   
      port (
         wb_clk_i       : in  std_logic;
         conf_rxen      : in  std_logic;
         conf_sample    : in  std_logic;
         conf_valid     : in  std_logic;
         conf_mode      : in  std_logic_vector(3 downto 0);
         conf_blken     : in  std_logic;
         conf_valen     : in  std_logic;
         conf_useren    : in  std_logic;
         conf_staten    : in  std_logic;
         conf_paren     : in  std_logic;
         lock           : in  std_logic;
         rx_data        : in  std_logic;
         rx_data_en     : in  std_logic;
         rx_block_start : in  std_logic;
         rx_frame_start : in  std_logic;
         rx_channel_a   : in  std_logic;
         wr_en          : out std_logic;
         wr_addr        : out std_logic_vector(ADDR_WIDTH - 2 downto 0);
         wr_data        : out std_logic_vector(DATA_WIDTH - 1 downto 0);
         stat_paritya   : out std_logic;
         stat_parityb   : out std_logic;
         stat_lsbf      : out std_logic;
         stat_hsbf      : out std_logic);
   end component;

   signal reset, spdif, rx_frame_start                     : std_logic;
   signal lock, rx_data, rx_data_en, rx_block_start        : std_logic;
   signal rx_channel_a, wb_clk_i, rxen, rx_error           : std_logic;
   signal ud_a_en, ud_b_en, cs_a_en, cs_b_en, zero, one    : std_logic;
   signal stat_paritya, stat_parityb, stat_lsbf, stat_hsbf : std_logic;
   signal wr_en                                            : std_logic;
   signal wr_addr                                          : std_logic_vector(6 downto 0);
   signal wr_data                                          : std_logic_vector(31 downto 0);
   
begin

   zero <= '0';
   one  <= '1';

   -- Soruce generating SPDIF signal used to train the decoder
   GS : spdif_source
      generic map (
         FREQ => 41000)
      port map (
         reset => reset,
         spdif => spdif);

   -- SPDIF phase detector and decoder
   PD : rx_phase_det
      generic map (
         WISHBONE_FREQ => 33)
      port map (
         wb_clk_i       => wb_clk_i,
         rxen           => rxen,
         spdif          => spdif,
         lock           => lock,
         rx_data        => rx_data,
         rx_data_en     => rx_data_en,
         rx_block_start => rx_block_start,
         rx_frame_start => rx_frame_start,
         rx_channel_a   => rx_channel_a,
         rx_error       => rx_error,
         ud_a_en        => ud_a_en,
         ud_b_en        => ud_b_en,
         cs_a_en        => cs_a_en,
         cs_b_en        => cs_b_en);

   -- frame decoder
   FD : rx_decode
      generic map (
         DATA_WIDTH => 32,
         ADDR_WIDTH => 8)
      port map (
         wb_clk_i       => wb_clk_i,
         conf_rxen      => rxen,
         conf_sample    => rxen,
         conf_valid     => zero,
         conf_mode      => "0000",
         conf_blken     => one,
         conf_valen     => zero,
         conf_useren    => zero,
         conf_staten    => zero,
         conf_paren     => one,
         lock           => lock,
         rx_data        => rx_data,
         rx_data_en     => rx_data_en,
         rx_block_start => rx_block_start,
         rx_frame_start => rx_frame_start,
         rx_channel_a   => rx_channel_a,
         wr_en          => wr_en,
         wr_addr        => wr_addr,
         wr_data        => wr_data,
         stat_paritya   => stat_paritya,
         stat_parityb   => stat_parityb,
         stat_lsbf      => stat_lsbf,
         stat_hsbf      => stat_hsbf);

   rxen <= not reset;

   -- just generate a reset signal, the rest is waveform studies...
   process
   begin
      reset <= '1';
      wait for 200 ns;
      reset <= '0';
      wait for 200 ms;
   end process;

   -- assuming a 33MHz Wishbone bus clock
   process
   begin
      wb_clk_i <= '1';
      wait for 15.15 ns;
      wb_clk_i <= '0';
      wait for 15.15 ns;
   end process;
   
end behav;

