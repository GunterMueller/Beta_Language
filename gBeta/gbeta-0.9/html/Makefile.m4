include(gbetastd.m4)dnl
dnl
PAGES = foreach(`\
	$1.html ',topic_list,subtopic_list)

TOPICS = foreach(`\
	topics_$1.html',topic_list,subtopic_list)

INDICES = foreach(`\
	index_$1.html ',topic_list,subtopic_list)

ADVPAGES = foreach(`\
	adv$1.html advnumbers$1.html advanced_index$1.html ',adv_numbers)

MODPAGES = foreach(`\
	mod$1.html modnumbers$1.html modularization_index$1.html ',mod_numbers)

STARTPAGES = foreach(`\
	start$1.html startnumbers$1.html start_index$1.html ',start_numbers)

TUTPAGES = foreach(`\
	tut$1.html tutnumbers$1.html tutorial_index$1.html ',tut_numbers)

SUBPAGES = $(ADVPAGES) $(MODPAGES) $(STARTPAGES) $(TUTPAGES)

%.html: %.m4 Makefile gbetastd.m4
	m4 $< > $*.html
	chmod 644 $*.html 

all: make_file links $(TOPICS) $(PAGES) $(INDICES) $(SUBPAGES)

##### Rules for main pages and their indices and topic lists

define(`create_header',`$2_$1.html: $2.m4 gbetastd.m4 Makefile')dnl
define(`create_index',
	`( export FOCUS NUMBER; FOCUS=$1 NUMBER=$2; m4 index.m4 > index_$1.html; )')dnl
define(`create_topics',
	`( export FOCUS NUMBER; FOCUS=$1 NUMBER=$2; m4 topics.m4 > topics_$1.html; )')dnl
dnl
foreach(`create_header($1,index)
	create_index($1,"")
	chmod 644 index_$1.html 
',topic_list)dnl

foreach(`create_header($1,index)
	create_index($1,"_index1")
	chmod 644 index_$1.html
',subtopic_list)dnl

foreach(`create_header($1,topics)
	create_topics($1,"")
	chmod 644 topics_$1.html 
',topic_list)dnl

foreach(`create_header($1,topics)
	create_topics($1,"_index1")
	chmod 644 topics_$1.html 
',subtopic_list)dnl

foreach(`$1.html: $1.m4 gbetastd.m4 Makefile
	m4 $1.m4 > $1.html
	chmod 644 $1.html 
',topic_list,subtopic_list)dnl

##### Rules for subpages (advanced/modularization/getting-started/tutorial)

define(`subindex_rule',`$1`'_index$`'1.html: $1.m4 $1std.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=$`'1; m4 $1.m4 > $1`'_index$`'1.html; )
	chmod 644 $1`'_index$`'1.html
')dnl
foreach(subindex_rule(`advanced'),adv_numbers)
foreach(subindex_rule(`modularization'),mod_numbers)
foreach(subindex_rule(`start'),start_numbers)
foreach(subindex_rule(`tutorial'),tut_numbers)

define(`number_rule',`$1`'numbers$`'1.html: $1`'numbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=$`'1; m4 $1`'numbers.m4 > $1`'numbers$`'1.html; )
	chmod 644 $1`'numbers$`'1.html 
')dnl
foreach(number_rule(`adv'),adv_numbers)
foreach(number_rule(`mod'),mod_numbers)
foreach(number_rule(`start'),start_numbers)
foreach(number_rule(`tut'),tut_numbers)

foreach(`adv$1.html: advancedstd.m4
',adv_numbers)
foreach(`mod$1.html: modularizationstd.m4
',mod_numbers)
foreach(`start$1.html: startstd.m4
',start_numbers)
foreach(`tut$1.html: tutorialstd.m4
',tut_numbers)

##### Rules for index sub-pages

define(`index_rule',`$1C.m4: $1C.pre $1C.post Makefile
	./create_$1C')

index_rule(start)
index_rule(tut)
index_rule(mod)
index_rule(adv)

##### Auxiliary rules

links: Makefile.m4
	ln -sf index_intro.html index.html

make_file: Makefile.m4
	m4 Makefile.m4 > make_file
	cp -f make_file Makefile
	chmod 644 Makefile

showtopics:
	ls *.m4 | grep -ve '[0-9A-G]\.m4' | grep -ve numbers

