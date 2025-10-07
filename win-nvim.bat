@echo off
REM %1 is the file to open

REM Using Windows Terminal to run nvim with the file
wt.exe -w 0 nt -p "fishy" -- nvim "%~1"