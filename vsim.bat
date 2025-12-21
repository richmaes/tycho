@echo off
if "%1" == "-version" (
    echo Questa Sim-64 vsim 2022.3_1 Simulator 2022.08 Aug 12 2022
) else (
    "C:\altera_pro\25.3\questa_fse\win64\vsim2.exe" %*
)