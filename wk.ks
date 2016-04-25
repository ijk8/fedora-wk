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
mysql
mysql-server
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
su - postgres -c /usr/bin/initdb
systemctl enable postgresql
systemctl enable mysqld
updatedb
#systemctl enable docker
#systemctl enable httpd
#systemctl enable nginx
#sudo su - postgres -c "createuser --superuser ab"
%end
