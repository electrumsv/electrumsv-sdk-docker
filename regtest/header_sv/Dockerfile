FROM openjdk:11

ENV BRANCH="features/update-for-tsc-spec-compliance"
RUN git clone --branch v2.0.2 --depth=1 https://github.com/bitcoin-sv/block-headers-client.git /opt

WORKDIR /opt
RUN ./gradlew assemble

RUN apt-get update
RUN apt-get install unzip
RUN unzip app/build/distributions/app-boot-2.0.2.zip -d /app

CMD sleep infinity
