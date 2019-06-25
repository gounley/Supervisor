#!/bin/bash
set -eu

usage()
{
  echo "Usage: test BENCHMARK_NAME SITE RUN_DIR(optional)"
  echo "       RUN_DIR is optional, use -a for automatic"
}

RUN_DIR=""
if (( ${#} == 3 ))
then
	RUN_DIR=$3
elif (( ${#} == 2 )) # test-all uses this
then
	RUN_DIR="-a"
else
        usage
        exit 1
fi

export MODEL_NAME=$1
SITE=$2

# Self-configure
THIS=$( cd $( dirname $0 ) && /bin/pwd )
EMEWS_PROJECT_ROOT=$( cd $THIS/.. && /bin/pwd )
export EMEWS_PROJECT_ROOT
WORKFLOWS_ROOT=$( cd $EMEWS_PROJECT_ROOT/.. && /bin/pwd )
source $WORKFLOWS_ROOT/common/sh/utils.sh

# Select configurations
export CFG_SYS=$THIS/cfg-sys-1.sh
export CFG_PRM=$THIS/cfg-prm-1.sh

# Specify the R file for This file must be present in the $EMEWS_PROJECT_ROOT/R
export R_FILE=mlrMBO-ils.R

# What to return from the objective function (Keras model)
# val_loss (default) and val_corr are supported
export OBJ_RETURN="val_loss"

if [[ $SITE == "theta" ]]
then
  export WAIT=1
fi

# Submit job
# echo $EMEWS_PROJECT_ROOT $SITE $RUN_DIR $CFG_SYS $CFG_PRM $MODEL_NAME
$EMEWS_PROJECT_ROOT/swift/workflow.sh $SITE $RUN_DIR $CFG_SYS $CFG_PRM $MODEL_NAME

export TURBINE_JOBNAME="JOB:${EXPID}"

RESTART_FILE_ARG=""
if [[ ${RESTART_FILE:-} != "" ]]
then
  RESTART_FILE_ARG="--restart_file=$RESTART_FILE"
fi

RESTART_NUMBER_ARG=""
if [[ ${RESTART_NUMBER:-} != "" ]]
then
  RESTART_NUMBER_ARG="--restart_number=$RESTART_NUMBER"
fi

#Store scripts to provenance
#copy the configuration files and R file (for mlrMBO params) to TURBINE_OUTPUT
cp $PARAM_SET_FILE $CFG_SYS $CFG_PRM $TURBINE_OUTPUT

# Make run directory in advance to reduce contention
mkdir -pv $TURBINE_OUTPUT/run

# Allow the user to set an objective function
OBJ_DIR=${OBJ_DIR:-$WORKFLOWS_ROOT/common/swift}
OBJ_MODULE=${OBJ_MODULE:-obj_$SWIFT_IMPL}
# This is used by the obj_app objective function
# Andrew: Allows for custom model.sh file, if that's desired
export MODEL_SH=${MODEL_SH:-$WORKFLOWS_ROOT/common/sh/model.sh}

# WAIT_ARG=""
# if (( ${WAIT:-0} ))
# then
#   WAIT_ARG="-t w"
#   echo "Turbine will wait for job completion."
# fi

# swift-t -n $PROCS \
#         ${MACHINE:-} \
#         -p -I $EQR -r $EQR \
#         -I $OBJ_DIR \
#         -i $OBJ_MODULE \
#         -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
#         -e TURBINE_RESIDENT_WORK_WORKERS=$TURBINE_RESIDENT_WORK_WORKERS \
#         -e RESIDENT_WORK_RANKS=$RESIDENT_WORK_RANKS \
#         -e BENCHMARKS_ROOT \
#         -e EMEWS_PROJECT_ROOT \
#         $( python_envs ) \
#         -e TURBINE_OUTPUT=$TURBINE_OUTPUT \
#         -e OBJ_RETURN \
#         -e MODEL_PYTHON_SCRIPT=${MODEL_PYTHON_SCRIPT:-} \
#         -e MODEL_PYTHON_DIR=${MODEL_PYTHON_DIR:-} \
#         -e MODEL_SH \
#         -e MODEL_NAME \
#         -e SITE \
#         -e BENCHMARK_TIMEOUT \
#         -e SH_TIMEOUT \
#         -e IGNORE_ERRORS \
#         $WAIT_ARG \
#         $EMEWS_PROJECT_ROOT/swift/workflow.swift ${CMD_LINE_ARGS[@]}

# # Andrew: Needed this so that script to monitor job worked properly (queue_wait... function in utils.sh?)
# echo $TURBINE_OUTPUT > turbine-directory.txt
