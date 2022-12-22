# handbook version
VERSION = 0.1

check:
	@podchecker README.pod
	@grep -Eiho "https?://[^\"\\'> ]+" *.* | httpx -silent -fc 200 -sc

