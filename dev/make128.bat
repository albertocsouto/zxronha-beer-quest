@echo off
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
..\utils\mapcnv mapa.map 4 4 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### GENERANDO BINARIOS ###
echo * Building reubica
..\utils\pasmo reubica.asm reubica.bin
echo * Building RAM3 AND RAM4 AND RAM6
cd ..\bin
librarian.exe
copy RAM3.bin ..\dev\ram3.bin
copy librarian.h ..\dev
echo -------------------------------------------------------------------------------
echo ### COMPILANDO WYZ PLAYER ###
cd ..\mus
..\utils\pasmo WYZproPlay47aZX.ASM ram1.bin
copy ram1.bin ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### COMPILANDO GUEGO ###
zcc +zx -vn ronha128.c -o ronha128.bin -lsplib2 -zorg=24200
echo -------------------------------------------------------------------------------
echo ### CONSTRUYENDO CINTA ###
..\utils\bas2tap -a10 -sLOADER loader128.bas loader.tap
..\utils\bin2tap -o reubica.tap -a 25000 reubica.bin
..\utils\bin2tap -o ram1.tap -a 32768 ram1.bin
..\utils\bin2tap -o ram3.tap -a 32768 ram3.bin
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 24200 ronha128.bin
copy /b loader.tap + screen.tap + reubica.tap + ram1.tap + ram3.tap + main.tap ronha128.tap
echo -------------------------------------------------------------------------------
echo ### LIMPIANDO ###
del loader.tap
del screen.tap
del main.tap
del reubica.tap
del ram1.bin
del ram3.bin
del ram1.tap
del ram3.tap
del ronha128.bin
del zcc_opt.def
echo -------------------------------------------------------------------------------
echo ### DONE ###