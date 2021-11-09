##DESAFIO DE GERENCIAMENTO DE CONFIGURAÇÃO##

##PROVISIONANDO O SERVIDOR

arquivo Main.tf = provisiona o servidor (Linux / Docker) na Azure
arquivo Variables.tf = variáveis que serão utilizadas para provisionamento do servidor pelo arquivo Main.tf

Passo 01: Baixe o arquivo em uma pasta em seu computador
Passo 02: Com o terrafor instalado e provisionado em sua conta Azure, abra a pasta no VSCODE e execute os comandos "terraform" para subir o ambiente

##ACESSANDO O SERVIDOR
Passo 03: Com o servidor criado e em execução, acesse o mesmo pelo terminal do VSCODE (ssh user@hostname)

##CRIANDO A IMAGEM DOCKER
Passo 04: Baixe os arquivos main.go e Dockerfile em um diretório no seu servidor (Os arquivos precisam estar no mesmo diretório, iremos criar a imagem Docker para que seja executada em container)
Passo 05: Execute os comandos "docker" para criação da imagem

##INICIANDO A APLICAÇÃO EM CONTAINER
Passo 06: Execute os comandos "docker" para iniciar o container e mante-lo em exxecução

##ACESSANDO A APLICAÇÃO
Passo 07: Acesse a aplicação pelo seu navegador (http://IPPUBLICO:8080)
