//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"", "sb-weather",		3600,	0},
	{"", "sb-disk",			  3600,	0},
	{"", "sb-cpuavg",			6,		0},
	{"", "sb-memory",			6,		0},
	{"", "sb-volume",			0,		10},
	{"", "sb-clock",			15,		0},
	{"", "sb-internet",		15,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
