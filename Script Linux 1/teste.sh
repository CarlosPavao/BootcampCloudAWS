#!/bin/bash
#
#FUNÇÕES
#
#SOLICITAR OS DADOS DE ACESSO AO SERVIDOR
function serverAccess(){
    local HM FTP DOMINIO
    read -p 'INFORME A HM, EX. HM9890: ' HM
    echo
    read -p 'INFORME O FTP: ' FTP
    echo
    read -p 'DOMÍNIO QUE SERÁ INSTALADOS O CERTIFICADO SSL: ' DOMINIO
    echo

    echo "HM='$HM'; FTP='$FTP'; DOMINIO='$DOMINIO'"
}
#RECEBE O VALOR DA VARIÁVEL DOMÍNIO E CRIA OS ARQUIVOS DO SSL
function createFileSSL() {

        local DOMINIO="$1"
  # Solicita ao usuário que insira as informações para cada arquivo
        echo "Insira As Informações do arquivo CER/CRT, AO TERMINAR APERTAR CTRL-D:"
        certificado=$(cat)

        echo "Insira As Informações do arquivo KEY, AO TERMINAR APERTAR CTRL-D:"
        key=$(cat)

        echo "Insira As Informações do arquivo CA, AO TERMINAR APERTAR CTRL-D:"
        intermediario=$(cat)

        # Define o nome dos arquivos
        filename1="$DOMINIO.cer"
        filename2="$DOMINIO.key"
        filename3="$DOMINIO.ca"
        # Cria os arquivos e adiciona as informações
        echo "$certificado" > $filename1
        echo "$key" > $filename2
        echo "$intermediario" > $filename3

        # Confirmação de criação dos arquivos
        echo "Os arquivos $filename1 - $filename2 - $filename3 foram criados com sucesso."
}

#COPIAR OS ARQUIVOS PARA O SERVIDOR
function copyFileServer(){
        local FTP="$1"
        local PASTA="$2"
        local DOMINIO="$3"

        echo "sudo /sbin/locadmin/hospedagem/copiacertificado -l $FTP -f $PASTA/"$DOMINIO.ca""
                        sudo /sbin/locadmin/hospedagem/copiacertificado -l $FTP -f $PASTA/"$DOMINIO".ca
        echo "sudo /sbin/locadmin/hospedagem/copiacertificado -l $FTP -f $PASTA/"$DOMINIO.key""
                        sudo /sbin/locadmin/hospedagem/copiacertificado -l $FTP -f $PASTA/"$DOMINIO".key
        echo "sudo /sbin/locadmin/hospedagem/copiacertificado -l $FTP -f $PASTA/"$DOMINIO.cer""
                        sudo /sbin/locadmin/hospedagem/copiacertificado -l $FTP -f $PASTA/"$DOMINIO".cer
}
#CAMINHO DE PASTA DO CERTIFICADO PARA EDIÇÃO DO VHOST
function pathFile(){
        local FTP="$1"
        local DOMINIO="$2"
        local DATA="$3"
        
        echo "SSLEngine on"
        echo "SSLCertificateFile /etc/httpd/conf/$FTP/$DATA/"$DOMINIO".cer"
        echo "SSLCertificateKeyFile /etc/httpd/conf/$FTP/$DATA/"$DOMINIO".key"
        echo "SSLCACertificateFile /etc/httpd/conf/$FTP/$DATA/"$DOMINIO".ca"
        echo "SSLCACertificatePath /etc/httpd/conf/$FTP/$DATA"
}

