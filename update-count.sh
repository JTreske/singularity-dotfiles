#!/usr/bin/env bash

if command -v "paru" >/dev/null; then
  paru -Quq 2>/dev/null | wc -l
elif command -v "yay" >/dev/null; then
  yay -Quq 2>/dev/null | wc -l
else
  echo 0
fi
