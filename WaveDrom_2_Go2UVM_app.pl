#----------------------------------------------------------------------
#   Copyright 2004-2016 VerifWorks http://www.verifworks.com 
#   All Rights Reserved Worldwide
#
#   This file is part of Go2UVM (www.go2uvm.org) and developed by 
#   VerifWorks an EDA product and consutling company based in Bangalore, India
#
#    Go2UVM is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Go2UVM is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Go2UVM.  If not, see <http://www.gnu.org/licenses/>.
#
#----------------------------------------------------------------------
use strict;
use warnings;
use diagnostics;
use autodie;
use List::MoreUtils qw(uniq);

my $vw_wd_fname = "waves.wd";
my $vw_wd_f;
my $wd_file_contents;
my $top_mod = "vw_wd_g2u";
my $vw_sv_if_name = "$top_mod" . "_if";
my $vw_sv_if_fname = "$vw_sv_if_name" . ".sv";
my $vw_sv_if_f;
my $vw_test_name = "$top_mod" . "_test";
my $vw_test_fname = "$vw_test_name" . ".sv";
my $vw_test_f;
my $vw_top_name = "$top_mod" . "_top";
my $vw_top_fname = "$vw_top_name" . ".sv";
my $vw_top_f;
# BIG Assumption - clock is named "clk"
# Enhance it later
my $vw_clk_sig_name = "clk";

my $vw_flist_name = "go2uvm";
my $vw_flist_fname = "$vw_flist_name" . ".f";
my $vw_flist_f;

my $vw_make_name = "Makefile";
my $vw_make_fname = "$vw_make_name";
my $vw_make_f;

open $vw_wd_f, '<', $vw_wd_fname or die "Unable to open file: $vw_wd_fname for reading!";
open $vw_flist_f, '>', $vw_flist_fname;
open $vw_make_f, '>', $vw_make_fname;


# Read all content in a single variable
# Override carriage return for this file read alone
undef $/;

$wd_file_contents = <$vw_wd_f>;
close $vw_wd_f;

print  "File contents ..\n";
print $wd_file_contents;
print "\n";

$/ = "\n";     #Restore for normal behaviour later in script

open $vw_sv_if_f, '>', $vw_sv_if_fname or die "Unable to open file: $vw_sv_if_fname for writing!";

open $vw_test_f, '>', $vw_test_fname;
open $vw_top_f, '>', $vw_top_fname;

my @vw_g2u_sigs;
my @vw_g2u_vals;
my @clk_name_arr;
my @data_name_arr;
my @clk_val_arr;
my @data_val_arr_1;
my @data_val_arr;

# First remove this: { signal: [
my @sig_arr = split('signal:', $wd_file_contents);

my @nw_arr = split('},', $sig_arr[1]);


foreach my $val (@nw_arr) {
  # { name: 
  my @name_arr = split('name:', $val);
  my @wave_arr = split('wave:', $val);
  #print "$val\n";
  #print "NA: $name_arr[1]\n";
  #print "WA: $wave_arr[1]\n";
  my @sig_name_arr_1 = split(',', $name_arr[1]);
  my @sig_name_arr = split('"', $sig_name_arr_1[0]);
  #print "SIG: $sig_name_arr[1]\n";
  push @vw_g2u_sigs, $sig_name_arr[1];
  my @wave_val_arr_1 = split(',', $wave_arr[1]);
  my @wave_val_arr = split('"', $wave_val_arr_1[0]);
  #print "WAVE: $wave_val_arr[1]\n";
  push @vw_g2u_vals, $wave_val_arr[1];
}

print "Signal names: @vw_g2u_sigs \n";
print "Signal values: @vw_g2u_vals \n";

my $num_sigs = @vw_g2u_sigs;

my @per_sig_all_values_arr;
my @per_sig_val_arr;
my @per_sig_val_arr_1;
my @per_sig_name_arr;
my $per_sig_value_count;

foreach my $w_val (@vw_g2u_vals) {
  @per_sig_all_values_arr = split('', $w_val);
  $per_sig_value_count = @per_sig_all_values_arr;

  foreach my $per_val_char (@per_sig_all_values_arr) {
    push @per_sig_val_arr, $per_val_char;
    #print "Char: $per_val_char\n";
  }
}

# Replace all . with previous values
#
my $prev_char_v;
  foreach my $per_sig_val_arr_i (@per_sig_val_arr) {
    if ($per_sig_val_arr_i eq ".") {
      push @per_sig_val_arr_1, $prev_char_v;
    } else {
      push @per_sig_val_arr_1, $per_sig_val_arr_i;
      $prev_char_v = $per_sig_val_arr_i;
    }
  }

