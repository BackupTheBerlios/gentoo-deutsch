DESTDIR=
LIBDIR=/usr/share/vdradmin
ETCDIR=/etc/vdradmin
DOCDIR=/usr/share/doc/vdradmin

distclean:
	rm -f vdradmind.conf vdradmind.at vdradmind.pid vdradmind.log

install:
	@if [ ! -d $(DESTDIR)/usr/bin ]; then \
		mkdir -p $(DESTDIR)/usr/bin; \
	fi
	cp vdradmind.pl $(DESTDIR)/usr/bin

	@if [ ! -d $(DESTDIR)$(LIBDIR) ]; then \
		mkdir -p $(DESTDIR)$(LIBDIR); \
	fi
	cp -ar vdradmind.inc.pl template lib $(DESTDIR)$(LIBDIR)

	@if [ ! -d $(DESTDIR)$(ETCDIR) ]; then \
		mkdir -p $(DESTDIR)$(ETCDIR); \
	fi

	@if [ ! -d $(DESTDIR)$(DOCDIR) ]; then \
		mkdir -p $(DESTDIR)$(DOCDIR); \
	fi
	cp -ar COPYING HISTORY INSTALL contrib $(DESTDIR)$(DOCDIR)	
	@echo HINT: dont forget to change \$$SEARCH_FILES_IN_SYSTEM
	
