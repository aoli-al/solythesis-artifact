#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import glob
import inquirer
import subprocess
import pandas as pd
import numpy as np

F_DIR = os.path.dirname(os.path.realpath(__file__))
CONTRACT_DIR = os.path.join(F_DIR, 'contracts') 
SCRIPT_DIR = os.path.join(F_DIR, 'scripts')

candidates = [x.split('.')[0].split('/')[-1] for x in filter(lambda x: x.count('_') == 1,  glob.glob(os.path.join(CONTRACT_DIR, '*.sol')))]


questions =  [
    inquirer.List('contract', 
                  message='Which contract to deploy?', 
                  choices=candidates
                  ),
    inquirer.List('type', 
                  message='Which type of Instrumentation?',
                  choices=['Origin', 'Solythesis', 'Baseline']
                  ),
    inquirer.List("exp", message='Which type of experiment to run?', 
                  choices=['CPU/Disk Usage (6.2)', 'Transaction Per Second (6.3)'],
                  ),
    inquirer.Text('blocks', 
                  message='How many blocks to generate? (Note that it may take excessive amount of time to generate large amount of blocks (>500).)',
                  validate=lambda _, x: x.strip().isnumeric()
                  )
]

configs = inquirer.prompt(questions)

suffix_mapping = {
    'Origin': "",
    "Solythesis": "_Solythesis",
    "Baseline": "_baseline"
}

contract_name = configs['contract'] + suffix_mapping[configs['type']] + ".sol"
contract = os.path.join(CONTRACT_DIR, contract_name)
script = os.path.join(SCRIPT_DIR, 'replay_' + configs['contract'].split("_")[-1].lower() + '.py')

if 'Transaction' in configs['exp']:
    shell = F_DIR + '/bash/run_tps_exp.sh'
else:
    shell = F_DIR + '/bash/run_cpu_exp.sh'

print(shell)


subprocess.call(['bash', shell, contract, script, configs['blocks']])


print("Done!")
print("Experiment: " + configs['exp'])
print("Contract: " + configs['contract'])
print("Instrumentation Type: " + configs['type'])

if 'Transaction' in configs['exp']:
    with open("/home/ubuntu/results/{}-{}.log".format(contract_name, configs['blocks'])) as f:
        for line in f:
            result = re.findall(r"Import completed in .+ (\d+) tx/s", line)
            if result:
                tps = result[0]
                break

    print("TPS: {} tx/s".format(tps))
else:
    with open("/home/ubuntu/results/{}-{}.db.txt".format(contract_name, configs['blocks'])) as f:
        for line in f:
            result = re.findall(r"rocksdb\.bytes\.written COUNT : (\d*)", line)
            if result:
                writes = int(result[0]) / 1024 / 1024 / int(configs['blocks']) / 10
                break
        print("DB Writes: {} MB/s".format(writes))

        res = pd.read_csv("/home/ubuntu/results/{}-{}.cpu.txt".format(contract_name, configs['blocks']), sep="\s+", header=None, dtype=np.float64, skiprows=1)
        res = res[[1]]
        mean = np.mean(res).values[0]
        print("Average CPU Usage: {}%".format(mean))



