
# MODEL RUNNER PY

# Currently only supports NT3_TC1

# tensoflow.__init__ calls _os.path.basename(_sys.argv[0])
# so we need to create a synthetic argv.
import sys
if not hasattr(sys, 'argv'):
    sys.argv  = ['nt3_tc1']

import json
import os
import numpy as np
import importlib
import runner_utils
import log_tools

logger = None

def import_pkg(framework, model_name):
    if framework == 'keras':
        module_name = "{}_baseline_keras2".format(model_name)
        pkg = importlib.import_module(module_name)
    # elif framework is 'mxnet':
    #     import nt3_baseline_mxnet
    #     pkg = nt3_baseline_keras_baseline_mxnet
    # elif framework is 'neon':
    #     import nt3_baseline_neon
    #     pkg = nt3_baseline_neon
    else:
        raise ValueError("Invalid framework: {}".format(framework))
    return pkg

def run(hyper_parameter_map):

    global logger
    logger = log_tools.get_logger(logger, __name__)

    framework = hyper_parameter_map['framework']
    model_name = hyper_parameter_map['model_name']
    pkg = import_pkg(framework, model_name)

    runner_utils.format_params(hyper_parameter_map)

    # params is python dictionary
    params = pkg.initialize_parameters()
    for k,v in hyper_parameter_map.items():
        #if not k in params:
        #    raise Exception("Parameter '{}' not found in set of valid arguments".format(k))
        params[k] = v

    runner_utils.write_params(params, hyper_parameter_map)
    history = pkg.run(params)

    runner_utils.keras_clear_session(framework)

    # use the last validation_loss as the value to minimize
    val_loss = history.history['val_loss']
    result = val_loss[-1]
    print("result: ", result)
    return result

if __name__ == '__main__':
    logger = log_tools.get_logger(logger, __name__)
    logger.debug("RUN START")

    ( param_string,
      instance_directory,
      framework,
      runid,
      benchmark_timeout ) = sys.argv

    hyper_parameter_map = runner_utils.init(param_string,
                                            instance_directory,
                                            framework, 'save')
    hyper_parameter_map['model_name']    = os.getenv("MODEL_NAME")
    hyper_parameter_map['experiment_id'] = os.getenv("EXPID")
    hyper_parameter_map['run_id'] = run_id
    hyper_parameter_map['timeout'] = benchmark_timeout
    # clear sys.argv so that argparse doesn't object
    sys.argv = ['nt3_tc1_runner']
    result = run(hyper_parameter_map)
    runner_utils.write_output(result, instance_directory)
    logger.debug("RUN STOP")