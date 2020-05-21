VERSION = 0.0


PREFIX = ~/.local
MANPREFIX = ${PREFIX}/share/man

INCS = -I/usr/include
LIBS = -L/usr/lib -lc

CPPFLAGS = -DVERSION=\"${VERSION}\"
CFLAGS = -std=c99 -pedantic -Wall -O3 ${INCS} ${CPPFLAGS}
LDFLAGS = -s ${LIBS}

CC = cc
