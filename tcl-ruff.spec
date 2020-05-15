%{!?directory:%define directory /usr}

%define buildroot %{_tmppath}/%{name}
%define packagename ruff

Name:          tcl-ruff
Summary:       Generates reference documentation for Tcl programs
Version:       1.0.4
Release:       0
License:       BSD
Group:         Development/Libraries/Tcl
Source:        %{packagename}-%{version}.tar.gz
URL:           http://woof.sourceforge.net/ruff.html
BuildArch:     noarch
BuildRequires: tcl >= 8.6
Requires:      tcl >= 8.6
Requires:      tcllib
BuildRoot:     %{buildroot}

%description
Ruff! generates reference documentation for Tcl programs using runtime
introspection.

Ruff! generates documentation using Tcl's runtime system to extract proc,
class and method definitions.

%prep
%setup -q -n %{packagename}-%{version}

%build

%install
dir=%buildroot%tcl_noarchdir/%packagename%version
mkdir -p $dir
cp src/*.tcl $dir

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%doc doc/ruff.html doc/ruff_ruff.html doc/ruff_ruff_sample.html doc/sample.tcl
%tcl_noarchdir/%packagename%version

