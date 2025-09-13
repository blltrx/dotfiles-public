#!/usr/bin/env bash

STATE=$(powerprofilesctl get)
echo $STATE

if [ $STATE = 'power-saver' ]; then
  powerprofilesctl set balanced
fi
if [ $STATE = 'balanced' ]; then
  powerprofilesctl set performance
fi
if [ $STATE = 'performance' ]; then
  powerprofilesctl set power-saver
fi
