all: deadlinks podchecker longlines

deadlinks:
	@echo "=======> Check for dead links"
	@grep -EIihor "https?://[^\"\\'> ]+" --exclude-dir=.git*  \
		| grep -v fileserver.intranet                     \
		| xargs -P10 -r -I{} curl -I -o/dev/null          \
		  -sw "[%{http_code}] %{url}\n" '{}'              \
		| grep -v '^\[200\]'                              \
		| sort -u

podchecker:
	@echo "=======> Check PODs for syntax errors"
	@podchecker *.pod

longlines:
	@echo "=======> Check for long lines"
	@grep -PIrn '^.{81,}$$' --exclude-dir=.git* || :

.PHONY: deadlinks podchecker longlines
