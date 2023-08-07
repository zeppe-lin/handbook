.POSIX:

include config.mk

POD = handbook.7.pod
MAN = handbook.7
PDF = Zeppe-Lin-Handbook.pdf

all: help
help:

man:
	pod2man -r "${NAME} ${VERSION}" -c "${DESCRIPTION}" \
		-n handbook -s 7 ${POD} > ${MAN}

pdf:
	pod2pdf --title "${DESCRIPTION}" \
		--footer-text "${NAME} ${VERSION}" ${POD} > ${PDF}

install-man: man
	mkdir -p         ${DESTDIR}${MANPREFIX}/man7
	cp -f handbook.7 ${DESTDIR}${MANPREFIX}/man7/
	chmod 0644       ${DESTDIR}${MANPREFIX}/man7/handbook.7

uninstall-man:
	rm -f ${DESTDIR}${MANPREFIX}/man7/handbook.7

clean:
	rm -f ${MAN} ${PDF}
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: install-man uninstall-man clean dist
