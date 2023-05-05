#!/bin/env fish

polybar-msg cmd quit

polybar example >/dev/null 2>&1 & 
echo "Bars launched..."
