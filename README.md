# Instalar o Docker e Docker-Compose

Para utilizar o ambiente que foi projetado utilizando o docker, é necessário que tenha instalado em sua maquina 
o *docker* e *docker-compose*. Caso não tenha instalado em sua maquina, acesse os tutoriais para instalação dos mesmos.

- [Instalar Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
- [Instalar Docker-Compose](https://docs.docker.com/compose/install/#install-compose)

# Subindo os Containers

Após clonar o projeto, acesse a pasta *docker* e execute a sequência de comandos abaixo:

`` $ docker-compose up -d ``

*Esses comandos sobem os container do ambiente*

`` $ docker ps ``

Visualize se TODOS os containers estão na listagem, caso não estejam rode o comando para subi-los novamente.:

- **redis** - Container do redis
- **mysql** - Container do Mysql
- **phpadmin** - Container do PhpMyadmin
- **application_web** - Container principal (container da aplicação)

# Executando o projeto dentro do container

Para acessar o ambiente de desenvolvimento dentro do Container, execute o seguinte comando:

`` $ docker exec -it application_web bash ``

- Instale as dependências da aplicação: `` bundle install ``
- **Saia** do container: `` exit ``
- Aplique o *restart* no container: `` docker-compose restart ``
- Acesse o container da aplicação novamente: `` docker exec -it application_web bash ``
