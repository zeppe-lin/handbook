# handbook version
VERSION = 0.1

# paths
PREFIX    = /usr/local
MANPREFIX = ${PREFIX}/share/man

check:
	@echo "=======> Check PODs for errors"
	@podchecker *.pod
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" *.* \
		| grep -v fileserver.intranet  \
		| xargs -P10 -I{} curl -o /dev/null -sw "%{url} [%{http_code}]\n" '{}'

man:
	pod2man --nourls -r ${VERSION} -n handbook -s 7 \
		-c 'Zeppe-Lin Handbook' handbook.7.pod > handbook.7

install-man: man
	mkdir -p         ${DESTDIR}${MANPREFIX}/man7
	cp -f handbook.7 ${DESTDIR}${MANPREFIX}/man7/

uninstall-man:
	rm -f ${DESTDIR}${MANPREFIX}/man7/handbook.7

clean:
	rm -f handbook.7

.PHONY: install-man uninstall-man clean
