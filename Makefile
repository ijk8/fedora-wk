default:
	@echo no
bootstrap:
	@dnf install -y livecd-tools spin-kickstarts createrepo fedora-packager
download:
	@mkdir -p rpmbuild/SOURCES
	@curl https://www.fossil-scm.org/index.html/tarball/fossil-src.tar.gz > rpmbuild/SOURCES/fossil-src.tar.gz
rpm: .force
	@rpmbuild --define "_topdir $(shell pwd)/rpmbuild" -bb rpmbuild/SPECS/fossil-scm.spec
install: .force
	@rm -rf /var/rpm
	@mkdir /var/rpm
	@curl https://az764295.vo.msecnd.net/stable/fa6d0f03813dfb9df4589c30121e9fcffa8a8ec8/vscode-x86_64.rpm > /var/rpm/code.rpm
	@curl http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm > /var/rpm/skype.rpm
	@curl http://downloads.dlang.org/releases/2.x/2.071.0/dmd-2.071.0-0.fedora.x86_64.rpm > /var/rpm/dmd.rpm
	@cp rpmbuild/RPMS/x86_64/*.rpm /var/rpm/
	@createrepo /var/rpm
clean:
	@rm -rf rpmbuild/RPMS
	@rm -rf rpmbuild/SRPMS
	@rm -rf rpmbuild/BUILD
	@rm -rf rpmbuild/BUILDROOT
wk: .force
	@setenforce 0
	@livecd-creator --verbose --config=wk.ks --fslabel=fedora --cache=/var/cache/live
.force:
