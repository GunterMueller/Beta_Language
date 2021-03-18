# make the parser:

CFLAGS = -O2
LFLAGS = -i -8
CC = gcc

all: parse.o

parse.o: read.c
