ABOUT
-----
This directory contains _Zeppe-Lin Handbook_, which is used for
generating _Zeppe-Lin Website_ (<https://zeppe-lin.github.io>) and the
`handbook(7)` manual page.

REQUIREMENTS
------------
Build time:
  * POSIX sh(1p), make(1p) and "mandatory utilities"
  * pod2man(1p) to build man page

Tests:
  * podchecker(1pm) to check POD for errors
  * curl(1) to check URLs for response code

INSTALL
-------
The shell commands `make man && make install-man` should build and
install this _handbook_ as a manual page.

The shell command `make check` should start some tests.

LICENSE
-------
_handbook_ is licensed through WTFPLv2 License.
See _LICENSE_ file for copyright and license details.

<!-- vim:sw=2:ts=2:sts=2:et:cc=72:tw=70
End of file. -->
