# PayD Docker Compose
This is an example of how you could run [PayD](https://github.com/electrumsv/electrumsv) and interact with it using the same json-rpc interface which is used in the BitcoinSV node software. The instructions below assume you have [docker compose](https://docs.docker.com/compose/install/) installed and the Docker daemon is running.

## Setup
```bash
git clone https://github.com/electrumsv/liteclient-docker.git
cd liteclient-docker
docker-compose up
```

## Usage

Unlock the wallet for json-rpc use, note the password used here is "pass" - you should replace this with whatever your chosen password was from the setup stage.

```bash
curl --request POST \
  --url http://127.0.0.1:8332/ \
  --header 'Content-Type: text/plain' \
  --data '{"method": "walletpassphrase","params":["pass", 10000],"id": "unlock"}'
```

### Receiving
Get a new address to send some BSV to

```bash
curl --request POST \
  --url http://127.0.0.1:8332/ \
  --header 'Content-Type: text/plain' \
  --data '{"method": "getnewaddress","params":[""],"id": "receive"}'
```
Send a few thousand sats to the response address using another wallet. [Handcash](https://handcash.io) for example.

You should see a txid appear in the logs as confirmation of receipt.

### Sending
Send to address. The data below will send 1000 sats to deggen, please update the address and value to send elsewhere.

```bash
curl --request POST \
  --url http://127.0.0.1:8332/ \
  --header 'Content-Type: text/plain' \
  --data '{"method": "sendtoaddress","params":["1GKt5APkUWLsSp1r1gNGQue52jomPuDqGi", 0.00001000],"id": "send"}'
```

Your wallet data will be persisted in the directory `/electrumsv_data` at the root of the project.

For full details of the JSON-rpc api please [read the docs](https://electrumsv.readthedocs.io/en/develop/building-on-electrumsv/node-wallet-api.html).
