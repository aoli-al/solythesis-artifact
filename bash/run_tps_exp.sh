#!/usr/bin/env bash

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
WORKSPACE="/home/ubuntu/results"
FNAME="$(basename -- $1)"

echo $FNAME


cd ~

echo "Copy fullnode folder... (this may take couple minutes)"

rsync -avh --delete --info=progress2 ~/fullnode_bak/ ~/fullnode
rsync -avh --delete --info=progress2 ~/fullnode_bak/ ~/import

$BASE/parity/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --no-consensus --config \
   $BASE/parity/configs/config.dev-insecure.toml \
   --chain $BASE/parity/configs/foundation.json  \
   --base-path=/home/ubuntu/fullnode --logging=error \
   --unsafe-expose --jsonrpc-cors=all --no-discovery  --cache-size 8096 &

sleep 1
python3 $2 /home/ubuntu/fullnode/jsonrpc.ipc $3 \
  $1 $BASE/scripts/keys/leo123leo987 $BASE/scripts/keys/leo123leo456 --pow
replay=$!

sleep 1

killall parity
sleep 5
#kill $miner
killall -9 parity


$BASE/parity/target/release/parity export blocks \
  --config $BASE/parity/configs/config.dev-insecure.toml  --chain $BASE/parity/configs/foundation.json \
 --base-path=/home/ubuntu/fullnode $WORKSPACE/$FNAME-$3-mainchain.bin  --from 5052259

$BASE/parity/target/release/parity import $WORKSPACE/$FNAME-$3-mainchain.bin\
  --config $BASE/parity/configs/config.dev-insecure.toml  --chain $BASE/parity/configs/foundation.json \
  --base-path=/home/ubuntu/import --log-file=$WORKSPACE/$FNAME-$3.log --logging=info
