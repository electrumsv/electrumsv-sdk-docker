# ElectrumSV Dockerfiles
This repo aims to serve two purposes:
- A full set of regtest docker images that support the full functioning of the 
ElectrumSV wallet
- A source of template / example mainnet Dockerfiles for exchanges or other 
service providers to minimise sys admin overheads of adopting BitcoinSV.

At present we only include an ElectrumSV Dockerfile for mainnet because all other
services have dedicated publicly accessible service providers. If you want
to run one of these other services in the meantime, you can checkout the relevant
repository and follow the recommended instructions there.

## DO NOT USE ON MAINNET YET
The version of ElectrumSV that is indended to be run is currently on
the `develop` branch and is not yet ready for public consumption.

There is also work to be done regarding secure handling of credentials
when running electrumsv inside of Docker.

If you are helping us test this on mainnet, the instuctions for adding a wallet
and account via the commandline are at the bottom of this `README`.

### Disclaimer
I've not made any effort to slim down these docker images to the most lightweight
versions as there are more pressing priorities. I only care that it builds and works.
However, pull requests from docker wizards are most welcome.

## Installation Instructions

1. Make sure you have Docker installed: https://docs.docker.com/get-docker/

  If you're running Apple Silicon, make sure you have rosetta2 installed: (from terminal) 
  
  ```softwareupdate --install-rosetta```

2. clone or download the repo

  ```git clone https://github.com/electrumsv/electrumsv-sdk-docker.git```

3. cd into the repo directory

4. run docker-compose

  ```docker-compose -f docker-compose.regtest.yml up -d```


## Tear Down Instructions

    docker-compose -f docker-compose.regtest.yml down

## Build Instructions

To build all containers in the docker-compose.yml file:

    docker-compose -f docker-compose.regtest.yml build --parallel

To build only selected components:

    # The --no-cache flag is needed re-clone the repo and therefore include
    # the latest commits

    docker-compose -f docker-compose.regtest.yml build --no-cache electrumsv


The whatsonchain instance is accessible at ```localhost:55555```

Ports for `http://` services (on localhost):

    18332     # Node
    9999      # ElectrumSV REST API
    8332      # ElectrumSV RPC-API (Replaces a subset of the bitcoind RPC API)
    47124     # Reference Server (Includes a broad set of APIs for ElectrumSV)
    49241     # SimpleIndexer
    51001     # ElectrumX
    55555     # Whatsonchain
    5050      # MAPI
    8445      # DPP Proxy server
    33444     # HeaderSV

### Getinfo from the bitcoin node's commandline CLI interface
    
    docker-compose.exe exec node /bitcoin-cli.sh getinfo

### Mine 1 block

    docker-compose.exe exec node /bitcoin-cli.sh generate 1

## Mainnet Instructions For ElectrumSV

### Build the Docker Image

    docker-compose -f docker-compose.mainnet.yml build --no-cache electrumsv

OR

    docker-compose -f docker-compose.mainnet.yml build --no-cache
    

### Adding a wallet & account
When running ElectrumSV without a GUI, wallets must be created via the commandline.

Enter the `electrumsv` docker container in an interactive bash terminal:

    docker exec -it electrumsv bash

Create a wallet called `mywallet` with a password of `'test'`:

    python3 electrum-sv create_wallet --wallet /electrumsv/data/wallets/mywallet.sqlite --walletpassword 'test' --portable --no-password-check --dir /electrumsv/data

Create a standard account with a generated random wallet seed:

    python3 electrum-sv create_account --wallet /electrumsv/data/wallets/mywallet.sqlite --walletpassword 'test' --portable --no-password-check --dir /electrumsv/data

Load wallet via an http POST request to the REST API. For example:

    curl -X POST http://127.0.0.1:9999/v1/mainnet/wallet/load --header "Content-Type: application/json" --data '{"file_name": "mywallet.sqlite", "password": "test"}'

These instructions may be subject to change as more features on this front are fleshed out
