include config.mk

SRC = pause.c
OBJ = ${SRC:.c=.o}
BIN = pause

all: options ${BIN}

options:
	@echo "CFLAGS	= ${CFLAGS}"
	@echo "LDFLAGS	= ${LDFLAGS}"
	@echo "CC		= ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

${BIN}: ${OBJ}
	${CC} -o $@ $^ ${LDFLAGS}

clean:
	@echo cleaning...
	@rm -f ${BIN} ${OBJ}

install: ${BIN}
	install -m 0755 pause ${PREFIX}/bin/pause
	install -m 0644 pause.1 ${MANPREFIX}/man1/pause.1

uninstall:
	rm -f /usr/local/bin/pause
