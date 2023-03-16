.POSIX:

include config.mk

man:
	pod2man -r "handbook ${VERSION}" -n handbook -s 7 \
		-c 'Zeppe-Lin Handbook' handbook.7.pod > handbook.7

install-man: man
	mkdir -p         ${DESTDIR}${MANPREFIX}/man7
	cp -f handbook.7 ${DESTDIR}${MANPREFIX}/man7/
	chmod 0644       ${DESTDIR}${MANPREFIX}/man7/handbook.7

uninstall-man:
	rm -f ${DESTDIR}${MANPREFIX}/man7/handbook.7

clean:
	rm -f handbook.7

.PHONY: install-man uninstall-man clean
