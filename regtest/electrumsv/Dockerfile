FROM python:3.10

RUN apt-get update
RUN apt-get -y install libusb-1.0.0-dev libudev-dev
RUN apt-get -y install zbar-tools

RUN git clone --branch develop --depth=1 https://github.com/electrumsv/electrumsv /electrumsv
WORKDIR /electrumsv
RUN git checkout develop

RUN python3 -m pip install pip==22.2.2 --disable-pip-version-check
RUN python3 -m pip install -r contrib/deterministic-build/linux-py3.10-requirements.txt --disable-pip-version-check
RUN python3 -m pip install -r contrib/deterministic-build/linux-py3.10-requirements-hw.txt --disable-pip-version-check
RUN python3 -m pip uninstall bitcoinx -y
RUN python3 -m pip install git+https://github.com/kyuupichan/bitcoinX.git@61634bebe4d877111c1be8c583ec28d00845ba75

RUN mkdir -p /electrumsv/data/regtest/wallets

COPY ./electrumsv/api_servers_regtest.json /electrumsv/electrumsv/data/

RUN python3 electrum-sv create_wallet --wallet /electrumsv/data/regtest/wallets/worker1.sqlite \
--walletpassword 'test' --portable --no-password-check --regtest --dir /electrumsv/data
RUN python3 electrum-sv create_account --wallet /electrumsv/data/regtest/wallets/worker1.sqlite \
--walletpassword 'test' --portable --no-password-check --regtest --dir /electrumsv/data

EXPOSE 9999
CMD python3 electrum-sv --portable --dir /electrumsv/data --regtest daemon --v=debug \
--file-logging --restapi --restapi-port=9999 --restapi-user rpcuser --restapi-password=

