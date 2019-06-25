#! /usr/bin/env bash
set -eu

# Hyperspace WORKFLOW
# Main entry point for hyperspace workflow
# See README.md for more information

# Autodetect this workflow directory
export EMEWS_PROJECT_ROOT=$( cd $( dirname $0 )/.. ; /bin/pwd )
export WORKFLOWS_ROOT=$( cd $EMEWS_PROJECT_ROOT/.. ; /bin/pwd )
if [[ ! -d $EMEWS_PROJECT_ROOT/../../../Benchmarks ]]
then
  echo "Could not find Benchmarks in: $EMEWS_PROJECT_ROOT/../../../Benchmarks"
  exit 1
fi
BENCHMARKS_DEFAULT=$( cd $EMEWS_PROJECT_ROOT/../../../Benchmarks ; /bin/pwd)
export BENCHMARKS_ROOT=${BENCHMARKS_ROOT:-${BENCHMARKS_DEFAULT}}
BENCHMARKS_DIR_BASE=$BENCHMARKS_ROOT/Pilot1/TC1:$BENCHMARKS_ROOT/Pilot1/NT3:$BENCHMARKS_ROOT/Pilot1/P1B1:$BENCHMARKS_ROOT/Pilot1/Combo:$BENCHMARKS_ROOT/Pilot2/P2B1:$BENCHMARKS_ROOT/Pilot3/P3B1:$BENCHMARKS_ROOT/Pilot3/P3B3:$BENCHMARKS_ROOT/Pilot3/P3B4
export BENCHMARK_TIMEOUT
export BENCHMARK_DIR=${BENCHMARK_DIR:-$BENCHMARKS_DIR_BASE}

SCRIPT_NAME=$(basename $0)

# Source some utility functions used by EMEWS in this script
source $WORKFLOWS_ROOT/common/sh/utils.sh

# uncomment to turn on swift/t logging. Can also set TURBINE_LOG,
# TURBINE_DEBUG, and ADLB_DEBUG to 0 to turn off logging
# export TURBINE_LOG=1 TURBINE_DEBUG=1 ADLB_DEBUG=1
export EMEWS_PROJECT_ROOT=$( cd $( dirname $0 )/.. ; /bin/pwd )
# source some utility functions used by EMEWS in this script

usage()
{
  echo "workflow.sh: usage: workflow.sh SITE EXPID CFG_SYS CFG_PRM MODEL_NAME"
}

if (( ${#} != 5 ))
then
  usage
  exit 1
fi

if ! {
  get_site    $1 # Sets SITE
  get_expid   $2 # Sets EXPID
  get_cfg_sys $3
  get_cfg_prm $4
  MODEL_NAME=$5
 }
then
  usage
  exit 1
fi

echo "Running "$MODEL_NAME "workflow"

# Set PYTHONPATH for BENCHMARK related stuff
PYTHONPATH+=:$BENCHMARK_DIR:$BENCHMARKS_ROOT/common

source_site env   $SITE
source_site sched $SITE

# EQ/Py location
# EQPY=$EMEWS_PROJECT_ROOT/ext/EQ-Py
if [[ ${EQPY:-} == "" ]]
then
  abort "The site '$SITE' did not set the location of EQ/PY: this will not work!"
fi

CMD_LINE_ARGS=( -param_set_file=$PARAM_SET_FILE
                # -mb=$MAX_BUDGET
                # -ds=$DESIGN_SIZE
                # -pp=$PROPOSE_POINTS
                -it=$MAX_ITERATIONS
                -exp_id=$EXPID
                -benchmark_timeout=$BENCHMARK_TIMEOUT
                -site=$SITE
                # $RESTART_FILE_ARG
                # $RESTART_NUMBER_ARG
                # $R_FILE_ARG
              )

USER_VARS=( $CMD_LINE_ARGS )
# log variables and script to to TURBINE_OUTPUT directory
log_script

# export EXPID=$1
# export TURBINE_OUTPUT=$EMEWS_PROJECT_ROOT/experiments/$EXPID
# check_directory_exists

# # TODO edit the number of processes as required.
# export PROCS=4

# # TODO edit QUEUE, WALLTIME, PPN, AND TURNBINE_JOBNAME
# # as required. Note that QUEUE, WALLTIME, PPN, AND TURNBINE_JOBNAME will
# # be ignored if MACHINE flag (see below) is not set
# export QUEUE=batch
# export WALLTIME=00:10:00
# export PPN=16
# export TURBINE_JOBNAME="${EXPID}_job"

# # if R cannot be found, then these will need to be
# # uncommented and set correctly.
# # export R_HOME=/path/to/R
# # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$R_HOME/lib
# # export PYTHONHOME=/path/to/python
# export PYTHONPATH=$EMEWS_PROJECT_ROOT/python:$EMEWS_PROJECT_ROOT/ext/EQ-Py

# # Resident task workers and ranks
# export TURBINE_RESIDENT_WORK_WORKERS=1
# export RESIDENT_WORK_RANKS=$(( PROCS - 2 ))

# # EQ/Py location
# EQPY=$EMEWS_PROJECT_ROOT/ext/EQ-Py

# # TODO edit command line arguments, e.g. -nv etc., as appropriate
# # for your EQ/Py based run. $* will pass all of this script's
# # command line arguments to the swift script
# CMD_LINE_ARGS="$* -nv=5 -seed=0"

# # Uncomment this for the BG/Q:
# #export MODE=BGQ QUEUE=default

# # set machine to your schedule type (e.g. pbs, slurm, cobalt etc.),
# # or empty for an immediate non-queued unscheduled run
# MACHINE=""

# if [ -n "$MACHINE" ]; then
#   MACHINE="-m $MACHINE"
# fi

# # Add any script variables that you want to log as
# # part of the experiment meta data to the USER_VARS array,
# # for example, USER_VARS=("VAR_1" "VAR_2")
# USER_VARS=()
# # log variables and script to to TURBINE_OUTPUT directory
# log_script

# # echo's anything following this to standard out
# set -x
# SWIFT_FILE=swift_run_eqpy.swift
# swift-t -n $PROCS $MACHINE -p -I $EQPY -r $EQPY $EMEWS_PROJECT_ROOT/swift/$SWIFT_FILE $CMD_LINE_ARGS
