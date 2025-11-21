#!/usr/bin/env bash

rm -rf ~/.config/nvim
ln -s $(pwd) ~/.config/nvim

# this script removes the ~/.config/nvim dir where nvim would normally look for configs and creates a sym link to wherever this dir is.
