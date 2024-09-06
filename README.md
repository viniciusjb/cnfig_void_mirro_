# Configurando espelho local "mirror void linux"
Configuração mirror local void 

## Configuração do ambiente

Para a configuração do mirror ou espelho local no Void Linux em um servidor,
utilize os seguintes comandos:

Atualize a lista de pacotes do void primeiramente

```
$ sudo xbps-install -Su
```

Instale o nano

```
$ sudo xbps-install -S nano
```

Instale o rsync

```
$ sudo xbps-install -S rsync
```

## Configurando rsync
Este script utiliza o rsync para sincronizar dados do espelho (mirror) do Void Linux a partir de um servidor remoto para um diretório local especificado. 
Ele inclui várias opções para garantir que a sincronização seja feita de forma eficiente e controlada, excluindo certos tipos de arquivos e diretórios que não são necessários.
script: https://github.com/viniciusjb/cnfig_void_mirro_/blob/main/sync.sh

Fonte: rsync://mirrors.servercentral.com/voidlinux – URL do espelho remoto do Void Linux.

Destino: $STORAGE_PATH – Diretório local definido anteriormente onde os dados serão armazenados.




```
#!/usr/bin/env bash

STORAGE_PATH="/home/bruto/mirror/void"

rsync \
  --recursive \
  --links \
  --perms \
  --times \
  --compress \
  --progress \
  --delete \
  --exclude='debug' \
  --exclude='aarch64' \
  --exclude='*.armv7l.xbps' \
  --exclude='armv6l.xbps' \
  --exclude='*.i686.xbps' \
  --exclude='*.armv?l.convolution' \
  --exclude='musl' \
  rsync://mirrors.servercentral.com/voidlinux \
  $STORAGE_PATH


```

Opções do rsync:

```
--recursive: Sincroniza diretórios de forma recursiva.
--links: Preserva links simbólicos.
--perms: Preserva permissões dos arquivos.
--times: Preserva as marcas de tempo dos arquivos.
--compress: Comprime os dados durante a transferência para economizar largura de banda.
--progress: Mostra o progresso da transferência.
--delete: Remove arquivos no destino que não existem mais na origem.
Opções de Exclusão (--exclude):
```

Estas opções instruem o rsync a ignorar certos arquivos ou diretórios durante a sincronização:

```
'debug': Exclui qualquer diretório ou arquivo chamado "debug".
'aarch64': Exclui diretórios ou arquivos relacionados à arquitetura aarch64.
'*.armv7l.xbps': Exclui arquivos com a extensão .armv7l.xbps.
'armv6l.xbps': Exclui arquivos específicos da arquitetura armv6l.
'*.i686.xbps': Exclui arquivos com a extensão .i686.xbps.
'*.armv?l.(convolution)': Exclui arquivos que correspondem ao padrão especificado (possivelmente uma tipografia incorreta; verifique se o padrão está correto).
'musl': Exclui diretórios ou arquivos relacionados a musl.

```
## Resumo
Este script configura uma sincronização eficiente entre um servidor espelho remoto do Void Linux e um diretório local, garantindo que apenas os arquivos e diretórios necessários sejam copiados. As exclusões específicas ajudam a evitar a transferência de arquivos que não são necessários para o seu uso, economizando espaço de armazenamento e largura de banda.

## Considerações Adicionais
Agendamento: Para manter o espelho atualizado regularmente, você pode agendar a execução deste script usando o cron. Por exemplo, para executar diariamente às 2h da manhã, adicione uma entrada no crontab:

```
0 2 * * * /caminho/para/seu/script.sh
```

Permissões: Certifique-se de que o script tenha permissões de execução:

```
chmod +x /caminho/para/seu/script.sh
```


# Disponibilizar o servidor com Apache

Instalar Apache

No Void Linux, configurar o Apache (também conhecido como httpd no Void) é um processo similar ao 
de outras distribuições, mas com algumas particularidades devido à forma como o Void gerencia pacotes e serviços.

```
# xbps-install -S apache
```

Iniciar e Habilitar o Serviço:

Para habilitar o Apache no boot:

```
$ ln -s /etc/sv/apache /var/service/
```
Para iniciar o Apache imediatamente:

```
$ sv start apache
```
Para verificar o status:

```
$ sv status apache
```

## Configurar Apache

A configuração principal do Apache está no arquivo /etc/apache/httpd.conf. Para editar este arquivo:
https://github.com/viniciusjb/cnfig_void_mirro_/blob/main/httpd.conf

```
nano /etc/apache/httpd.conf
```
Por exemplo, para permitir a listagem de diretórios em uma pasta específica, como /home/user/public_html, adicione ou edite a seguinte seção no httpd.conf:

```
<Directory /home/bruto/mirror/void>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>

```

Para alterar o diretório padrão do Apache no Void Linux (ou qualquer outra distribuição Linux), siga os seguintes passos. 
Neste exemplo, vamos alterar o caminho padrão de /var/www/htdocs para outro diretório, como /home/user/public_html

Abra o arquivo de configuração principal do Apache, que está localizado em /etc/apache/httpd.conf:

Encontre a linha onde o DocumentRoot está definido (geralmente perto do início do arquivo) e altere o caminho para o novo diretório desejado. 
Por exemplo:

```
#
# DocumentRoot: The directory out of which you will serve your
# documents. By default, all requests are taken from this directory, but
# symbolic links and aliases may be used to point to other locations.
#
DocumentRoot "/home/bruto/mirror/void"

```

Se você configurou um diretório específico, como /home/user/public_html, certifique-se 
de que as permissões estejam corretas para que o Apache possa acessar este diretório:

```
$ chmod o+x /home/user
$ chmod -R o+rx /home/user/public_html
```

Após editar as configurações, reinicie o Apache para aplicar as mudanças:

```
$ sv restart apache
```




