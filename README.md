ABOUT
-----
This directory contains *Zeppe-Lin Handbook*, which is used for
generating *Zeppe-Lin Website* (<https://zeppe-lin.github.io>) and the
`handbook(7)` manual page.

REQUIREMENTS
------------
Build time:
  * POSIX sh(1p), make(1p) and "mandatory utilities"
  * pod2man(1p) to generate man page

Tests:
  * podchecker(1pm) to check POD for errors
  * httpx(1) to check URLs for non-200 response code

INSTALL
-------
The shell commands `make man && make install-man` should build and
install this *handbook* as a manual page.

LICENSE
-------
*handbook* is licensed through WTFPLv2 License.
See *LICENSE* file for copyright and license details.


<!-- vim:sw=2:ts=2:sts=2:et:cc=72:tw=70
End of file. -->
