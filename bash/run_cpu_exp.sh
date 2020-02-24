#!/usr/bin/env bash

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
WORKSPACE="/home/ubuntu/results"
F_NAME = "$(basename -- $1)"


cd ~

echo "Create work space ~/results"

rm -rf $WORKSPACE
mkdir $WORKSPACE

echo "Copy fullnode folder... (this may take couple minutes)"

cp -r ~/fullnode $WORKSPACE/fullnode
cp -r ~/fullnode $WORKSPACE/import

$BASE/parity/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --no-consensus --config \
   $BASE/parity/configs/config.dev-insecure.toml \
   --chain $BASE/parity/configs/foundation.json  \
   --base-path=$WORKSPACE/fullnode --logging=error \
   --unsafe-expose --jsonrpc-cors=all --no-discovery  --cache-size 8096 &

parity_pid=$!

sleep 30

~/.local/bin/psrecord $parity_pid --interval 0.1 --log $WORKSPACE/$F_NAME-$3.txt &
psrecord = $!


python3 $2 $WORKSPACE/fullnode/jsonrpc.ipc $3 \
  $1 $BASE/scripts/keys/leo123leo987 $BASE/scripts/keys/leo123leo456 &
replay=$!

sleep 1

python3 $BASE/scripts/miner.py $WORKSPACE/fullnode/jsonrpc.ipc &
miner=$!

wait $replay

killall psrecord
killall parity
sleep 5
kill $miner
killall -9 parity


$BASE/parity/target/release/parity export blocks \
  --config $BASE/parity/configs/config.dev-insecure.toml  --chain $BASE/parity/configs/foundation.json \
 --base-path=$WORKSPACE/fullnode $WORKSPACE/$F_NAME-$3-mainchain.bin  --from 5052259

$BASE/parity/target/release/parity import $WORKSPACE/$F_NAME-$3-mainchain.bin\
  --config $BASE/parity/configs/config.dev-insecure.toml  --chain $BASE/parity/configs/foundation.json \
  --base-path=$WORKSPACE/import --log-file=$WORKSPACE/parity.log --logging=info > $WORKSPACE/$F_NAME-$3.db.txt
