#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include<signal.h>
#include<X11/Xlib.h>
#define LENGTH(X)               (sizeof(X) / sizeof (X[0]))
#define CMDLENGTH		50

typedef struct {
	char* icon;
	char* command;
	unsigned int interval;
	unsigned int signal;
	unsigned char skip_on_update_all;
} Block;
void sighandler(int num);
void buttonhandler(int sig, siginfo_t *si, void *ucontext);
void getcmds(int time);
#ifndef __OpenBSD__
void getsigcmds(int signal);
void setupsignals();
void sighandler(int signum);
#endif
int getstatus(char *str, char *last);
void setroot();
void statusloop();
void termhandler(int signum);


#include "blocks.h"

static Display *dpy;
static int screen;
static Window root;
static char statusbar[LENGTH(blocks)][CMDLENGTH] = {0};
static char statusstr[2][256];
static char exportstring[CMDLENGTH + 16] = "export BUTTON=-;";
static int button = 0;
static int statusContinue = 1;
static void (*writestatus) () = setroot;

//opens process *cmd and stores output in *output
void getcmd(const Block *block, char *output, _Bool lastblock)
{
	if (block->signal)
	{
		output[0] = block->signal;
		output++;
	}
	strcpy(output, block->icon);
	char* cmd;
	FILE *cmdf;
	if (button)
	{
		cmd = strcat(exportstring, block->command);
		cmd[14] = '0' + button;
		button = 0;
		cmdf = popen(cmd,"r");
		cmd[16] = '\0';
	}
	else
	{
		cmd = block->command;
		cmdf = popen(cmd,"r");
	}
	if (!cmdf)
		return;
	int i = strlen(block->icon);
	fgets(output+i, CMDLENGTH-i, cmdf);
	i = strlen(output);
	if (i && !lastblock)
		for (int d = 0; delim[d] != '\0'; d++)
			output[i++] = delim[d];
	output[i++] = '\0';
	pclose(cmdf);
}

void getcmds(int time)
{
	const Block* current;
	for(int i = 0; i < LENGTH(blocks); i++)
	{	
		current = blocks + i;
		if ((current->interval != 0 && time % current->interval == 0) || (time == -1 && current->skip_on_update_all == 0))
			getcmd(current,statusbar[i],i==LENGTH(blocks)-1);
	}
}

void update_all(int signum)
{
	getcmds(-1);
}

#ifndef __OpenBSD__
void getsigcmds(int signal)
{
	const Block *current;
	for (int i = 0; i < LENGTH(blocks); i++)
	{
		current = blocks + i;
		if (current->signal == signal)
			getcmd(current,statusbar[i],i==LENGTH(blocks)-1);
	}
}

void setupsignals()
{
	struct sigaction sa;
	signal(SIGRTMIN, update_all);
	sigaddset(&sa.sa_mask, SIGRTMIN);
	for(int i = 0; i < LENGTH(blocks); i++)
	{	  
		if (blocks[i].signal > 0)
		{
			signal(SIGRTMIN+blocks[i].signal, sighandler);
			sigaddset(&sa.sa_mask, SIGRTMIN+blocks[i].signal);
		}
	}
	sa.sa_sigaction = buttonhandler;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &sa, NULL);

}
#endif

int getstatus(char *str, char *last)
{
	strcpy(last, str);
	strcpy(str, leftpadding);
	str[strlen(leftpadding)] = '\0';
	for(int i = 0; i < LENGTH(blocks); i++)
		strcat(str, statusbar[i]);
	strcpy(str+strlen(str)-1, rightpadding);
	return strcmp(str, last);//0 if they are the same
}

void setroot()
{
	if (!getstatus(statusstr[0], statusstr[1]))//Only set root if text has changed.
		return;
	Display *d = XOpenDisplay(NULL);
	if (d) {
		dpy = d;
	}
	screen = DefaultScreen(dpy);
	root = RootWindow(dpy, screen);
	XStoreName(dpy, root, statusstr[0]);
	XCloseDisplay(dpy);
}

void pstdout()
{
	if (!getstatus(statusstr[0], statusstr[1]))//Only write out if text has changed.
		return;
	printf("%s\n",statusstr[0]);
	fflush(stdout);
}


void statusloop()
{
#ifndef __OpenBSD__
	setupsignals();
#endif
	int i = 0;
	getcmds(-1);
	while(statusContinue)
	{
		getcmds(i);
		writestatus();
		sleep(1.0);
		i++;
	}
}

#ifndef __OpenBSD__
void sighandler(int signum)
{
	getsigcmds(signum-SIGRTMIN);
	writestatus();
}

void buttonhandler(int sig, siginfo_t *si, void *ucontext)
{
	button = si->si_value.sival_int & 0xff;
	getsigcmds(si->si_value.sival_int >> 8);
	writestatus();
}

#endif

void termhandler(int signum)
{
	statusContinue = 0;
	exit(0);
}

int main(int argc, char** argv)
{
	for(int i = 0; i < argc; i++)
	{	
		if (!strcmp("-d",argv[i]))
			delim = argv[++i];
		else if(!strcmp("-p",argv[i]))
			writestatus = pstdout;
	}
	signal(SIGTERM, termhandler);
	signal(SIGINT, termhandler);
	statusloop();
}