foreach my $per_sig_val_arr_1_i (@per_sig_val_arr_1) {
    if ($per_sig_val_arr_1_i eq "P") {
      push @clk_val_arr, $per_sig_val_arr_1_i;
    } else {
      push @data_val_arr_1, $per_sig_val_arr_1_i;
    }
}

foreach my $data_val_arr_1_i (@data_val_arr_1) {
    if ($data_val_arr_1_i eq "x") {
      push @data_val_arr, "1'bx";
    } elsif ($data_val_arr_1_i eq "z") {
      push @data_val_arr, "1'bz";
    } else {
      push @data_val_arr, $data_val_arr_1_i;
    }
}


# Separate clock and data name arrays
# BIG Assumption - clock is named "clk"
# Enhance it later
foreach my $vw_g2u_sigs_i (@vw_g2u_sigs) {
  if ($vw_g2u_sigs_i eq $vw_clk_sig_name) {
      push @clk_name_arr, $vw_g2u_sigs_i;
  } else {
      push @data_name_arr, $vw_g2u_sigs_i;
  }
}

for (my $v_per_sig=0; $v_per_sig < $num_sigs; $v_per_sig++) {
  for (my $v_per_val=0; $v_per_val < $per_sig_value_count; $v_per_val++) {
    push @per_sig_name_arr, $vw_g2u_sigs[$v_per_sig];
  }
}

#print " @per_sig_name_arr \n";
#print " @per_sig_val_arr \n";
#print " @per_sig_val_arr_1 \n";
print "Clock name: @clk_name_arr \n";
print "Clock values: @clk_val_arr \n";
print "Data sig names:  @data_name_arr \n";
print "Data sig values: @data_val_arr \n";

my @uniq_clk_names = uniq @clk_name_arr;
$vw_clk_sig_name = $uniq_clk_names[0];
my @uniq_data_names = uniq @data_name_arr;
my $uniq_data_sig_count = @uniq_data_names;
my $total_data_val_count = @data_val_arr;
my $per_sig_val_count =  $total_data_val_count/$uniq_data_sig_count;

# Main body
# Create interface file
vw_dvc_g2u_if();
close $vw_sv_if_f;

# Create Go2UVM Test file
vw_dvc_g2u_test($vw_test_f);
close $vw_test_f;

# Create Top module 
vw_dvc_g2u_top_mod();
close $vw_top_f;

# Create Go2UVM Makefile
PrintMakeFile ();
PrintFlist();

exit(0);


sub vw_dvc_g2u_if {
  
  print $vw_sv_if_f "import uvm_pkg::*;\n";
  print $vw_sv_if_f "import vw_go2uvm_pkg::*;\n";
  print $vw_sv_if_f "`include \"uvm_macros.svh\"\n";
  print $vw_sv_if_f "`include \"vw_go2uvm_macros.svh\"\n";
  print $vw_sv_if_f "interface vw_wd_g2u_if();\n";
  foreach my $vw_clk_itr (@uniq_clk_names) {
    print $vw_sv_if_f "  logic $vw_clk_itr; \n";
  }
  foreach my $vw_data_itr (@uniq_data_names) {
    print $vw_sv_if_f "  logic $vw_data_itr; \n";
  }
  print $vw_sv_if_f "  default clocking cb @ (posedge $vw_clk_sig_name);\n";
  foreach my $vw_data_itr (@uniq_data_names) {
    print $vw_sv_if_f "    output $vw_data_itr; \n";
  }
  print $vw_sv_if_f "  endclocking : cb \n";
  print $vw_sv_if_f "endinterface : vw_wd_g2u_if\n";
} #vw_dvc_g2u_if

