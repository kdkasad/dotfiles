include config.mk

SRC = <++>
OBJ = ${SRC:.c=.o}
BIN = <++>

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
