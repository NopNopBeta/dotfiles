#!/bin/sh
# Reload Kitty colors
kill -SIGUSR1 $(pidof kitty) 2>/dev/null