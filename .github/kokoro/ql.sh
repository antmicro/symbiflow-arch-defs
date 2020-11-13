#!/bin/bash

SCRIPT_SRC="$(realpath ${BASH_SOURCE[0]})"
SCRIPT_DIR="$(dirname "${SCRIPT_SRC}")"

source ${SCRIPT_DIR}/common.sh

echo
echo "========================================================="
echo "Running ql primitives generation (make all_ql_primitives)"
echo "---------------------------------------------------------"
(
	source env/conda/bin/activate symbiflow_arch_def_base
	ninja -j${MAX_CORES} all_ql_primitives
	ninja print_qor > ql_all_primitives_qor.csv
)

echo
echo "========================================================="
echo "Running ql sim.v generation (make QL_CELLS_SIM_DEPS)"
echo "---------------------------------------------------------"
(
	source env/conda/bin/activate symbiflow_arch_def_base
	ninja -j${MAX_CORES} QL_CELLS_SIM_DEPS
	ninja print_qor > ql_all_simv_qor.csv
)
