%include /usr/share/spin-kickstarts/fedora-live-workstation.ks
part / --size 16384
repo --name=chrome --baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64/
repo --name=docker --baseurl=https://yum.dockerproject.org/repo/main/fedora/23/
repo --name=virtualbox --baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/22/x86_64/
repo --name=extra --baseurl=file:///var/rpm

%packages
ansible
atom
autoconf
automake
bison
clang
clojure
code
createrepo
dmd
docker-engine
erlang
fedora-packager
fossil-scm
geany
gforth
glibc-static
google-chrome-stable
haproxy
haskell-platform
htop
httpd
java-1.8.0-openjdk-devel
keepass
libtool
libyaml-devel
livecd-tools
lmdb-devel
masscan
mlocate
mariadb
mariadb-server
nginx
npm
ocaml
perf
pgadmin3
php
php-mysql
php-pgsql
pl
postgresql-contrib
postgresql-devel
postgresql-server
readline-devel
redis
ruby-devel
rubygem-pg
rubygem-rails
sbcl
scala
skype
spin-kickstarts
sqlite-devel
squeak-image
terminator
texlive
texlive-cweb-bin
texlive-web-bin
tmux
vagrant
valgrind
VirtualBox-5.0
wireshark-gnome
%end

%post
systemctl enable mariadb
#systemctl enable httpd
#systemctl enable nginx

cat > /usr/bin/begin << "EOF"
#!/bin/bash
export ME=$(whoami)
sudo usermod -aG vboxusers $ME
sudo usermod -aG docker $ME
sudo systemctl enable docker
sudo systemctl start docker
sudo su - postgres -c /usr/bin/initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo su - postgres -c "createuser --superuser $ME"
#ungit install hangs live media
if [ $ME != "liveuser" ]; then sudo -H npm install -g ungit; fi
exec su -l $ME #reload group membership without logging out
#reboot
EOF

chmod a+x /usr/bin/begin
updatedb
%end
