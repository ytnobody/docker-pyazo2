#!/bin/sh
start_server --port=5000 -- plackup -Ilib -s Starlet script/pyazo2-server -E production
