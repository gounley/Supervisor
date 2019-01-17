# LANGS Titan
# Language settings for Titan (Swift, Python, R, Tcl, etc.)
SWIFT_IMPL=app
SWIFT=/gpfs/alpine/world-shared/med106/gcc-6.4.0/swift-t-localr

export TCL=/gpfs/alpine/world-shared/med106/gcc-6.4.0/tcl8.6.9
export R=/gpfs/alpine/world-shared/med106/gcc-6.4.0/R-3.5.2/lib64/R
export PY=/gpfs/alpine/world-shared/med106/miniconda3

export PATH=$SWIFT/turbine/bin:$SWIFT/stc/bin:$TCL/bin:$PY/bin:$R/bin:$PATH

export LD_LIBRARY_PATH=$PY/lib:$R/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/sw/summit/cuda/9.2.148/lib64:/sw/summit/gcc/6.4.0/lib64:$LD_LIBRARY_PATH

# We do not export PYTHONPATH or PYTHONHOME
# We pass them through swift-t -e, which exports them later
# This is to avoid misconfiguring Python on the login node
# (especially for Cobalt)
PYTHONHOME=/gpfs/alpine/world-shared/med106/miniconda3
COMMON_DIR=$EMEWS_PROJECT_ROOT/../common/python
PYTHONPATH=$EMEWS_PROJECT_ROOT/python:$BENCHMARK_DIR:$COMMON_DIR:$SWIFT/turbine/py
PYTHONHOME=$PY

# EMEWS Queues for R and Python
EQR=/gpfs/alpine/world-shared/med106/gcc-6.4.0/EQ-R
EQPy=$WORKFLOWS_ROOT/common/ext/EQ-Py
PYTHONPATH=$EQPy:$PYTHONPATH

# For test output processing:
LOCAL=0

# Resident task workers and ranks
export TURBINE_RESIDENT_WORK_WORKERS=1
export RESIDENT_WORK_RANKS=$(( PROCS - 2 ))

show     PYTHONHOME
log_path LD_LIBRARY_PATH
log_path PYTHONPATH
