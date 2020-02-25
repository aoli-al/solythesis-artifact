## Start

- To evaluate Solythesis, please download our pre-configured [VM image](./) and [VirtualBox](https://www.virtualbox.org/).

- Open VirtualBox, select File-Import Appliance, and import the VM image.

- Make sure you have 200 GB free disk space, setting your VM accordingly, and select import.

![](./imgs/appliance-settings.png)

- Start and login VM.
  - username: `ubuntu`
  - password: `ubuntu`

- Open terminal.

- `cd solythesis-artifact`


## Experiments

### Generate Instrumented Contracts

To generate instrumented contracts, you need to use Solythesis compiler.

```
cd solythesis
node lib/src/main.js PATH_TO_CONTRACT PATH_TO_CONSTRAINT
```

for example, to generate instrumented voting contract in
Figure 5.

```
node lib/src/main.js ./contracts/ERC1202_VOTE.sol ./contracts/ERC1202_VOTE_constraints.txt
```

Solythesis will generate two instrumented Vote contracts in `./contracts` folder:

- `ERC1202_VOTE_Solythesis_baseline.sol`: the secured smart contract using baseline instrumentation technique.
- `ERC1202_VOTE_Solythesis.sol`: the secured smart contract using delta update. Note the optimizations described in
Section 5 are also enabled.


- To reproduce our experiments run

- `python3 ./run.py` and follows the instructions:

  - Select the contract to deploy
  - Select the type of instrumentation.
  - Select which type of experiment to run.
  - Select the number of blocks to generate (Note large block number may require lots of time to process).

  - The statics will be shown after the script finishes.

  [![asciicast](https://asciinema.org/a/YlqfCidADXBNoV2T9ouUAcrgf.svg)](https://asciinema.org/a/YlqfCidADXBNoV2T9ouUAcrgf)



## Caveats

- The performance will be lower than the experiment results in paper since the experiments are performed in a virtual machine.

- If you cancel the experiments, make sure you kill all parity process before running other experiments.

- Don't run multiple experiments at the same time.
