# LANGS Titan
# Language settings for Titan (Swift, Python, R, Tcl, etc.)
SWIFT_IMPL=app
TCL=/ccs/proj/med106/gounley1/summit/tcl8.6.9

export R=/ccs/proj/med106/gounley1/summit/R-3.5.2/lib64/R
export PY=/ccs/home/gounley1/summit/tensorflow-1.12-p3/anaconda3
export LD_LIBRARY_PATH=$PY/lib:$R/lib:$LD_LIBRARY_PATH

# We do not export PYTHONPATH or PYTHONHOME
# We pass them through swift-t -e, which exports them later
# This is to avoid misconfiguring Python on the login node
# (especially for Cobalt)
PYTHONHOME=/ccs/home/gounley1/summit/tensorflow-1.12-p3/anaconda3

export LD_LIBRARY_PATH=/ccs/home/gounley1/summit/tensorflow-1.12-p3/9.2.148/lib64:/sw/summit/gcc/4.8.5/lib64:LD_LIBRARY_PATH

export PATH=/ccs/proj/med106/gounley1/summit/swift-t/stc/bin:$PATH

# EMEWS Queues for R
EQR=/ccs/proj/med106/gounley1/summit/EQ-R
EQPy=$WORKFLOWS_ROOT/common/ext/EQ-Py

# For test output processing:
LOCAL=0

# Resident task workers and ranks
export TURBINE_RESIDENT_WORK_WORKERS=1
export RESIDENT_WORK_RANKS=$(( PROCS - 2 ))

log_path PYTHONPATH
