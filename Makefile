include config.mk

MAN = handbook.7
PDF = handbook.7.pdf
POD = handbook.7.pod
TXT = handbook.7.txt

all: help
help:

pod:
	@: 1. concatenate pods into handbook pod
	@: 2. btw, remove vimline
	perl -0pe 's/\R?$$/\n\n/' src/*.pod | sed '/^# vim: .*/d' > ${POD}

man: pod
	@: prepare temporary pod file for future manual page:
	@: 1. remove section numbering from '=head[1-4]' and 'L</"...">'
	@: 2. remove '=ff' pdf extension
	sed -e 's/^(=head[12])\s+([0-9\.]+)\s+(.*)/\1 \3/' \
	    -e 's/^(=head[34])\s+B<([0-9\.]+)\s+(.*)>/\1 B<\3>/' \
	    -e 's/L<\/"([0-9\.]+)\s+(.*)">/L<\/"\2\">/' \
	    -e 's/^=ff$$//' \
	    -r ${POD} > MAN.${POD}
	@: 3. check generated pod for syntax errors
	podchecker MAN.${POD}
	@: 4. prepare manual page
	pod2man -r "${NAME} ${VERSION}" -c "${DESCRIPTION}" \
		-n handbook -s 7 MAN.${POD} > ${MAN}

txt: pod
	pod2text ${POD} > ${TXT}

pdf: pod
	@: 1. remove manual page and html formatting sections
	@: 2. replace utf8 sentence to fix pdf rendering
	perl -0pe 's/^=begin (man|html)[\r\n].*?^=end \1[\r\n]//gms; \
	s/\bPer Lidén\b/Per Liden/gms;' ${POD} > PDF.${POD}
	@: 3. check generated pod file for syntax errors
	@: 4. btw, skip '=ff' pdf extension while checking
	sed '/^=ff$$/d' PDF.${POD} | podchecker -
	@: 5. prepare pdf
	pod2pdf --footer-text "${NAME} ${VERSION}" --outlines \
		--title "${DESCRIPTION}" PDF.${POD} > ${PDF}

install-man: man
	mkdir -p     ${DESTDIR}${MANPREFIX}/man7
	cp -f ${MAN} ${DESTDIR}${MANPREFIX}/man7/
	chmod 0644   ${DESTDIR}${MANPREFIX}/man7/${MAN}

uninstall-man:
	rm -f ${DESTDIR}${MANPREFIX}/man7/${MAN}

clean:
	rm -f ${POD} ${MAN} ${TXT} ${PDF} MAN.${POD} PDF.${POD}
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: man txt pdf install-man uninstall-man clean dist
