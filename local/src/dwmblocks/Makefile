PREFIX ?= ~/.local

output: dwmblocks.c blocks.h
	cc -Wall `pkg-config --cflags x11` `pkg-config --libs x11` dwmblocks.c -o dwmblocks
clean:
	rm -f *.o *.gch dwmblocks
install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 dwmblocks $(DESTDIR)$(PREFIX)/bin
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks
