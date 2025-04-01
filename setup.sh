#!/bin/bash

if command -v apt-get &> /dev/null; then
    apt-get install stow
else
    echo "APT is not available on $(uname -s). Please install dependencies manually."

stow .

