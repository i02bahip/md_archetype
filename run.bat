@echo off
cls
set attr=main
if not "%1"=="" (
    set attr=%1
)
echo Running: %attr%.bin
c:\megadrive\emuladores\genskmod\gens.exe C:\projects\md\repos\ASM_Archetype\arch\out\%attr%.bin
cls