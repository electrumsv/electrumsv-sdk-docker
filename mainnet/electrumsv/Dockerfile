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

RUN mkdir -p /electrumsv/data/wallets

EXPOSE 9999
CMD sleep infinity
