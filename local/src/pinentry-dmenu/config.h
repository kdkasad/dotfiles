/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int bottom = 0;
static int embedded = 1;
static int minpwlen = 32;
static int mon = -1;

static const char *asterisk = "*";
static const char *fonts[] = {
	"display:style=Regular:size=14",
	"sans-serif",
};
static const char *prompt = NULL;
static const char *colors[SchemeLast][4] = {
	[SchemePrompt] = { "#473d4b", "#f9c1c4" },
	[SchemeNormal] = { "#ffffff", "#473d4b" },
	[SchemeSelect] = { "#473d4b", "#f9c1c4" },
	[SchemeDesc]   = { "#ffffff", "#473d4b" }
};
