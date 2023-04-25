#!/bin/bash
echo "************************"
echo "**Atualizando Servidor**"
echo "************************"

	apt update -y
	apt upgrade -y

echo "************************"
echo "**Instalando o apache2**"
echo "************************"
	
	apt install apache2




echo "**********************"
echo "**Instalando o UNZIP**"
echo "**********************"

	apt install unzip


echo "**********************"
echo "**Download Aplicação**"
echo "**********************"
	
	cd /tmp
	wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
	
echo "*************************"
echo "**Descompactar Arquivos**"
echo "*************************"
	
	unzip main.zip

echo "********************************************"
echo "**Copiar Arquivos para diretorio do apache**"
echo "********************************************"

	cd linux-site-dio-main
	cp -R * /var/www/html/
