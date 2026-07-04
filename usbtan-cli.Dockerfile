# Ubuntu based usbtan-cli

FROM ubuntu:latest

WORKDIR /work

RUN apt update && apt install -y build-essential

RUN apt install -y libgwenhywfar-core-dev libchipcard-dev libglib2.0-dev

ADD . /work/usbtan

WORKDIR /work/usbtan

ENTRYPOINT ["/bin/bash"]
