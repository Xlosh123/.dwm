#!/bin/sh
mkdir -p ~/Pictures/screenshots/ && scrot ~/Pictures/screenshots/%m-%d-%Y-%H%M%S.png --select --line mode=edge
dunstify "Screenshot saved"
