default:
	@echo no
bootstrap: .force
	@dnf install -y livecd-tools spin-kickstarts createrepo
	@mkdir /var/rpm
	@curl https://az764295.vo.msecnd.net/stable/fa6d0f03813dfb9df4589c30121e9fcffa8a8ec8/vscode-x86_64.rpm > /var/rpm/code.rpm
	@createrepo /var/rpm
wk: .force
	@setenforce 0
	@livecd-creator --verbose --config=wk.ks --fslabel=fedora
.force:
