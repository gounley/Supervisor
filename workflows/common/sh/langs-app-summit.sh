
SWIFT_IMPL=app
SWIFT=/gpfs/alpine/world-shared/med106/gcc-6.4.0/swift-t-localr

export TCL=/gpfs/alpine/world-shared/med106/gcc-6.4.0/tcl8.6.9
export R=/gpfs/alpine/world-shared/med106/gcc-6.4.0/R-3.5.2/lib64/R
export PY=/gpfs/alpine/world-shared/med106/miniconda3

export PYTHONHOME="/gpfs/alpine/world-shared/med106/miniconda3"
export R_HOME="/gpfs/alpine/world-shared/med106/gcc-6.4.0/R-3.5.2/lib64/R"
PYTHON="$PYTHONHOME/bin/python"
export TCL=/gpfs/alpine/world-shared/med106/gcc-6.4.0/tcl8.6.9
export R=/gpfs/alpine/world-shared/med106/gcc-6.4.0/R-3.5.2/lib64/R
export PY=/gpfs/alpine/world-shared/med106/miniconda3

export PATH=$SWIFT/turbine/bin:$SWIFT/stc/bin:$TCL/bin:$PY/bin:$R/bin:$PATH
export PATH=/sw/summit/gcc/6.4.0/bin:/sw/summit/cuda/9.2.148/bin:$PATH

export LD_LIBRARY_PATH=$PY/lib:$R/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/sw/summit/cuda/9.2.148/lib64:/sw/summit/gcc/6.4.0/lib64:$LD_LIBRARY_PATH

COMMON_DIR=$EMEWS_PROJECT_ROOT/../common/python
PYTHONPATH=$PYTHONHOME/lib/python3.6:$PYTHONPATH
PYTHONPATH=$EMEWS_PROJECT_ROOT/../common/python:$PYTHONPATH
PYTHONPATH=$EMEWS_PROJECT_ROOT/python:$BENCHMARK_DIR:$COMMON_DIR:$SWIFT/turbine/py:$PYTHONPATH
PYTHONPATH=$PYTHONHOME/lib/python3.6/site-packages:$PYTHONPATH

EQR=/gpfs/alpine/world-shared/med106/gcc-6.4.0/EQ-R
EQPy=$WORKFLOWS_ROOT/common/ext/EQ-Py
PYTHONPATH=$EQPy:$PYTHONPATH

export PYTHONPATH
