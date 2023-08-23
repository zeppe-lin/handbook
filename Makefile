.POSIX:

include config.mk

POD = handbook.7.pod
MAN = handbook.7
TXT = handbook.7.txt
PDF = handbook.7.pdf

all: help
help:

man:
	pod2man -r "${NAME} ${VERSION}" -c "${DESCRIPTION}" \
		-n handbook -s 7 ${POD} > ${MAN}

txt:
	pod2text ${POD} > ${TXT}

pdf:
	pod2pdf --footer-text "${NAME} ${VERSION}" \
		--title "${DESCRIPTION}" ${POD} > ${PDF}

install-man: man
	mkdir -p         ${DESTDIR}${MANPREFIX}/man7
	cp -f handbook.7 ${DESTDIR}${MANPREFIX}/man7/
	chmod 0644       ${DESTDIR}${MANPREFIX}/man7/handbook.7

uninstall-man:
	rm -f ${DESTDIR}${MANPREFIX}/man7/handbook.7

clean:
	rm -f ${MAN} ${PDF} ${TXT}
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: man txt pdf install-man uninstall-man clean dist