#EDIÇÃO DO VHOST
function editVhost(){
        local FTP="$1"
        while true; do
                echo "sudo /sbin/locadmin/hospedagem/editar_vhost $FTP"
                editarVHOST = "sudo /sbin/locadmin/hospedagem/editar_vhost $FTP"
                # Executa o comando desejado e salva o resultado na variável
                resultado=$editarVHOST
                # Verifica se a informação desejada está presente no resultado
                if echo "$resultado" | grep -q "[  OK  ]"; then
                
                break
                fi

                echo "edição Incorreta verificar o VHOST"
                # Espera por alguns segundos antes de executar novamente
                sleep 5
        done
}
while :; do
        # autenticar no servidor
        auth-user

        echo 'O QUE DESEJA REALIZAR!!!!!!!'
        echo
        echo '1 - INSTALAR SSL/LETS ENCRYPTS'
        echo '2 - BUCAR LOGS'
        echo '3 - AUTENTICAR USUÁRIO'
        echo 'E - SAIR'
        read -p 'OPCAO: ' ETAPA

        echo '------------------------------------------------------------------'

        case $ETAPA in
                1)
                        echo 'O QUE DESEJA REALIZAR! DIGITE O NÚMERO QUE DESEJA'
                        echo
                        echo '1 - SSL'
                        echo '2 - LETS ENCRIPTS'
                        echo '3 - CORRIGIR CA'
                        echo '0 - SAIR'
                        read -p 'SERVIÇO: ' SERVICO

                        case $SERVICO in
                                1)
                                        while true; do
                                                eval "$(serverAccess)"
                                                echo '--------INFORMAÇÃO DE ACESSO AO SERVIDOR-------'
                                                echo "HM: $HM"
                                                echo "FTP: $FTP"
                                                echo "DOMINIO: $DOMINIO"
                                                echo '-----------------------------------------------'
                                                echo 'AS INFORMAÇÕES DE ACESSO AO SERVIDOR ESTÃO CORRETAS'
                                                echo
                                                echo '1 - SIM'
                                                echo '2 - NÃO'
                                                read -p 'OPÇÃO: ' CORRETA

                                                if [ "$CORRETA" = "1" ]; then
                                                        break
                                                fi
                                        done

                                        # FORMATAR A DATA PARA O PADRÃO DE INSTALAÇÃO DO CERTIFICADO
                                        dia=$(date +%d)
                                        mes=$(date +%m)
                                        ano=$(date +%Y)
                                        dataFinal="$ano"_"$mes"_"$dia"

                                        # ACESSANDO A HM
                                        echo "ssh -t -i ~/.ssh/vault -i ~/.ssh/vault-cert.pub $USER@$HM"
                                        ssh -i ~/.ssh/vault -i ~/.ssh/vault-cert.pub $USER@$HM < /dev/null
                                        echo

                                        # ACESSANDO O FTP
                                        echo 'Acessando o FTP ...'
                                        echo "sudo su $FTP -l -s /bin/bash"
                                        sudo su $FTP -l -s /bin/bash    
                                        echo

                                        # CRIAR A PASTA
                                        echo 'CRIANDO PASTA SSL'
                                        mkdir sl
                                        echo

                                        # ACESSAR A PASTA
                                        echo 'ACESSANDO PASTA SSL'
                                        cd sSl


                                        # CHAMANDO A FUNÇÃO PARA CRIAR OS ARQUIVOS DO SSL
                                        createFileSSL "$DOMINIO"

                                        # VOLTANDO PARA RAIZ
                                        cd

                                        # VOLTAR PARA HM
                                        exit

                                        # COPIAR ARQUIVOS PARA O SERVIDOR
                                        copyFileServer "$FTP" "sSl" "$DOMINIO"
                                        
                                        while true; do
                                                # Solicita o valor ao usuário
                                                echo 'DESEJA COPIAR O CAMINHO DE PASTA PARA EDIÇÃO DO VHOST'
                                                echo
                                                echo '1 - SIM'
                                                echo '2 - NÃO'
                                                read -p 'OPÇÃO: ' COPIAR

                                                valor_desejado="2"

                                                if [ "$COPIAR" = "$valor_desejado" ]; then
                                                        #Realinzando a edição do VHOST
                                                        editVhost "$FTP"

                                                        
                                                break
                                                else
                                                pathFile "$FTP" "$DOMINIO" "$dataFinal"
                                                fi

                                                echo 'Validado com sucesso somente seguir com a instalação'
                                        done
                                ;;

                                #INSTALAR LETS ENCRYPTS
                                2)
                                        echo 'O QUE DESEJA REALIZAR! DIGITE O NÚMERO QUE DESEJA'
                                        echo
                                        echo '1 - GERAR LETS E INSTALAR'
                                        echo '2 - INSTALAR COM CAMINHO DE PASTA'
                                        echo '3 - INSTALAR ECC'
                                        echo '0 - SAIR'
                                        read -p 'SERVIÇO: ' LESTSOPCAO

                                        case LESTSOPCAO in
                                                #GERANDO LETS E INSTALADO
                                                1)
                                                ;;
                                                #INSTALAR QUANDO JÁ TEM O CAMINHO DE PASTA
                                                2)
                                                ;;
                                                #INSTALAR ECC
                                                3)                                            
                                                ;;
                                                0)
                                                ;;
                                                *)
                                                ;;
                                        esac
                                        
                                ;;
                                #CORRIGINDO A CA
                                3)
                                        echo 'CORRIGINDO CA'
                                        
                                ;;

                                0)

                                        echo "Saindo..."

                                        exit 0
                                ;;

                                *)

                                        echo "opção invalida"
                                        break
                                ;;
                        esac
                        ;;
                #BUSCAR LOGS
                2)

                ;;
                #AUNTEITICA USUARIO
                3)        
                        auth-user
                
                ;;

                E)

                        echo "Saindo..."
                        exit 
                ;;

                *)

                        echo "opção invalida"
                        break
                ;;
       esac
done



