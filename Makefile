VERSION = 11.2.202.236
SHA256SUM = 03b38c56f1dbcfd8b95ab6ad8da1240df8f030687a4bcbafe005b47ed0ca038d
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
