#!/bin/bash
source /home/zimlewis/.bashrc

exec tomato ss & disown
exec qs & disown
