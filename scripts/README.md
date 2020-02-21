Install dependencies

```
pip3 install progressbar
pip3 install py-solc
pip3 install web3==v5.0.0-beta.2
pip3 install psrecord
```

## Use scripts

```
python3 [REPLAY_SCRIPT] [PATH_TO_FULLNODE]/jsonrpc.ipc [CONFIG] [CONTRACT_PATH] [ACCOUNTS] [--pow]
```

## Arguments

- REPLAY_SCRIPT - python script that generates transactions.
- PATH_TO_FULLNODE - the path of the fullnode base. 
- CONFIG - path to the real word transactions or configs python script.
- CONTRACT_PATH - path to smart contracts.
- ACCOUNTS - path to Ethereum account secrets.
- --pow - generate proof of work automatically.


## Examples

Replay ERC20 transactions for BEC Token.

```
python3 ./replay.py [PATH_TO_FULLNODE]/jsonrpc.ipc ./data/erc20.csv ../contracts/ERC20_BEC.sol ./keys/leo123leo987 ./keys/leo123leo456 --pow
```

Replay ERC721 transactions for DozerDoll Token.

```
python3 ./replay.py [PATH_TO_FULLNODE]/jsonrpc.ipc ./data/erc721.csv ../contracts/ERC721_DOZ.sol ./keys/leo123leo987 ./keys/leo123leo456 --pow
```

Generate transfer transactions for BEC Token.

```
python3 ./replay_bec.py [PATH_TO_FULLNODE]/jsonrpc.ipc transfer ../contracts/ERC20_BEC.sol ./keys/leo123leo987 ./keys/leo123leo456 --pow
```

Generate batch transfer transactions for BEC Token.

```
python3 ./replay_bec.py [PATH_TO_FULLNODE]/jsonrpc.ipc batchTransfer ../contracts/ERC20_BEC.sol ./keys/leo123leo987 ./keys/leo123leo456 --pow
```

Generate transfer transactions for DozerDoll Token.

```
python3 ./replay_dozerdoll.py [PATH_TO_FULLNODE]/jsonrpc.ipc transfer ../contracts/ERC721_DOZ.sol ./keys/leo123leo987 ./keys/leo123leo456 --pow
```

