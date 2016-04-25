# fedora-wk
custom fedora workstation iso
```
cat > /usr/bin/i << EOF
#!/bin/bash
export ME=$(whoami)
sudo -H npm install -g ungit
sudo usermod -aG vboxusers $ME
sudo usermod -aG docker $ME
sudo systemctl enable docker
sudo systemctl start docker
sudo su - postgres -c "createuser --superuser $ME"
#reboot
EOF
```

todo: 1) give logged in user and phpmyadmin access to /var/www/