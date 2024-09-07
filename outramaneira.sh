#!/bin/sh
xbps-install -y rsync

rsync -avHP --delete --exclude 'debug' --exclude 'multilib' --exclude 'musl' \ 
                 --exclude 'nonfree' --exclude 'aarch64' --exclude '*.armv7l.xbps*' \
                 --exclude '*armv6l.xbps*' --exclude '*.i686.xbps*' \
 rsync://alpha.de.repo.voidlinux.org/voidmirror/current/ /mnt/sda1/VOID-REPO/current/

# Observe que nonfree é uma subpasta abaixo de 'current'. Eu a excluo porque não preciso dela, 
# para outros (nvidia etc.) você pode querer incluí-la 
# Para obter um log menos detalhado, deixe de fora as opções v e P para rsync.

# Depois que você tiver uma versão estática do repositório, ela pode ser usada como um argumento para 
# a opção --repository. 
# xbps-install --repository=/mnt/sda1/VOID-REPO/current geany 
# ou ser definido/declarado em /etc/xbps.d/. 
# os arquivos nessa pasta mascaram/substituem os arquivos padrão de mesmo nome em /usr/share/xbps.d 
# ou seja, copie esses arquivos para /etc/xbps.d/ e edite-os para apontar para a pasta do repositório local 
# Uma URL completa ou caminho completo pode ser inserido para o local do repositório

# O repositório local precisa ser indexado antes de poder ser usado 
cd /mnt/sda1/VOID-REPO/current
xbps-rindex -a /mnt/sda1/VOID-REPO/current/*.xbps
