include config.mk

SRC = <++>
OBJ = ${SRC:.c=.o}
BIN = <++>

all: options ${BIN}

options:
	@echo "CFLAGS	= ${CFLAGS}"
	@echo "LDFLAGS	= ${LDFLAGS}"
	@echo "CC		= ${CC}"
	@echo

install: ${BIN}
	@echo "installing..."
	@install -Dm755 ${BIN} -t ${DESTDIR}${PREFIX}/bin/

uninstall:
	@echo "uninstalling"
	@rm -f ${addprefix ${DESTDIR}${PREFIX}/bin/, ${BIN}}

%.o: %.c
	${CC} ${CFLAGS} -c -o $@ $^

${BIN}: ${OBJ}
	${CC} -o $@ $^ ${LDFLAGS}

clean:
	@echo cleaning...
	@rm -f ${BIN} ${OBJ}

.PHONY: all options install uninstall clean
