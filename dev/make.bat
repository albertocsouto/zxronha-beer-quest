@echo off
rem Cambia "%1" por el nombre de tu güego.
echo ### COMPILANDO SCRIPT ###
cd ..\script
no olvides cambiar NPANT por el nº de pantallas
msc ronha.spt msc.h 16
copy *.h ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### REGENERANDO MAPA ###
cd ..\map
rem cambia ANCHO y ALTO por los valores de tu mapa:
..\utils\mapcnv mapa.map 4 4 15 10 99 packed
copy mapa.h ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### COMPILANDO GUEGO ###
zcc +zx -vn ronha.c -o ronha.bin -lndos -lsplib2 -zorg=24200
echo -------------------------------------------------------------------------------
echo ### CONSTRUYENDO CINTA ###
rem cambia LOADER por el nombre que quieres que salga en Program:
..\utils\bas2tap -a10 -sLOADER loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 24200 ronha.bin
copy /b loader.tap + screen.tap + main.tap ronha.tap
echo -------------------------------------------------------------------------------
echo ### LIMPIANDO ###
del loader.tap
del screen.tap
del main.tap
del ronha.bin
echo -------------------------------------------------------------------------------
echo ### DONE ###