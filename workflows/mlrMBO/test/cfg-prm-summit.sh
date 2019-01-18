# CFG PRM 1

# mlrMBO settings

# Total iterations
PROPOSE_POINTS=${PROPOSE_POINTS:-10}
MAX_CONCURRENT_EVALUATIONS=${MAX_CONCURRENT_EVALUATIONS:-10}
MAX_ITERATIONS=${MAX_ITERATIONS:-5}
MAX_BUDGET=${MAX_BUDGET:-50}
DESIGN_SIZE=${DESIGN_SIZE:-50}

# TODO: move the following code to a utility library-
#       this is a configuration file
# Set the R data file for running
if [ "$MODEL_NAME" = "combo" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/combo_hps_exp_01.R}
elif [ "$MODEL_NAME" = "p1b1" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/p1b1_hps_exp_01.R}
elif [ "$MODEL_NAME" = "nt3" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/nt3_hps_exp_01.R}
elif [ "$MODEL_NAME" = "p1b3" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/p1b3_hps_exp_01.R}
elif [ "$MODEL_NAME" = "p1b2" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/p1b2_hps_exp_01.R}
elif [ "$MODEL_NAME" = "p3b3" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/p3b3_param.R}
elif [ "$MODEL_NAME" = "p3b4" ]; then
    PARAM_SET_FILE=${PARAM_SET_FILE:-$EMEWS_PROJECT_ROOT/data/p3b4_param.R}
elif [ "$PARAM_SET_FILE" != "" ]; then
    PARAM_SET_FILE=${EMEWS_PROJECT_ROOT}/data/${PARAM_SET_FILE}
else
    echo "Invalid model-" $MODEL_NAME
    exit 1
fi
