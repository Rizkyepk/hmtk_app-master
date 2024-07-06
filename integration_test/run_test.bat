@echo off

setlocal enabledelayedexpansion

for /l %%x in (0,1,14) do (
  set /a port=5000+%%x
  start flutter run .\integration_test\timeline_test.dart -d chrome --web-port=!port!
)

pause
