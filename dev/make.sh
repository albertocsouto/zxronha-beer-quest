#!/bin/bash
NAME=ronha
echo -e "\e[32mCompilando $NAME"
echo -e "Compilando script\e[0m"
cd ../script
wine msc $NAME.spt msc.h 24
cp *.h ../dev
echo -e "\e[32mRegenerando mapa\e[0m"
cd ../map
mapcnv mapa.map 8 3 15 10 15 packed
cp -f mapa.h ../dev
echo -e "\e[32mCompilando juego\e[0m"
cd ../dev
zcc +zx -vn $NAME.c -o $NAME.bin -lndos -lsplib2 -zorg=24200
echo -e "\e[32mCreando la cinta\e[0m"
MAYUS=echo $NAME | tr '[:lower:]' '[:upper:]'
bas2tap -a10 -s${MAYUS} loader.bas loader.tap
bin2tap -o screen.tap -a 16384 loading.bin
bin2tap -o main.tap -a 24200 $NAME.bin
cat loader.tap screen.tap main.tap > $NAME.tap

echo -e "\e[32mCompilación terminada.\e[0m"

# Si tienes instalado las herramientas del emulador fuse, descomenta las siguientes lineas para
# saber de cuanto espacio libre dispones.
#echo -e "\e[32mCalculando espacio disponible\e[0m"
#TAMANO=`tzxlist main.tap | grep "Data length" | tail -1 | grep -o '[0-9]*'`
#TOTAL=`expr $TAMANO + 24200`
#ZXWEIGHT=`expr 60654 - $TOTAL`
#echo "$TAMANO + 24200 = $TOTAL ( $ZXWEIGHT )"

echo "\e[32mLimpiando\e[0m"
rm loader.tap
rm screen.tap
rm main.tap
rm $NAME.bin
