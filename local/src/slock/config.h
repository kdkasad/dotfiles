/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#473D4B",     /* after initialization */
	[INPUT] =  "#88A9CE",   /* during input */
	[FAILED] = "#F06D72",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
