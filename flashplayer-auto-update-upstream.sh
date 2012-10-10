#!/bin/sh

version=$1
filename=flashplayer--${version}--i386.tar.gz
fileprefix=/tmp
filepath=${fileprefix}/${filename}
url=http://www.orientadores.pmmc.com.br/cpi/partner/flashplayer/${filename}

wget -c ${url} -P ${fileprefix}
file_sha256sum=$(sha256sum ${filepath} | awk '{ print $1 }')

sed -i -e "s/VERSION = .*$/VERSION = ${version}/" -e "s/SHA256SUM = .*$/SHA256SUM = ${file_sha256sum}/" Makefile

git add -A
git commit -em "New upstream version ${version}"
git tag -s -m "Upstream version ${version}" v${version}
git archive --format=tar.gz --prefix=pmmc-pte-flashplayer-${version}/ -o ~/pmmc-pte-flashplayer-${version}.tar.gz v${version}
git push
git push --tags
