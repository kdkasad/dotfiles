#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

int
main(int argc, char *argv[]) {
	struct termios orig_attr, raw_attr;
	tcgetattr(STDIN_FILENO, &orig_attr);
	raw_attr = orig_attr;

	raw_attr.c_lflag &= ~(ECHO|ICANON);

	tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw_attr);
	fputs("\033[?25l", stdout);

	if (!(argc >= 2 && strcmp("-q", argv[1]) == 0))
		puts("Press any key to continue...");

	getchar();

	fputs("\033[?25h", stdout);
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_attr);
}
