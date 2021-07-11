@echo off
cls
set attr=main
if not "%1"=="" (
    set attr=%1
)
echo Compiling: %attr%.asm
compiler\68k /o op+ /o os+ /o ow+ /o oz+ /o osq+ /o omq+ /o oaq+ /p /o ae- %attr%.asm, out/%attr%.bin>out/error-%attr%.log
type out\error-%attr%.log