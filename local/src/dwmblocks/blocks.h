//Modify this file to change what commands output to your statusbar, and recompile using the make command.

#define BD "~/.scripts/statusbar/"

static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{ "",		BD"inet",						40,		3,		0 },
	{ "",		BD"packages",				   600,		4,		0 },
	{ "☀",	"backlightctl get | sed 's/$/%/'",3600,		2,		0 },
	{ "",		BD"volume",					  3600,		1,		0 },
	{ "",		BD"battery",					20,		5,		0 },
	{ "",		BD"cpu",						10,		6,		1 },
	{ "",		BD"memory",						10,		7,		0 },
	{ "",		BD"datetime",					20,		8,		0 },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char *delim = " | ";

static char *leftpadding = " ";
static char *rightpadding = " ";
