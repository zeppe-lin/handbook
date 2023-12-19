include config.mk

MAN = handbook.7
PDF = handbook.7.pdf
POD = handbook.7.pod
TXT = handbook.7.txt

all: help
help:

pod:
	perl -0pe 's/\R?$$/\n\n/' src/*.pod | sed '/^# vim: .*/d' > ${POD}

man: pod
	# remove section numbering from =head[1234] and L</"...">
	# remove "=ff" pdf extension
	sed -r -e 's/^(=head[12])\s+([0-9\.]+)\s+(.*)/\1 \3/'       \
	       -e 's/^(=head[34])\s+B<([0-9\.]+)\s+(.*)>/\1 B<\3>/' \
	       -e 's/L<\/"([0-9\.]+)\s+(.*)">/L<\/"\2\">/'          \
	       -e 's/^=ff$$//'                                      \
	       ${POD} > MAN.${POD}
	# check generated pod for syntax errors
	podchecker MAN.${POD}
	# prepare man page
	pod2man -r "${NAME} ${VERSION}" -c "${DESCRIPTION}" \
		-n handbook -s 7 MAN.${POD} > ${MAN}

txt: pod
	pod2text ${POD} > ${TXT}

pdf: pod
	# remove man and html formatting
	perl -0pe 's/^=begin man[\r\n].*?^=end man[\r\n]//gms;     \
	           s/^=begin html[\r\n].*?^=end html[\r\n]//gms;   \
		   s/\bPer Lidén\b/Per Liden/gms;'                 \
		${POD} > PDF.${POD}
	# check generated pod for syntax errors (skip =ff extension)
	sed '/^=ff$$/d' PDF.${POD} | podchecker -
	# prepare pdf
	pod2pdf --footer-text "${NAME} ${VERSION}" --outlines      \
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
