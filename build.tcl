#!/usr/bin/tclsh

set arch "noarch"
set base "ruff-1.0.5"

set fileurl "https://github.com/apnadkarni/ruff/archive/v1.0.5.tar.gz"

set var [list wget $fileurl -O $base.tar.gz]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-ruff.spec]
exec >@stdout 2>@stderr {*}$buildit

file delete $base.tar.gz
