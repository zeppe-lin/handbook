deadlinks:
	@echo "=======> deadlinks"
	@grep -EIihor "https?://[^\"\\'> ]+" --exclude-dir=.git*  \
		| grep -v fileserver.intranet                     \
		| xargs -P10 -r -I{} curl -I -o/dev/null          \
		  -sw "[%{http_code}] %{url}\n" '{}'              \
		| grep -v '^\[200\]'                              \
		| sort -u

podchecker:
	@echo "=======> podchecker"
	@podchecker *.pod

longlines:
	@echo "=======> longlines"
	@grep -PIrn '^.{81,}$$' --exclude-dir=.git* || :

.PHONY: deadlinks podchecker longlines
