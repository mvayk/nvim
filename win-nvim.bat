@echo off
REM %1 is the file to open

REM
wt.exe -w 0 nt -p "fishy" -- nvim "%~1"
