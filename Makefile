default:
	@echo no
bootstrap: .force
	@dnf install -y livecd-tools spin-kickstarts createrepo fedora-packager
	@mkdir /var/rpm
	@curl https://az764295.vo.msecnd.net/stable/fa6d0f03813dfb9df4589c30121e9fcffa8a8ec8/vscode-x86_64.rpm > /var/rpm/code.rpm
	@createrepo /var/rpm
rpm: .force
	@rpmbuild --define "_topdir $(shell pwd)/rpmbuild" -bb rpmbuild/SPECS/fossil-scm.spec
install: .force
	@cp rpmbuild/RPMS/x86_64/*.rpm /var/rpm/
	@createrepo /var/rpm
download:
	@curl https://www.fossil-scm.org/index.html/tarball/fossil-src.tar.gz > rpmbuild/SOURCES/fossil-src.tar.gz
clean:
	@rm -rf rpmbuild/RPMS
	@rm -rf rpmbuild/SRPMS
	@rm -rf rpmbuild/BUILD
	@rm -rf rpmbuild/BUILDROOT
wk: .force
	@setenforce 0
	@livecd-creator --verbose --config=wk.ks --fslabel=fedora --cache=/var/cache/live
.force:
