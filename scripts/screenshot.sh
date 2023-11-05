#!/bin/sh
mkdir -p ~/Pictures/screenshots/ && scrot ~/Pictures/screenshots//%m-%d-%Y-%H%M%S.png
dunstify "Screenshot saved"
