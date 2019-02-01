Introswift_Intro
===========================================
.. .rst to .html: rst2html5 foo.rst > foo.html
..                pandoc -s -f rst -t html5 -o foo.html foo.rst

Main app sub-package for Swift Intro examples project.

Installation
------------
source code tarball download:

        # [aria2c --check-certificate=false | wget --no-check-certificate | curl -kOL]

        FETCHCMD='aria2c --check-certificate=false'

        $FETCHCMD https://bitbucket.org/thebridge0491/introswift/[get | archive]/master.zip

version control repository clone:

        git clone https://bitbucket.org/thebridge0491/introswift.git

build example with swiftpm:
cd <path> ; swift build [--package-path ??] [-Xlinker -L$PREFIX/lib]

[swift test [--package-path ??] [-Xlinker -L$PREFIX/lib]]

Usage
-----
        [env RSRC_PATH=<path>/resources] [$PREFIX/bin/]Introswift_IntroMain [-h]

Author/Copyright
----------------
Copyright (c) 2019 by thebridge0491 <thebridge0491-codelab@yahoo.com>

License
-------
Licensed under the Apache-2.0 License. See LICENSE for details.
