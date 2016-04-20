%include /usr/share/spin-kickstarts/fedora-live-workstation.ks
part / --size 8192
repo --name=chrome --baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64/
repo --name=docker --baseurl=https://yum.dockerproject.org/repo/main/fedora/23/
repo --name=extra --baseurl=file:///var/rpm

%packages
ansible
clojure
code
createrepo
docker-engine
erlang
fedora-packager
fossil-scm
gforth
google-chrome-stable
haproxy
haskell-platform
httpd
java-1.8.0-openjdk-devel
livecd-tools
lmdb-devel
mlocate
mysql
mysql-server
nginx
npm
perf
pgadmin3
php
php-mysql
php-pgsql
pl
postgresql-contrib
postgresql-devel
postgresql-server
redis
ruby-devel
rubygem-pg
rubygem-rails
sbcl
skype
spin-kickstarts
sqlite-devel
squeak-vm
tmux
vagrant
valgrind
%end

%post
su - postgres -c /usr/bin/initdb
systemctl enable postgresql
systemctl enable mysqld
updatedb
#systemctl enable docker
#sudo su - postgres -c "createuser --superuser ab"
%end
