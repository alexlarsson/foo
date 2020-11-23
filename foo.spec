%define _source_payload w9.gzdio
%define _binary_payload w9.gzdio

Name:           foo
Version:        1.0.0
Release:        1%{?dist}
Summary:        Application deployment framework for desktop apps
License:        MIT

Source: https://github.com/alexlarsson/foo/releases/download/1.0.0/foo-1.0.0.tar.gz

%description
A trivial library dependency


%package -n libfoo
Summary: The foo library

%description -n libfoo
A trivial library dependency library

%package devel
Summary: The foo headers
Requires: libfoo = %{version}-%{release}

%description devel
A trivial library dependency headers


%prep
%setup -q -n %{name}-%{version}

%build
make CFLAGS=-g

%install
make install DESTDIR=%{buildroot} LIBDIR=%{_libdir}

%files
/usr/share/foo/readme.txt

%files -n libfoo
%{_libdir}/libfoo.so.*

%files devel
%{_includedir}/foo.h
%{_libdir}/libfoo.so

%changelog
* Wed Nov 18 2020 Alexander Larsson <alexl@redhat.com> - 1.0.0.-1
- FOO THE BARS!
