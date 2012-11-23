VERSION = 11.2.202.251
SHA256SUM = 94d94f6bfc896174030a0a843e9cf36058d69be5a500b83da03c2d17e40e9893
PREFIX = $(DESTDIR)/usr
PTE_PREFIX = $(DESTDIR)/opt/pmmc/pte
STANDALONE = 0


build: linux/share/functions

ifeq ($(STANDALONE), 1)
install: install-main install-data
else
install: install-main
endif

install-main: linux/share/functions
	install -D -m 644 linux/share/functions $(PREFIX)/share/pmmc-pte-flashplayer/functions

install-data: linux/share/functions
	./flashplayer-install.sh $(PTE_PREFIX)/bin

clean:
	rm -f linux/share/functions

linux/%: linux/%.in
	sed -e "s/@VERSION@/$(VERSION)/g" -e "s/@SHA256SUM@/$(SHA256SUM)/g" < $< > $@
