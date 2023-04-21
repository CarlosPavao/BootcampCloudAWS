#!/bin/bash
echo "*********************"
echo "CRIANDO DIRETÓRIOS"
echo "*********************"
		echo "DIRETÓRIO PUBLICO"
		mkdir /publico
	echo "----------------"
		echo "DIRETÓRIO ADM"
		mkdir /adm
	echo "----------------"
		echo "DIRETÓRIO VEN"
		mkdir /ven
	echo "----------------"
		echo "DIRETÓRIO SEC"
		mkdir /sec
	
echo "*********************"
echo "CRIANDO GRUPOS"
echo "*********************"
	echo "GRUPO GRP_ADM"
		groupadd GRP_ADM
	echo "----------------"
		echo "GRUPO GRP_VEN"
		groupadd GRP_VEN
	echo "----------------"
		echo "GRUPO GRP_SEC"
		groupadd GRP_SEC
	echo "----------------"
	
	
echo "*********************"
echo "DONO DO GRUPO"
echo "*********************"
	
	echo "DONO DO GRUPO GRP_ADM"
		chown root:GRP_ADM /adm
	echo "----------------"
		echo "DONO DO GRUPO GRP_VEN"
		chown root:GRP_VEN /ven
	echo "----------------"
		echo "DONO DO GRUPO GRP_VEN"
		chown root:GRP_SEC /sec

echo "*********************"
echo "INICIANDO CRIAÇÃO DE USUÁRIOS DO SISTEMA"
echo "*********************"

	echo "USUÁRIO CARLOS.SILVA"
		useradd carlos.silva -c "Carlos da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_ADM
		passwd carlos.silva -e
	echo "----------------"
		echo "USUÁRIO MARIA.SILVA"
		useradd maria.silva -c "Maria da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_ADM
		passwd maria.silva -e
	echo "----------------"
		echo "USUÁRIO JOÃO.SILVA"
		useradd joao.silva -c "João da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_ADM
		passwd joao.silva -e
	echo "----------------"
		echo "USUÁRIO DEBORA.SILVA"
		useradd debora.silva -c "Debora da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_VEN
		passwd debora.silva -e
	echo "----------------"
		echo "USUÁRIO SEBASTIANA.SILVA"
		useradd sebastiana.silva -c "Sebastiana da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_VEN
		passwd sebastiana.silva -e
	echo "----------------"
		echo "USUÁRIO ROBERTO.SILVA"
		useradd roberto.silva -c "Roberto da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_VEN
		passwd roberto.silva -e
	echo "----------------"
		echo "USUÁRIO JOSEFINA.SILVA"
		useradd josefina.silva -c "Josefina da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_SEC
		passwd josefina.silva -e
	echo "----------------"
		echo "USUÁRIO AMANDA.SILVA"
		useradd amanda.silva -c "Amanda da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_SEC
		passwd amanda.silva -e
	echo "----------------"
		echo "USUÁRIO ROGERIO.SILVA"
		useradd rogerio.silva -c "Rogerio da Silva" -s /bin/bash -m -p $(openssl passwd -6 Senha123) -G GRP_SEC
		passwd rogerio.silva -e

echo "*********************"
echo "PERMISSÕES DE DIRETÓRIO"
echo "*********************"

	echo "PERMISSÃO DO PUBLICO"
		cd /publico/
		chmod 777 /publico/
	echo "----------------"
		echo "PERMISSÃO DO ADM"
		cd /adm/
		chmod 770 /adm/
	echo "----------------"
		echo "PERMISSÃO DO VEN"
		cd /ven/
		chmod 770 /ven/
	echo "----------------"
		echo "PERMISSÃO DO SEC"
		cd /sec/
		chmod 770 /sec/
echo "*********************"
echo "SCRIPT FINALIZADO"
echo "*********************"