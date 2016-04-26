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
phpmyadmin
php-mysql
php-pgsql
pl
postgresql-contrib
postgresql-devel
postgresql-server
python-webpy
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
virt-manager
VirtualBox-5.0
wireshark-gnome
%end

%post
systemctl enable mariadb
#systemctl enable httpd
#systemctl enable nginx
#chrome policies
sudo mkdir -p /etc/opt/chrome/policies/{managed,recommended}
sudo cat > /etc/opt/chrome/policies/recommended/default.json << EOF
{
  "SpellCheckServiceEnabled": false,
  "BackgroundModeEnabled": false,
  "RestoreOnStartup": 1,
  "TranslateEnabled": false,
  "DnsPrefetchingEnabled": false,
  "SafeBrowsingEnabled": false
}
EOF
sudo cat > /etc/opt/chrome/policies/managed/force.json << EOF
{
  "DefaultBrowserSettingEnabled": true,
  "MetricsReportingEnabled": false
}
EOF

cat > /usr/bin/begin << "EOF"
#!/bin/bash
export ME=$(whoami)
sudo usermod -aG wireshark $ME
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
pushd .; cd /usr/local; curl https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | sudo tar xz; popd
mkdir -p ~/go/{bin,src}
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
exec su -l $ME #reload group membership without logging out
sudo updatedb
EOF
chmod a+x /usr/bin/begin

updatedb
%end
