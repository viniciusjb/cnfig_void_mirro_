# cnfig_void_mirro_
Configuração mirror local void 

## Configuração do ambiente

Para configuração do void mirror ou espelho local em um servidor void 
utilizer os seguintes comandos:

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
