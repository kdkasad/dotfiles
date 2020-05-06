PREFIX = ~/.local
MANPREFIX = $(PREFIX)/share/man

COMPILER_ARGS=
DEBUG_OPTS=-g -Wall
RELEASE_OPTS = -O3
LIBS=

default: debug

debug: CONFIG=DEBUG
debug: all

release: CONFIG=RELEASE
release: all

all: backlightctl

clean:
	rm -f backlightctl

install: all
	install -m 0755 -T backlightctl $(PREFIX)/bin/backlightctl
	install -m 0644 -T backlightctl.1 $(MANPREFIX)/man1/backlightctl.1

uninstall:
	rm -f /usr/local/backlightctl $(PREFIX)/man/man1/backlightctl.1

backlightctl: backlightctl.c
	${CC} $(COMPILER_ARGS) $($(CONFIG)_OPTS) -o $@ $^ $(LIBS)
