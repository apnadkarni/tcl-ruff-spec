#!/usr/bin/tclsh

set arch "noarch"
set base "ruff-2.2.0"

set var2 [list git clone https://github.com/apnadkarni/ruff.git $base]
exec >@stdout 2>@stderr {*}$var2

cd $base

set var2 [list git checkout 6c235e8160dc452bcabc2e42325ee0e2b635a7e4]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

file delete -force .git

cd ..

set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-ruff.spec]
exec >@stdout 2>@stderr {*}$buildit

file delete -force $base
file delete $base.tar.gz
