%include /usr/share/spin-kickstarts/fedora-live-workstation.ks

repo --name=chrome --baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64/
repo --name=docker --baseurl=https://yum.dockerproject.org/repo/main/fedora/23/
repo --name=extra --baseurl=file:///var/rpm

%packages
ansible
code
createrepo
docker-engine
emacs
fossil-scm
google-chrome-stable
livecd-tools
mlocate
mock
npm
pgadmin3
postgresql-contrib
postgresql-devel
postgresql-server
ruby-devel
rubygem-pg
rubygem-rails
spin-kickstarts
sqlite-devel
terminator
tmux
valgrind
vagrant
%end

%post
su - postgres -c /usr/bin/initdb
systemctl enable postgresql
updatedb
#systemctl enable docker
#sudo su - postgres -c "createuser --superuser ab"
#sudo su - postgres -c "createuser --superuser liveuser"
%end
