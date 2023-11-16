#!/bin/bash
#
# This script downloads protoc from github and installs in .local
# sauce: https://grpc.io/docs/protoc-installation/
#
# todo: set this up to download specific versions passed via arguments
#
# azoth zephyr <azoth@zephyr.sx>
#

PB_REL="https://github.com/protocolbuffers/protobuf/releases"
curl -LO $PB_REL/download/v3.15.8/protoc-3.15.8-linux-x86_64.zip

unzip protoc-3.15.8-linux-x86_64.zip -d $HOME/.local
