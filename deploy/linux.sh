#! /usr/bin/env bash
for folder in `ls` do
    stow $folder -t $HOME
done
