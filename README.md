# Docker toolchains
This contains dockerfiles with prepared build toolchains for third party software.

Use them to build software from source without the hassle of installing dependencies, or as toolchain in CLion.

## Usage
Download the Dockerfile of the software you want to build, move or link it into the source folder of the software and run `docker build . -f tool.Dockerfile -t imagename`

This allows the docker build to access required files from the software source repository in the exact revision you want to build.