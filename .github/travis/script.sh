#!/bin/bash

source .github/travis/common.sh
set -e

$SPACER
# Generate yosys binary for the branch quicklogic-rebased
mkdir $HOME/antmicro_install
git clone https://github.com/QuickLogic-Corp/yosys.git -b quicklogic-rebased quicklogic-yosys
cd quicklogic-yosys
sed -i 's/CONFIG := clang/CONFIG := gcc/g' Makefile
#make config-gcc
make install -j10 PREFIX=$HOME/antmicro_install
cd -
export PATH=~/antmicro_install/bin:$PATH
git clone https://github.com/QuickLogic-Corp/yosys-symbiflow-plugins -b ql-ios
cd yosys-symbiflow-plugins
make install
cd -
export YOSYS=$HOME/antmicro_install/bin/yosys

$SPACER

start_section "symbiflow.configure_cmake" "Configuring CMake (make env)"
make env
source env/conda/bin/activate symbiflow_arch_def_base
cd build
end_section "symbiflow.configure_cmake"

$SPACER

# Output some useful info
start_section "info.conda.env" "Info on ${YELLOW}conda environment${NC}"
conda info
end_section "info.conda.env"

start_section "info.conda.config" "Info on ${YELLOW}conda config${NC}"
conda config --show
end_section "info.conda.config"

$SPACER

make_target check_python "Check code formatting"

#$SPACER

#make_target lint_python "Check code style"

$SPACER

make_target test_python "Run Python unit tests"

#$SPACER

#make_target all_merged_arch_xmls "Build all arch XMLs"

#$SPACER

#echo "Suppressing all_rrgraph_xmls generation, as the 8k parts cannot be built on travis."
#start_section "symbiflow.build_all_rrgraph_xmls" "Build all rrgraph XMLs."
#make all_rrgraph_xmls
#end_section "symbiflow.build_all_rrgraph_xmls"

#$SPACER

#make_target all_route_tests "Complete all routing tests"

#$SPACER

#echo "Suppressing some xml linting, as the 5k/8k parts cannot be built on travis."
#make_target all_xml_lint "Complete all xmllint"

$SPACER

# TODO: Check tests are broken, yosys regression?
#start_section "symbiflow.run_check_tests" "Complete all equivalence tests"
#make all_check_tests
#end_section "symbiflow.run_check_tests"

#$SPACER

#echo "Suppressing some demo bitstreams, as the 8k parts cannot be built on travis."
#make_target all "Building all demo bitstreams"

$SPACER

echo "Running quicklogic testsuit"

cd quicklogic/pp3/tests
make_target all_ql_tests
