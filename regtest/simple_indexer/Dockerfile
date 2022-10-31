FROM python:3.10

RUN apt-get update
RUN apt-get -y install libusb-1.0-0-dev libudev-dev
RUN apt-get -y install zbar-tools
RUN python3 -m pip install -U pysqlite3-binary

RUN git clone --depth=1 https://github.com/electrumsv/simple-indexer.git /simple_indexer
WORKDIR /simple_indexer
RUN git checkout master
RUN pip3 install -r requirements.txt

CMD sleep infinity


