FROM python:3.10

RUN git clone --branch master https://github.com/kyuupichan/electrumx /electrumx
WORKDIR /electrumx
RUN git checkout 1.20.1
RUN pip3 install -r requirements.txt

RUN mkdir -p /opt/data

EXPOSE 51001
CMD python3 electrumx_server
