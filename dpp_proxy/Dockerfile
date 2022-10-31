FROM golang:1.19

WORKDIR /opt

ENV BRANCH="features/update-for-tsc-spec-compliance"
RUN git clone -b ${BRANCH} --depth=1 https://github.com/bitcoin-sv/dpp-proxy.git /opt
RUN go build -o /opt/build/release/server -ldflags="-s -w" ./cmd/server
RUN chmod +x /opt/build/release/server

CMD sleep infinity
