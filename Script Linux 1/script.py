#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pexpect

def informacoes_servidor():
    HM = input('INFORME A HM, EX. HM9890: ')
    FTP = input('INFORME O FTP: ')
    DOMINIO = input('DOMÍNIO QUE SERÁ INSTALADO O CERTIFICADO SSL: ')

    return HM, FTP, DOMINIO

def expect_ssh(HM, USER):
    ssh_command = "ssh -i ~/.ssh/vault -i ~/.ssh/vault-cert.pub " + USER + "@" + HM
    child = pexpect.spawn(ssh_command)

    try:
        index = child.expect(["Are you sure you want to continue connecting", "password:"])

        if index == 0:
            child.sendline("yes")
            child.expect("password:")

        child.sendline("")  # Insira a senha do usuário, se necessário

        # Realize as operações dentro do servidor SSH aqui
        # Por exemplo, você pode enviar comandos para o servidor usando child.sendline()
        # E pode esperar por determinados padrões de saída usando child.expect()
        # Você pode executar múltiplos comandos e interagir com o servidor SSH conforme necessário

        # Exemplo: Executando o comando "ls" no servidor SSH
        child.sendline("ls")
        child.expect(pexpect.EOF)  # Aguarda o final da saída

        # Exemplo: Executando o comando "pwd" no servidor SSH
        child.sendline("pwd")
        child.expect(pexpect.EOF)  # Aguarda o final da saída

        # Adicione mais comandos conforme necessário

    except pexpect.exceptions.EOF:
        print("Falha na conexão SSH")
        
def createFileSSL(DOMINIO):
    # Solicita ao usuário que insira as informações para cada arquivo
    print("Insira as informações do arquivo CER/CRT para {}, ao terminar, pressione 'Ctrl + D' (ou 'Ctrl + Z' no Windows):".format(DOMINIO))
    certificado = ""
    try:
        while True:
            linha = input()
            certificado += linha + "\n"
    except EOFError:
        pass
    
    print("Insira as informações do arquivo KEY para {}, ao terminar, pressione 'Ctrl + D' (ou 'Ctrl + Z' no Windows):".format(DOMINIO))
    key = ""
    try:
        while True:
            linha = input()
            key += linha + "\n"
    except EOFError:
        pass
    
    print("Insira as informações do arquivo CA para {}, ao terminar, pressione 'Ctrl + D' (ou 'Ctrl + Z' no Windows):".format(DOMINIO))
    intermediario = ""
    try:
        while True:
            linha = input()
            intermediario += linha + "\n"
    except EOFError:
        pass
    
    # Define o nome dos arquivos
    filename1 = "{}.cer".format(DOMINIO)
    filename2 = "{}.key".format(DOMINIO)
    filename3 = "{}.ca".format(DOMINIO)
    
    # Cria os arquivos e adiciona as informações
    with open(filename1, 'w') as file1:
        file1.write(certificado)
    
    with open(filename2, 'w') as file2:
        file2.write(key)
    
    with open(filename3, 'w') as file3:
        file3.write(intermediario)
    
    # Confirmação de criação dos arquivos
    print("Os arquivos {} - {} - {} foram criados com sucesso.".format(filename1, filename2, filename3))
    
    return filename1

def main():
    HM = None
    FTP = None
    DOMINIO = None

    while True:
        print("===== MENU PRINCIPAL =====")
        print("1 - INSTALAR SSL/LETS ENCRYPTS")
        print("2 - BUSCAR LOGS")
        print("3 - AUTENTICAR USUÁRIO")
        print("E - SAIR")
        escolha = input("Digite o número da opção desejada: ")

        if escolha == "1":
            while True:
                print("===== O QUE DESEJA FAZER? =====")
                print("1 - SSL")
                print("2 - LETS ENCRYPTS")
                print("3 - CORRIGIR CA")
                print("0 - VOLTAR AO MENU PRINCIPAL")

                escolha_ssl = input("Digite o número da opção desejada: ")

                if escolha_ssl == "0":
                    break
                elif escolha_ssl == "1":
                    HM, FTP, DOMINIO = informacoes_servidor()
                    print("-------- INFORMAÇÕES DE ACESSO AO SERVIDOR -------")
                    print("HM: {}".format(HM))
                    print("FTP: {}".format(FTP))
                    print("DOMINIO: {}".format(DOMINIO))
                    print("------------------------------------------------")
                    print("AS INFORMAÇÕES DE ACESSO AO SERVIDOR ESTÃO CORRETAS")
                    print()
                    CORRETA = input("1 - SIM\n2 - NÃO\nOPÇÃO: ")

                    if CORRETA == "1":
                        expect_ssh(HM, FTP)
                        createFileSSL(DOMINIO)
                        break
                    elif CORRETA == "2":
                        continue  # Volta ao início do loop interno
                    else:
                        print("Opção inválida. Por favor, escolha 1, 2 ou 3.")
                elif escolha_ssl == "2":
                    print("A HM:", HM)
                elif escolha_ssl == "3":
                    print("A HM:", HM)

                try:
                    expect_ssh(HM, FTP)
                except pexpect.exceptions.EOF:
                    print("Falha na conexão SSH")

        elif escolha == "2":
            # Implemente a lógica para buscar logs
            print("Buscar logs")
        elif escolha == "3":
            # Implemente a lógica para autenticar usuário
            print("Autenticar usuário")
        elif escolha == "E":
            # Implemente a lógica para sair do programa
            print("Saindo...")
            break
        else:
            print("Opção inválida. Por favor, escolha uma opção válida.")

if __name__ == "__main__":
    main()

    
