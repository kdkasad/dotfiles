#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BL_DIR "/sys/class/backlight/intel_backlight"

const char* brightness_file = BL_DIR"/brightness";
const char* max_brightness_file = BL_DIR"/max_brightness";

int scale, current, max;
FILE *b_fh;

void load_current(void) {
	b_fh = fopen(brightness_file, "r");
	if (b_fh == NULL) {
		perror("Unable to read brightness control file");
	}
	FILE* mb_fh = fopen(max_brightness_file, "r");
	if (mb_fh == NULL) {
		perror("Unable to read brightness control file");
	}

	if (fscanf(mb_fh, "%d", &max) != 1) {
		perror("Unable to get max brightness level");
		exit(EXIT_FAILURE);
	}
	if (fscanf(b_fh, "%d", &current) != 1) {
		perror("Unable to get current brightness level");
		exit(EXIT_FAILURE);
	}

	scale = max / 100;

	fclose(b_fh);
	b_fh = NULL;
	fclose(mb_fh);
}

int main(int argc, char** argv) {
	
	if (argc < 3) {
		if (strcmp(argv[1], "get") == 0)
			goto get;
		else
			goto usage;
	} else if (argc > 3) {
		fputs("backlightctl only takes 1 or 2 arguments. the rest will be ignored", stderr);
	}

	int amount;
	if (sscanf(argv[2], "%d", &amount) != 1) {
		fputs("Invalid amount. It must be an integer between 0 and 100", stderr);
		exit(EXIT_FAILURE);
	}

	if (strcmp(argv[1], "inc") == 0) {
		load_current();
		b_fh = fopen(brightness_file, "w");
		if (b_fh == NULL) {
			perror("Unable to write to brightness file");
			exit(EXIT_FAILURE);
		}
		amount = current + amount * scale;
		if (amount < 0)
			amount = 0;
		else if (amount > max)
			amount = max;
		fprintf(b_fh, "%d\n", amount);
	} else if (strcmp(argv[1], "dec") == 0) {
		load_current();
		b_fh = fopen(brightness_file, "w");
		if (b_fh == NULL) {
			perror("Unable to write to brightness file");
			exit(EXIT_FAILURE);
		}
		amount = current - amount * scale;
		if (amount < 0)
			amount = 0;
		else if (amount > max)
			amount = max;
		fprintf(b_fh, "%d\n", amount);
	} else if (strcmp(argv[1], "set") == 0) {
		load_current();
		b_fh = fopen(brightness_file, "w");
		if (b_fh == NULL) {
			perror("Unable to write to brightness file");
			exit(EXIT_FAILURE);
		}
		amount *= scale;
		if (amount < 0)
			amount = 0;
		else if (amount > max)
			amount = max;
		fprintf(b_fh, "%d\n", amount);
	} else if (strcmp(argv[1], "get") == 0) {
get:
			load_current();
			printf("%d\n", current / scale);
	} else {
		goto usage;
	}

	if (b_fh != NULL)
		fclose(b_fh);
	return 0;

usage:
	fputs("Usage: backlightctl <inc|dec|set> <percent>\n"
		 "Example: `backlightctl inc 10` will increase the brightness by 10%\n"
		 "         `backlightctl set 50` will set the brightness to 50%", stderr);
	return 1;
}
