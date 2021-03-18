#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

struct handle {
    int pid;		/* PID of process, after it has been started */
    int argc;		/* number of args */
    int nfd;		/* number of pairs in fds */
    int cfd;		/* number of pairs in fds */
    int *fds;		/* file descriptors to dup2 before executing */
    char *dir;		/* directory */
    char *argv[2];	/* the arguments themselves */
};

struct handle *systemjobstart(int argc, int nfd)
{
    struct handle *h = (struct handle *)
		       malloc(sizeof(struct handle) + (argc+1)*sizeof(char *));
    if(h == 0) {
	fprintf(stderr, "\n\nBETA library ERROR: "
			"Out of memory in systemjobstart()\n");
	exit(1);
    }
    h->pid = 0;
    memset((void *) h, 0, sizeof(struct handle) + (argc+1)*sizeof(char *));
    h->argc = argc;
    h->nfd  = nfd;
    if(nfd>0) {
	h->fds = (int *) malloc(sizeof(int) * nfd * 2);
	if(h->fds == 0) {
	    fprintf(stderr, "\n\nBETA library ERROR: "
			    "Out of memory in systemjobstart()\n");
	    exit(1);
	}
    }
    return h;
}

void systemjobsetarg(struct handle *h, int n, char *arg)
{
    char *copy = (char *) malloc(strlen(arg) + 1);
    if(copy == 0) {
	fprintf(stderr, "BETA library ERROR: "
			"Out of memory in systemjobsetarg()\n");
	exit(1);
    }
    if((unsigned) (n+1) > (unsigned) h->argc) {
	fprintf(stderr, "BETA library ERROR: "
			"Argument index too high in systemjobsetarg()\n");
	exit(1);
    }
    strcpy(copy, arg);
    h->argv[n+1] = copy;
}

void systemjobsetdir(struct handle *h, char *dir)
{
    char *copy = (char *) malloc(strlen(dir) + 1);
    if(copy == 0) {
	fprintf(stderr, "BETA library ERROR: "
			"Out of memory in systemjobsetarg()\n");
	exit(1);
    }
    if(h->dir)
	free((void *) h->dir);
    strcpy(copy, dir);
    h->dir = copy;
}

void systemjobsetfd(struct handle *h, int from, int to)
{
    if((unsigned) h->cfd >= (unsigned) h->nfd) {
	fprintf(stderr, "BETA library ERROR: "
			"systemjobsetfd called too often!\n");
	exit(1);
    }
    h->fds[2 * h->cfd    ] = from;
    h->fds[2 * h->cfd + 1] = to;
    h->cfd++;
}


int systemjobrunit(struct handle *h, int searchpath)
{
    const char *c, *d;
    int i;

    if(h->pid != 0) {
	fprintf(stderr, "BETA library ERROR: "
			"systemjobrunit() called twice!\n");
	exit(1);
    }

    /* Fill in argv[1] with the name of the command, if not provided */
    if(! h->argv[1]) {
	if(! h->argv[0]) {
	    fprintf(stderr, "BETA library ERROR: "
			    "no command name provided in systemjobrunit()!\n");
	    exit(1);
	}
	c = d = h->argv[0];
	while(*c) {
	    if(*c++ == '/')
		d = c;
	}
	h->argv[1] = (char *) malloc(strlen(d) + 1);
	strcpy(h->argv[1], d);
    }

    /* Fork the process. */
    h->pid = vfork();
    if(h->pid == 0) {
	/* Duplicate file descriptors, if requested. */
	for(i = 0; i < h->cfd; i++) {
	    if(dup2(h->fds[2*i], h->fds[2*i+1]) < 0) {
		fprintf(stderr, "error on dup2()\n");
		_exit(1);
	    }
	    if(fcntl(h->fds[2*i+1], F_SETFD, 0) < 0) {
		fprintf(stderr, "error on F_SETFD\n");
		_exit(1);
	    }
	    if(close(h->fds[2*i]) < 0) {
		fprintf(stderr, "error on close\n");
		_exit(1);
	    }
	}

	/* Set new directory */
	if(h->dir)
	    if(chdir(h->dir) < 0) {
		fprintf(stderr, "error on chdir\n");
		_exit(1);
	    }

	/* Try to execute the requested executable. */
	if(searchpath)
	    execvp(h->argv[0], h->argv+1); 
	else
	    execv(h->argv[0], h->argv+1); 
	fprintf(stderr, "error on exec\n");
	_exit(1);
    }

    return h->pid;
}

int systemjobwait(int pid)
{
    int res,status;

    if(pid>0) {
#ifdef __linux__
	do {
	    res = waitpid(pid, &status, 0);
	} while(res == -1 && errno == ERESTART);
#else
	res = waitpid(pid, &status, 0);
#endif
	if(res < 0) {
	    return res;
	} else if(res == pid) {
	    return status;
	} else {
	    fprintf(stderr, "BETA library ERROR: "
			    "waitpid() returned garbage in systemwaitjob()!\n");
	}
    }
    return -1;
}

void systemjobend(struct handle *h)
{
    int i;

    for(i = h->argc; --i>=0; )
	free((void *) h->argv[i]);
    if(h->fds)
	free((void *) h->fds);
    if(h->dir)
	free((void *) h->dir);
    free((void *) h);
}
