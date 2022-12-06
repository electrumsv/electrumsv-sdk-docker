# LiteClient Dockerfiles
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
The version of ElectrumSV that is intended to be run is currently on
the `develop` branch and is not yet ready for public consumption.

There is also work to be done regarding secure handling of credentials
when running electrumsv inside of Docker.

If you are helping us test this on mainnet, the instuctions for adding a wallet
and account via the commandline are at the bottom of this `README`.

### Disclaimer
I've not made any effort to slim down these docker images to the most lightweight
versions as there are more pressing priorities. I only care that it builds and works.
However, pull requests from docker wizards are most welcome.

## Regtest Instructions - Running the full stack

1. Make sure you have Docker installed: https://docs.docker.com/get-docker/

  If you're running Apple Silicon, make sure you have rosetta2 installed: (from terminal) 
  
  ```softwareupdate --install-rosetta```

2. clone or download the repo

  ```git clone https://github.com/electrumsv/liteclient-docker.git```

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


### Loaded RegTest Blockchains
We have prepared some regtest blockchains with hand-crafted transactions in them and
for known wallet seed phrases (xprv keys). See `regtest/node/blockchains/README.md`
for details.

There are two main test wallets. The miner's wallet with ample funds:

    entire coral usage young front fury okay fade hen process follow light

The other wallet that has a handful of test transactions with different types of output scripts.
(These transactions have also been targeted for reorging in the other test blockchains)

    neutral cash ozone buyer cook match exhaust usual purse transfer evil believe

The `node` container in the `docker-compose.regtest.yml` runs a python script on startup
which loads `blockchain_115_3677f4` (which takes the node to height 115). It then 
immediately mines 1 more "fresh" block with a current timestamp. It does this to get
the node out of "initial block download" mode (which is determined by the block timestamp
of the chain tip being within 24 hours of current time). 

If this is not done, services that communicate over the p2p network or rely on zmq PUB/SUB notifications will hear
radio silence.

#### Testing Reorg Handling
There is a script for submitting other test blockchains to the node in 
`regtest/node/blockchains/import_blocks.py`.

To trigger a reorg, we need to submit blocks that 1) orphan 1 or more blocks of the
current longest chain 2) extend the longest chain to a height higher than
the current height of 116.
    
    cd regtest/node/blockchains 
    python3 import_blocks.py blockchains/blockchain_118_0ebc17

Will trigger a reorg with a common parent at block height 110. 
This is done to verify that ElectrumSV and the supporting infrastructure is 
correctly handling these events.

## Mainnet Instructions For ElectrumSV

### Build the Docker Image

    docker-compose build --no-cache
    docker-compose up -d


### Adding a wallet & account
When running ElectrumSV without a GUI, wallets must be created via the commandline.

Enter the `electrumsv` docker container in an interactive bash terminal:

    docker exec -it electrumsv bash

Follow the instructions in found here: `https://electrumsv.readthedocs.io/en/develop/building-on-electrumsv/node-wallet-api.html#setup` 
in the terminal
