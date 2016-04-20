Name:             fossil-scm
Version:          1.35
Release:          1%{?dist}
Summary:          A distributed SCM with bug tracking and wiki
Group:            Development/Tools
License:          BSD
URL:              https://www.fossil-scm.org/
Source:           https://www.fossil-scm.org/index.html/tarball/fossil-src.tar.gz

BuildRequires:    openssl-devel
BuildRequires:    tcl

%description
Fossil is a simple, high-reliability, distributed software configuration
management with distributed bug tracking, distributed wiki and built-in web
interface.

%package doc
Summary:          Fossil documentation
Group:            Documentation

%description doc
Documentation in HTML format for %{name}.

%prep
%setup -q -n fossil-src

%build
./configure --prefix=/usr --disable-fusefs --json --with-th1-docs --with-th1-hooks --with-tcl --with-tcl-stubs --with-tcl-private-stubs
%{__make} CFLAGS="%{optflags}" %{?_smp_mflags}

%install
# For EPEL5 support
%{__rm} -fr %{buildroot}
make DESTDIR=%{buildroot} install

# For EPEL5 support
%clean
%{__rm} -fr %{buildroot}

%files
%defattr(-,root,root,-)
%doc COPYRIGHT-BSD2.txt
%attr(0755, -, -) %{_bindir}/fossil

