#!/bin/bash

PROPOSE_POINTS=${PROPOSE_POINTS:-9}
MAX_CONCURRENT_EVALUATIONS=${MAX_CONCURRENT_EVALUATIONS:-1}
MAX_ITERATIONS=${MAX_ITERATIONS:-3}
MAX_BUDGET=${MAX_BUDGET:-180}
DESIGN_SIZE=${DESIGN_SIZE:-9}
PARAM_SET_FILE=${PARAM_SET_FILE:-$CANDLE/Supervisor/workflows/$WORKFLOW_TYPE/data/nt3_hps_exp_01.R}