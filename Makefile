PREFIX=/usr
LIBDIR = ${PREFIX}/lib
INCLUDEDIR = ${PREFIX}/include
DATADIR = ${PREFIX}/share

SOVERSION=1.0.0

all: libfoo.so.$(SOVERSION)

foo.o: foo.c
	$(CC) -c -fpic foo.c $(CFLAGS) $(CPPFLAGS)

libfoo.so.$(SOVERSION): foo.o
	$(CC) -shared ${LDFLAGS} -Wl,-soname,libfoo.so.1 -o libfoo.so.$(SOVERSION) foo.o

install: libfoo.so.$(SOVERSION)
	mkdir -p $(DESTDIR)$(LIBDIR)
	install libfoo.so.$(SOVERSION) $(DESTDIR)$(LIBDIR)/
	(cd $(DESTDIR)$(LIBDIR) && ln -s -f libfoo.so.$(SOVERSION) libfoo.so.1 && ln -s libfoo.so.$(SOVERSION) libfoo.so )
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	install foo.h $(DESTDIR)$(INCLUDEDIR)
	mkdir -p $(DESTDIR)$(DATADIR)/foo
	install readme.txt $(DESTDIR)$(DATADIR)/foo