sub vw_dvc_g2u_test {
  my $vw_sv_test_f = $_[0];

  print $vw_sv_test_f "// Generating Go2UVM Test for WaveDrom file: $vw_wd_fname\n";
  print $vw_sv_test_f "// ---------------------------------------------------------\n";
  print $vw_sv_test_f "// Automatically generated from VerifWorks's DVCreate-Go2UVM product\n";
  print $vw_sv_test_f "// Thanks for using VerifWorks products, see http://www.verifworks.com for more\n";
  print $vw_sv_test_f "import uvm_pkg::*;\n";
  print $vw_sv_test_f "`include \"vw_go2uvm_macros.svh\"\n";
  print $vw_sv_test_f "// Import Go2UVM Package \n"   ;
  print $vw_sv_test_f "import vw_go2uvm_pkg::*;\n";
  print $vw_sv_test_f "// Use the base class provided by the vw_go2uvm_pkg\n";
  printf $vw_sv_test_f "`G2U_TEST_BEGIN(%s) \n", $vw_test_name;
  print $vw_sv_test_f "  // Create a handle to the actual interface\n";
  printf $vw_sv_test_f "  virtual %s vif; \n\n", $vw_sv_if_name;

  # Code for vif conenction via config_db
  print $vw_sv_test_f "  function void build_phase(uvm_phase phase); \n";
  print $vw_sv_test_f "    if (!uvm_config_db#(virtual $vw_sv_if_name)::get( \n";
  print $vw_sv_test_f "      .cntxt(null), .inst_name(\"*\"), \n";
  print $vw_sv_test_f "      .field_name(\"vif\"), .value(vif))) begin : no_vif\n";
  print $vw_sv_test_f "        `g2u_fatal(\"Unable to connect virtual interface to physical interface, check uvm_config_db::set in top module\") \n";
  print $vw_sv_test_f "    end : no_vif \n";
  print $vw_sv_test_f "    else begin : vif_connected \n";
  print $vw_sv_test_f "      `g2u_display(\"Successfully hooked up virtual interface\") \n";
  print $vw_sv_test_f "    end : vif_connected \n";
  print $vw_sv_test_f "  endfunction : build_phase \n\n";


  print $vw_sv_test_f "  task reset;\n";
  print $vw_sv_test_f "    `uvm_info (log_id, \"Start of reset\", UVM_MEDIUM)\n";
  print $vw_sv_test_f "    `uvm_info (log_id, \"Fill in your reset logic here \", UVM_MEDIUM)\n";
  print $vw_sv_test_f "    // this.vif.cb.rst_n <= 1'b0;\n";
  print $vw_sv_test_f "    // repeat (5) @ (this.vif.cb);\n";
  print $vw_sv_test_f "    // this.vif.cb.rst_n <= 1'b1;\n";
  print $vw_sv_test_f "    // repeat (1) @ (this.vif.cb);\n";
  print $vw_sv_test_f "    `uvm_info (log_id, \"End of reset\", UVM_MEDIUM)\n";
  print $vw_sv_test_f "  endtask : reset\n";
  # Move this to test class 
  my $val_ptr = 0;
  my $vw_sig_count_tmp_1 = 0;
  my $start_val_ptr = 0;
  my $end_val_ptr = 0;
  
  foreach my $vw_data_itr (@uniq_data_names) {
    print $vw_sv_test_f "  task drive_$vw_data_itr(); \n";
    printf $vw_sv_test_f "    `g2u_display(\"Driving signal: %s\") \n", $vw_data_itr;
    $start_val_ptr = ($vw_sig_count_tmp_1 * $per_sig_val_count);
    $end_val_ptr = $start_val_ptr + $per_sig_val_count - 1;
    for (my $vw_i_1 = $start_val_ptr; $vw_i_1 <= $end_val_ptr; $vw_i_1++) {
      print $vw_sv_test_f "    vif.$vw_data_itr <= $data_val_arr[$vw_i_1];\n";
      print $vw_sv_test_f "    @(vif.cb);\n";
    }
    printf $vw_sv_test_f "    `g2u_display(\"End of stimulus for signal: %s\") \n", $vw_data_itr;
    print $vw_sv_test_f "  endtask : drive_$vw_data_itr \n\n";
    $vw_sig_count_tmp_1 ++;
  }
  print $vw_sv_test_f "  task main ();\n";
  print $vw_sv_test_f "    `uvm_info (log_id, \"Start of main\", UVM_MEDIUM)\n";
  print $vw_sv_test_f "    fork \n";
  foreach my $vw_data_itr (@uniq_data_names) {
    print $vw_sv_test_f "     drive_$vw_data_itr(); \n";
  }
  print $vw_sv_test_f "    join \n";
  print $vw_sv_test_f "    // this.vif.cb.inp_1 <= 1'b0;\n";
  print $vw_sv_test_f "    // this.vif.cb.inp_2 <= 22;\n";
  print $vw_sv_test_f "    // repeat (5) @ (this.vif.cb);\n";
  print $vw_sv_test_f "    `uvm_info (log_id, \"End of main\", UVM_MEDIUM)\n";
  print $vw_sv_test_f "  endtask : main\n";
  printf $vw_sv_test_f "`G2U_TEST_END \n";
}


