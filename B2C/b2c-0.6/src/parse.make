# make the parser:

CFLAGS = -O2
LFLAGS = -l -i -8
LEX = flex

all: parse.o

parse.o: read.c
