@echo off

for %%I in (%*) do start "ping %%I -t" cmd.exe /c ping %%I -t