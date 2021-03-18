#include <stdio.h>
#include <curses.h>

WINDOW *getstdscr(void) { return stdscr; }
FILE *getstdin(void)  { return stdin; }
FILE *getstdout(void) { return stdout; }

int wininfo(WINDOW *w, int arg)
{
    int x,y;

    switch(arg) {
    case 0: getmaxyx(w, y, x); return x;
    case 1: getmaxyx(w, y, x); return y;
    case 2: getbegyx(w, y, x); return x;
    case 3: getbegyx(w, y, x); return y;
    default:
	fprintf(stderr, "BETA library error: Bad argument %d to wininfo()\n",
		arg);
	exit(1);
	return 0;
    }
}


int attinfo(int arg)
{
    int x,y;

    if(arg >= 0)
	return COLOR_PAIR(arg);

    switch(arg) {
    case  -1: return WA_STANDOUT;
    case  -2: return WA_UNDERLINE;
    case  -3: return WA_REVERSE;
    case  -4: return WA_BLINK;
    case  -5: return WA_DIM;
    case  -6: return WA_BOLD;
    case  -7: return WA_ALTCHARSET;
    case  -8: return WA_INVIS;
    case  -9: return WA_PROTECT;
    case -98: return COLORS;
    case -99: return COLOR_PAIRS;
    default:
	fprintf(stderr, "BETA library error: Bad argument %d to attinfo()\n",
		arg);
	exit(1);
	return 0;
    }
}
