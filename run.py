#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import glob
import inquirer
import subprocess

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
                  message='Which type of contract to deploy?',
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

contract = os.path.join(CONTRACT_DIR, configs['contract'] + suffix_mapping[configs['type']] + ".sol")
script = os.path.join(SCRIPT_DIR, 'replay_' + configs['contract'].split("_")[-1].lower() + '.py')

if 'Transaction' in configs['exp']:
    shell = F_DIR + '/bash/run_tps_exp.sh'
else:
    shell = F_DIR + '/bash/run_cpu_exp.sh'

print(shell)


subprocess.call(['bash', shell, contract, script, configs['blocks']])


print("Done! Please check the raw output in ~/results folder.")



