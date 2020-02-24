#!/usr/bin/env bash

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
WORKSPACE="/home/ubuntu/results"


cd ~

echo "Create work space ~/results"

rm -rf $WORKSPACE
mkdir $WORKSPACE

echo "Copy fullnode folder... (this may take couple minutes)"

rsync -avh --info=progress2 ~/fullnode $WORKSPACE/fullnode
rsync -avh --info=progress2 ~/fullnode $WORKSPACE/import

$BASE/parity/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --no-consensus --config \
   $BASE/parity/configs/config.dev-insecure.toml \
   --chain $BASE/parity/configs/foundation.json  \
   --base-path=$WORKSPACE/fullnode --logging=error \
   --unsafe-expose --jsonrpc-cors=all --no-discovery  --cache-size 8096 &

sleep 30
python3 $2 $WORKSPACE/fullnode/jsonrpc.ipc $3 \
  $1 $BASE/scripts/keys/leo123leo987 $BASE/scripts/keys/leo123leo456 --pow
replay=$!

sleep 1

killall parity
sleep 5
#kill $miner
killall -9 parity

F_NAME = "$(basename -- $1)"

$BASE/parity/target/release/parity export blocks \
  --config $BASE/parity/configs/config.dev-insecure.toml  --chain $BASE/parity/configs/foundation.json \
 --base-path=$WORKSPACE/fullnode $WORKSPACE/$F_NAME-$3-mainchain.bin  --from 5052259

$BASE/parity/target/release/parity import $WORKSPACE/$F_NAME-$3-mainchain.bin\
  --config $BASE/parity/configs/config.dev-insecure.toml  --chain $BASE/parity/configs/foundation.json \
  --base-path=$WORKSPACE/import --log-file=$WORKSPACE/parity.log --logging=info
