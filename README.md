# electrumsv-sdk
BitcoinSV development environment using the Electrumsv-sdk and Docker

## Installation Instructions

1. Make sure you have Docker installed: https://docs.docker.com/get-docker/

  If you're running Apple Silicon, make sure you have rosetta2 installed: (from terminal) 
  
  ```softwareupdate --install-rosetta```

2. clone or download the repo

  ```git clone https://github.com/electrumsv/electrumsv-sdk-docker.git```

3. cd into the repo directory

4. run docker-compose

  ```docker-compose up -d```


## Tear Down Instructions

    docker-compose down

## Build Instructions

To build all containers in the docker-compose.yml file:

    docker-compose build --parallel

To build only selected components:

    # The --no-cache flag is needed re-clone the repo and therefore include
    # the latest commits

    docker-compose build --no-cache electrumsv


The whatsonchain instance is accessible at ```localhost:55555```

Ports for `http://` services (on localhost):

    18332     # Node
    9999      # ElectrumSV REST API
    8332      # ElectrumSV RPC-API (Replaces a subset of the bitcoind RPC API)
    47124     # Reference Server (Includes a broad set of APIs for ElectrumSV)
    49241     # SimpleIndexer
    51001     # ElectrumX
    55555     # Whatsonchain
    
    (Not added yet but will be soon)
    5050      # MAPI
    8445      # DPP Proxy server
    33444     # HeaderSV

### Getinfo from the bitcoin node's commandline CLI interface
    
    docker-compose.exe exec node /bitcoin-cli.sh getinfo

### Mine 1 block

    docker-compose.exe exec node /bitcoin-cli.sh generate 1

