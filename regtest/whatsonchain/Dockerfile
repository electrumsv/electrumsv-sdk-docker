FROM node:12-alpine

RUN apk add bash
RUN apk add git

RUN git clone --depth=1 https://github.com/AustEcon/woc-explorer.git

RUN apk add python3 py3-pip
RUN apk add make
RUN cd woc-explorer && \
  npm i && \
  npm run build

EXPOSE 3002

WORKDIR /woc-explorer
CMD npm run start
