#!/bin/bash

#BSUB -P getenv(PROJECT)
#BSUB -nnodes getenv(NODES)
#BSUB -W getenv(WALLTIME)
#BSUB -J getenv(EXP_ID)
#BSUB -o getenv_nospace(EXP_DIR)/output.txt
#BSUB -alloc_flags "smt4"

module load gcc/4.8.5
module load spectrum-mpi/10.2.0.10-20181214
export btl_openib_warn_default_gid_prefix=0

export PATH=/gpfs/alpine/world-shared/med106/miniconda3/bin:$PATH

#export LD_LIBRARY_PATH=/gpfs/alpine/world-shared/med106/miniconda3/bin/lib:/sw/summit/gcc/4.8.5/lib64:LD_LIBRARY_PATH

export PYTHONHOME="/gpfs/alpine/world-shared/med106/miniconda3"
export PATH="$PYTHONHOME/bin:$PATH"

export LD_LIBRARY_PATH="$PYTHONHOME/lib:/sw/summit/cuda/9.2.148/lib64:/sw/summit/gcc/6.4.0/lib64:/sw/summit/r/3.5.0/rhel7.4_gnu4.8.5/olcf/support/lib"

PYTHONPATH=/gpfs/alpine/world-shared/med106/miniconda3/lib/python3.6/site-packages:/gpfs/alpine/world-shared/med106/miniconda3/lib/python3.6:$PYTHONPATH

export PYTHONPATH=$PP:$PYTHONPATH

echo "STARTING PYTHON PBT: $PBT_PY"
echo "PYTHON: $( which python )"
echo "PYTHONPATH: $PYTHONPATH"

echo "Params file: $PARAMS_FILE"
echo "Exp dir: $EXP_DIR"
echo "Exp id: $EXP_ID"

# jsrun --nrs getenv(PROCS) --tasks_per_rs 1 --cpu_per_rs 1 --gpu_per_rs 1 --rs_per_host 6 --latency_priority cpu-cpu --launch_distribution cyclic --bind packed:1 python /gpfs/alpine/proj-shared/med107/gounley1/temp/test2.py

jsrun --nrs getenv(PROCS) --tasks_per_rs 1 --cpu_per_rs 1 --gpu_per_rs 1 --rs_per_host getenv(PPN) --latency_priority cpu-cpu --launch_distribution cyclic --bind packed:1 python $PBT_PY $PARAMS_FILE $EXP_DIR p3b4 $EXP_ID

