## Build Dependencies

Parity Ethereum requires **latest stable Rust version** to build.

We recommend installing Rust through [rustup](https://www.rustup.rs/). If you don't already have `rustup`, you can install it like this:

- Linux:
  ```bash
  $ curl https://sh.rustup.rs -sSf | sh
  ```

  Parity Ethereum also requires `gcc`, `g++`, `pkg-config`, `file`, `make`, and `cmake` packages to be installed.

- OSX:
  ```bash
  $ curl https://sh.rustup.rs -sSf | sh
  ```

  `clang` is required. It comes with Xcode command line tools or can be installed with homebrew.

Once you have `rustup` installed, then you need to install:
* [Perl](https://www.perl.org)
* [Yasm](https://yasm.tortall.net)



Install rust 1.39.0

```bash
$ rustup install 1.39.0
$ rustup default 1.39.0
```

## Build from Source Code

```bash
$ cd parity-ethereum
$ cargo build --release --features final
```

This produces an executable in the `./target/release` subdirectory.

## Run Parity Client

Start client

```bash
./target/release/parity --accounts-refresh=0  --fast-unlock --no-warp \
   --no-consensus --config ./configs/config.dev-insecure.toml \
   --chain ./configs/foundation.json  \
   --base-path=PATH_TO_FULLNODE \
   --unsafe-expose --jsonrpc-cors=all --no-discovery  --cache-size 8096
```

Replace the variable `PATH_TO_FULLNODE` with the path of the fullnode base.
