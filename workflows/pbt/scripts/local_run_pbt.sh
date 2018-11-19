#! /usr/bin/env bash
set -eu

if [ "$#" -ne 3 ]; then
  script_name=$(basename $0)
  echo "Usage: ${script_name} PROCS EXPERIMENT_ID PARAMS_FILE"
  exit 1
fi

PROCS=$1
EXP_ID=$2

THIS=$( cd $( dirname $0 ) ; /bin/pwd )
ROOT="$THIS/.."
EXP_DIR="$ROOT/experiments/$EXP_ID"
PBT_PY="$ROOT/python/tc1_pbt.py"

BENCHMARKS=$PWD/../../../../Benchmarks
SUPERVISOR=$( cd "$PWD/../../.."  ; /bin/pwd )

echo $BENCHMARKS
echo $SUPERVISOR

# PYTHONPATH=$BENCHMARKS/Pilot1/TC1
PYTHONPATH+=":$BENCHMARKS/common"
PYTHONPATH+=":$SUPERVISOR/workflows/common/python"
PYTHONPATH+=":$ROOT/models/tc1"
export PYTHONPATH=$PYTHONPATH

echo $PYTHONPATH

mkdir -p $EXP_DIR

PARAMS_PATH=$3
cp $PARAMS_PATH $EXP_DIR/
cd $EXP_DIR

PARAMS_FILE=$( basename $PARAMS_PATH)

mpirun -n $PROCS python $PBT_PY $PARAMS_FILE $EXP_DIR tc1 $EXP_ID

cd $THIS
