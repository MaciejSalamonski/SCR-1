#!/bin/bash

find $(pwd) -type f -name "$1.*" -mtime "$2" -exec tar -rvf "$3".tar -P {} \;