sub vw_dvc_g2u_top_mod {
  my $mod_name   =   $vw_top_name;
  printf $vw_top_f "// Generating Go2UVM top module for DUT: $mod_name\n";
  print $vw_top_f "// ---------------------------------------------------------\n";
  printf $vw_top_f "module %s;\n", $mod_name;
  print $vw_top_f "  timeunit 1ns;\n";
  print $vw_top_f "  timeprecision 1ns;\n";
  print $vw_top_f "  parameter VW_CLK_PERIOD = 10;\n";
  print $vw_top_f "  // Simple clock generator\n";
  print $vw_top_f "  bit $vw_clk_sig_name ;\n";
  print $vw_top_f "  always # (VW_CLK_PERIOD/2) $vw_clk_sig_name <= ~$vw_clk_sig_name;\n";
  print $vw_top_f "  // Interface instance\n";
  printf $vw_top_f "  %s %s_0 (.*);\n", $vw_sv_if_name, $vw_sv_if_name;
  printf $vw_top_f "  assign %s_0.%s = %s; \n\n", $vw_sv_if_name, $vw_clk_sig_name, $vw_clk_sig_name; 
  print $vw_top_f "  // Using VW_Go2UVM\n";
  printf $vw_top_f "  %s %s_0;\n", $vw_test_name, $vw_test_name;
  print $vw_top_f "  initial begin : go2uvm_test\n";
  printf $vw_top_f "    %s_0 = new (); \n\n", $vw_test_name;
  print $vw_top_f "    // Connect virtual interface to physical interface\n";
  printf $vw_top_f "    uvm_config_db#(virtual $vw_sv_if_name)::set( \n";
  print $vw_top_f  "     .cntxt(null), .inst_name(\"*\"), \n";
  printf $vw_top_f "     .field_name(\"vif\"), .value(%s_0)); \n\n", $vw_sv_if_name;
  print $vw_top_f "    // Kick start standard UVM phasing\n";
  print $vw_top_f "    run_test ();\n";
  print $vw_top_f "  end : go2uvm_test\n";
  printf $vw_top_f "endmodule : %s \n", $mod_name;
}

sub PrintMakeFile
{
  printf "Working on Makefile...\n";
  my $text = <<END;
VCS ?= vcs

clean:
	rm -fr csrc* DVE* scsim* led* simv* ucli* inter*  work* *.cm *.daidir *.h vsim.wlf transcript INCA* *.log *.vstf *.key waves.shm dataset* *.cfg .athdl* *.txt* athdl_sv* *~* *.db* compile *.awc .simvision*

cvc1:clean
	\$(VCS) -timescale=1ns/1ns -sverilog -debug_all -lca -ntb_opts uvm-1.1 -f $vw_flist_fname -l comp.log
	./simv +UVM_TESTNAME=$vw_test_name +UVM_VERBOSITY=UVM_FULL -l vcs.log

cvc1_gui:
	./simv +UVM_TESTNAME=$vw_test_name +UVM_VERBOSITY=UVM_HIGH -l vcs.log -gui &


cvc2:clean
	vlib work
	vlog +acc -sv -mfcu -f $vw_flist_fname | tee comp.log 
	vsim -c -assertdebug +UVM_TESTNAME=$vw_test_name +UVM_VERBOSITY=UVM_HIGH $vw_top_name -do "run -a;quit" -l g2u_comp.log 


cvc2_gui:clean
	vlib work
	vlog +acc -sv -mfcu -f $vw_flist_fname 
	vsim -assertdebug +UVM_TESTNAME=$vw_test_name +UVM_VERBOSITY=UVM_HIGH $vw_top_name -do "run -a;" -l g2u_comp.log 
	vcover report -html fcover.ucdb
	firefox covhtmlreport/index.html -l qsta.log

cvc3:clean
	irun -access +rw -uvm -f $vw_flist_fname +UVM_TESTNAME=$vw_test_name +UVM_VERBOSITY=UVM_HIGH -coverage all -l cadence.log

cvc3_gui:clean
	irun -access +rw -uvm -f $vw_flist_fname +UVM_TESTNAME=$vw_test_name +UVM_VERBOSITY=UVM_HIGH -coverage all -l cadence.log -gui &


cvc4:clean
	vsim -c -do rvra_run.do
	firefox fcover_report.html 

cvc4_gui:clean
	vsim -do rvra_run.do
END

  print $vw_make_f "$text";
  printf "Makefile created successfully.\n";
} # PrintMakeFile

sub PrintFlist
{
  print $vw_flist_f "+incdir+\$VW_GO2UVM_HOME/src\n";
  print $vw_flist_f "\$VW_GO2UVM_HOME/src/vw_go2uvm_pkg.sv\n";
  print $vw_flist_f "$vw_sv_if_fname \n";
  print $vw_flist_f "$vw_test_fname \n";
  print $vw_flist_f "$vw_top_fname \n";
  
} # PrintFlist
