



PAGES = \
	beta.html \
	bugs.html \
	compatibility.html \
	compiling.html \
	copyright.html \
	download.html \
	faq.html \
	installation.html \
	intro.html \
	lazy.html \
	news.html \
	papers.html \
	advanced.html \
	modularization.html \
	start.html \
	tutorial.html 

TOPICS = \
	topics_beta.html\
	topics_bugs.html\
	topics_compatibility.html\
	topics_compiling.html\
	topics_copyright.html\
	topics_download.html\
	topics_faq.html\
	topics_installation.html\
	topics_intro.html\
	topics_lazy.html\
	topics_news.html\
	topics_papers.html\
	topics_advanced.html\
	topics_modularization.html\
	topics_start.html\
	topics_tutorial.html

INDICES = \
	index_beta.html \
	index_bugs.html \
	index_compatibility.html \
	index_compiling.html \
	index_copyright.html \
	index_download.html \
	index_faq.html \
	index_installation.html \
	index_intro.html \
	index_lazy.html \
	index_news.html \
	index_papers.html \
	index_advanced.html \
	index_modularization.html \
	index_start.html \
	index_tutorial.html 

ADVPAGES = \
	advC.html advnumbersC.html advanced_indexC.html \
	adv1.html advnumbers1.html advanced_index1.html \
	adv2.html advnumbers2.html advanced_index2.html \
	adv3.html advnumbers3.html advanced_index3.html \
	adv4.html advnumbers4.html advanced_index4.html \
	adv5.html advnumbers5.html advanced_index5.html \
	adv6.html advnumbers6.html advanced_index6.html \
	adv7.html advnumbers7.html advanced_index7.html \
	adv8.html advnumbers8.html advanced_index8.html \
	adv9.html advnumbers9.html advanced_index9.html 

MODPAGES = \
	modC.html modnumbersC.html modularization_indexC.html \
	mod1.html modnumbers1.html modularization_index1.html \
	mod2.html modnumbers2.html modularization_index2.html \
	mod3.html modnumbers3.html modularization_index3.html \
	mod4.html modnumbers4.html modularization_index4.html \
	mod5.html modnumbers5.html modularization_index5.html 

STARTPAGES = \
	startC.html startnumbersC.html start_indexC.html \
	start1.html startnumbers1.html start_index1.html \
	start2.html startnumbers2.html start_index2.html \
	start3.html startnumbers3.html start_index3.html \
	start4.html startnumbers4.html start_index4.html \
	start5.html startnumbers5.html start_index5.html \
	start6.html startnumbers6.html start_index6.html \
	start7.html startnumbers7.html start_index7.html \
	start8.html startnumbers8.html start_index8.html \
	start9.html startnumbers9.html start_index9.html 

TUTPAGES = \
	tutC.html tutnumbersC.html tutorial_indexC.html \
	tut1.html tutnumbers1.html tutorial_index1.html \
	tut2.html tutnumbers2.html tutorial_index2.html \
	tut3.html tutnumbers3.html tutorial_index3.html \
	tut4.html tutnumbers4.html tutorial_index4.html \
	tut5.html tutnumbers5.html tutorial_index5.html \
	tut6.html tutnumbers6.html tutorial_index6.html \
	tut7.html tutnumbers7.html tutorial_index7.html \
	tut8.html tutnumbers8.html tutorial_index8.html \
	tut9.html tutnumbers9.html tutorial_index9.html \
	tut10.html tutnumbers10.html tutorial_index10.html \
	tut11.html tutnumbers11.html tutorial_index11.html \
	tut12.html tutnumbers12.html tutorial_index12.html \
	tut13.html tutnumbers13.html tutorial_index13.html \
	tut14.html tutnumbers14.html tutorial_index14.html \
	tut15.html tutnumbers15.html tutorial_index15.html \
	tut16.html tutnumbers16.html tutorial_index16.html 

SUBPAGES = $(ADVPAGES) $(MODPAGES) $(STARTPAGES) $(TUTPAGES)

%.html: %.m4 Makefile gbetastd.m4
	m4 $< > $*.html
	chmod 644 $*.html 

all: make_file links $(TOPICS) $(PAGES) $(INDICES) $(SUBPAGES)

##### Rules for main pages and their indices and topic lists

index_beta.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=beta NUMBER=""; m4 index.m4 > index_beta.html; )
	chmod 644 index_beta.html 
index_bugs.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=bugs NUMBER=""; m4 index.m4 > index_bugs.html; )
	chmod 644 index_bugs.html 
index_compatibility.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=compatibility NUMBER=""; m4 index.m4 > index_compatibility.html; )
	chmod 644 index_compatibility.html 
index_compiling.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=compiling NUMBER=""; m4 index.m4 > index_compiling.html; )
	chmod 644 index_compiling.html 
index_copyright.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=copyright NUMBER=""; m4 index.m4 > index_copyright.html; )
	chmod 644 index_copyright.html 
index_download.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=download NUMBER=""; m4 index.m4 > index_download.html; )
	chmod 644 index_download.html 
index_faq.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=faq NUMBER=""; m4 index.m4 > index_faq.html; )
	chmod 644 index_faq.html 
index_installation.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=installation NUMBER=""; m4 index.m4 > index_installation.html; )
	chmod 644 index_installation.html 
index_intro.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=intro NUMBER=""; m4 index.m4 > index_intro.html; )
	chmod 644 index_intro.html 
index_lazy.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=lazy NUMBER=""; m4 index.m4 > index_lazy.html; )
	chmod 644 index_lazy.html 
index_news.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=news NUMBER=""; m4 index.m4 > index_news.html; )
	chmod 644 index_news.html 
index_papers.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=papers NUMBER=""; m4 index.m4 > index_papers.html; )
	chmod 644 index_papers.html 

index_advanced.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=advanced NUMBER="_index1"; m4 index.m4 > index_advanced.html; )
	chmod 644 index_advanced.html
index_modularization.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=modularization NUMBER="_index1"; m4 index.m4 > index_modularization.html; )
	chmod 644 index_modularization.html
index_start.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=start NUMBER="_index1"; m4 index.m4 > index_start.html; )
	chmod 644 index_start.html
index_tutorial.html: index.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=tutorial NUMBER="_index1"; m4 index.m4 > index_tutorial.html; )
	chmod 644 index_tutorial.html

topics_beta.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=beta NUMBER=""; m4 topics.m4 > topics_beta.html; )
	chmod 644 topics_beta.html 
topics_bugs.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=bugs NUMBER=""; m4 topics.m4 > topics_bugs.html; )
	chmod 644 topics_bugs.html 
topics_compatibility.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=compatibility NUMBER=""; m4 topics.m4 > topics_compatibility.html; )
	chmod 644 topics_compatibility.html 
topics_compiling.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=compiling NUMBER=""; m4 topics.m4 > topics_compiling.html; )
	chmod 644 topics_compiling.html 
topics_copyright.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=copyright NUMBER=""; m4 topics.m4 > topics_copyright.html; )
	chmod 644 topics_copyright.html 
topics_download.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=download NUMBER=""; m4 topics.m4 > topics_download.html; )
	chmod 644 topics_download.html 
topics_faq.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=faq NUMBER=""; m4 topics.m4 > topics_faq.html; )
	chmod 644 topics_faq.html 
topics_installation.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=installation NUMBER=""; m4 topics.m4 > topics_installation.html; )
	chmod 644 topics_installation.html 
topics_intro.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=intro NUMBER=""; m4 topics.m4 > topics_intro.html; )
	chmod 644 topics_intro.html 
topics_lazy.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=lazy NUMBER=""; m4 topics.m4 > topics_lazy.html; )
	chmod 644 topics_lazy.html 
topics_news.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=news NUMBER=""; m4 topics.m4 > topics_news.html; )
	chmod 644 topics_news.html 
topics_papers.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=papers NUMBER=""; m4 topics.m4 > topics_papers.html; )
	chmod 644 topics_papers.html 

topics_advanced.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=advanced NUMBER="_index1"; m4 topics.m4 > topics_advanced.html; )
	chmod 644 topics_advanced.html 
topics_modularization.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=modularization NUMBER="_index1"; m4 topics.m4 > topics_modularization.html; )
	chmod 644 topics_modularization.html 
topics_start.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=start NUMBER="_index1"; m4 topics.m4 > topics_start.html; )
	chmod 644 topics_start.html 
topics_tutorial.html: topics.m4 gbetastd.m4 Makefile
	( export FOCUS NUMBER; FOCUS=tutorial NUMBER="_index1"; m4 topics.m4 > topics_tutorial.html; )
	chmod 644 topics_tutorial.html 

beta.html: beta.m4 gbetastd.m4 Makefile
	m4 beta.m4 > beta.html
	chmod 644 beta.html 
bugs.html: bugs.m4 gbetastd.m4 Makefile
	m4 bugs.m4 > bugs.html
	chmod 644 bugs.html 
compatibility.html: compatibility.m4 gbetastd.m4 Makefile
	m4 compatibility.m4 > compatibility.html
	chmod 644 compatibility.html 
compiling.html: compiling.m4 gbetastd.m4 Makefile
	m4 compiling.m4 > compiling.html
	chmod 644 compiling.html 
copyright.html: copyright.m4 gbetastd.m4 Makefile
	m4 copyright.m4 > copyright.html
	chmod 644 copyright.html 
download.html: download.m4 gbetastd.m4 Makefile
	m4 download.m4 > download.html
	chmod 644 download.html 
faq.html: faq.m4 gbetastd.m4 Makefile
	m4 faq.m4 > faq.html
	chmod 644 faq.html 
installation.html: installation.m4 gbetastd.m4 Makefile
	m4 installation.m4 > installation.html
	chmod 644 installation.html 
intro.html: intro.m4 gbetastd.m4 Makefile
	m4 intro.m4 > intro.html
	chmod 644 intro.html 
lazy.html: lazy.m4 gbetastd.m4 Makefile
	m4 lazy.m4 > lazy.html
	chmod 644 lazy.html 
news.html: news.m4 gbetastd.m4 Makefile
	m4 news.m4 > news.html
	chmod 644 news.html 
papers.html: papers.m4 gbetastd.m4 Makefile
	m4 papers.m4 > papers.html
	chmod 644 papers.html 
advanced.html: advanced.m4 gbetastd.m4 Makefile
	m4 advanced.m4 > advanced.html
	chmod 644 advanced.html 
modularization.html: modularization.m4 gbetastd.m4 Makefile
	m4 modularization.m4 > modularization.html
	chmod 644 modularization.html 
start.html: start.m4 gbetastd.m4 Makefile
	m4 start.m4 > start.html
	chmod 644 start.html 
tutorial.html: tutorial.m4 gbetastd.m4 Makefile
	m4 tutorial.m4 > tutorial.html
	chmod 644 tutorial.html 

##### Rules for subpages (advanced/modularization/getting-started/tutorial)

advanced_indexC.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 advanced.m4 > advanced_indexC.html; )
	chmod 644 advanced_indexC.html
advanced_index1.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 advanced.m4 > advanced_index1.html; )
	chmod 644 advanced_index1.html
advanced_index2.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 advanced.m4 > advanced_index2.html; )
	chmod 644 advanced_index2.html
advanced_index3.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 advanced.m4 > advanced_index3.html; )
	chmod 644 advanced_index3.html
advanced_index4.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 advanced.m4 > advanced_index4.html; )
	chmod 644 advanced_index4.html
advanced_index5.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 advanced.m4 > advanced_index5.html; )
	chmod 644 advanced_index5.html
advanced_index6.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=6; m4 advanced.m4 > advanced_index6.html; )
	chmod 644 advanced_index6.html
advanced_index7.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=7; m4 advanced.m4 > advanced_index7.html; )
	chmod 644 advanced_index7.html
advanced_index8.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=8; m4 advanced.m4 > advanced_index8.html; )
	chmod 644 advanced_index8.html
advanced_index9.html: advanced.m4 advancedstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=9; m4 advanced.m4 > advanced_index9.html; )
	chmod 644 advanced_index9.html

modularization_indexC.html: modularization.m4 modularizationstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 modularization.m4 > modularization_indexC.html; )
	chmod 644 modularization_indexC.html
modularization_index1.html: modularization.m4 modularizationstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 modularization.m4 > modularization_index1.html; )
	chmod 644 modularization_index1.html
modularization_index2.html: modularization.m4 modularizationstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 modularization.m4 > modularization_index2.html; )
	chmod 644 modularization_index2.html
modularization_index3.html: modularization.m4 modularizationstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 modularization.m4 > modularization_index3.html; )
	chmod 644 modularization_index3.html
modularization_index4.html: modularization.m4 modularizationstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 modularization.m4 > modularization_index4.html; )
	chmod 644 modularization_index4.html
modularization_index5.html: modularization.m4 modularizationstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 modularization.m4 > modularization_index5.html; )
	chmod 644 modularization_index5.html

start_indexC.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 start.m4 > start_indexC.html; )
	chmod 644 start_indexC.html
start_index1.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 start.m4 > start_index1.html; )
	chmod 644 start_index1.html
start_index2.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 start.m4 > start_index2.html; )
	chmod 644 start_index2.html
start_index3.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 start.m4 > start_index3.html; )
	chmod 644 start_index3.html
start_index4.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 start.m4 > start_index4.html; )
	chmod 644 start_index4.html
start_index5.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 start.m4 > start_index5.html; )
	chmod 644 start_index5.html
start_index6.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=6; m4 start.m4 > start_index6.html; )
	chmod 644 start_index6.html
start_index7.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=7; m4 start.m4 > start_index7.html; )
	chmod 644 start_index7.html
start_index8.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=8; m4 start.m4 > start_index8.html; )
	chmod 644 start_index8.html
start_index9.html: start.m4 startstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=9; m4 start.m4 > start_index9.html; )
	chmod 644 start_index9.html

tutorial_indexC.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 tutorial.m4 > tutorial_indexC.html; )
	chmod 644 tutorial_indexC.html
tutorial_index1.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 tutorial.m4 > tutorial_index1.html; )
	chmod 644 tutorial_index1.html
tutorial_index2.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 tutorial.m4 > tutorial_index2.html; )
	chmod 644 tutorial_index2.html
tutorial_index3.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 tutorial.m4 > tutorial_index3.html; )
	chmod 644 tutorial_index3.html
tutorial_index4.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 tutorial.m4 > tutorial_index4.html; )
	chmod 644 tutorial_index4.html
tutorial_index5.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 tutorial.m4 > tutorial_index5.html; )
	chmod 644 tutorial_index5.html
tutorial_index6.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=6; m4 tutorial.m4 > tutorial_index6.html; )
	chmod 644 tutorial_index6.html
tutorial_index7.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=7; m4 tutorial.m4 > tutorial_index7.html; )
	chmod 644 tutorial_index7.html
tutorial_index8.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=8; m4 tutorial.m4 > tutorial_index8.html; )
	chmod 644 tutorial_index8.html
tutorial_index9.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=9; m4 tutorial.m4 > tutorial_index9.html; )
	chmod 644 tutorial_index9.html
tutorial_index10.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=10; m4 tutorial.m4 > tutorial_index10.html; )
	chmod 644 tutorial_index10.html
tutorial_index11.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=11; m4 tutorial.m4 > tutorial_index11.html; )
	chmod 644 tutorial_index11.html
tutorial_index12.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=12; m4 tutorial.m4 > tutorial_index12.html; )
	chmod 644 tutorial_index12.html
tutorial_index13.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=13; m4 tutorial.m4 > tutorial_index13.html; )
	chmod 644 tutorial_index13.html
tutorial_index14.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=14; m4 tutorial.m4 > tutorial_index14.html; )
	chmod 644 tutorial_index14.html
tutorial_index15.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=15; m4 tutorial.m4 > tutorial_index15.html; )
	chmod 644 tutorial_index15.html
tutorial_index16.html: tutorial.m4 tutorialstd.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=16; m4 tutorial.m4 > tutorial_index16.html; )
	chmod 644 tutorial_index16.html


advnumbersC.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 advnumbers.m4 > advnumbersC.html; )
	chmod 644 advnumbersC.html 
advnumbers1.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 advnumbers.m4 > advnumbers1.html; )
	chmod 644 advnumbers1.html 
advnumbers2.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 advnumbers.m4 > advnumbers2.html; )
	chmod 644 advnumbers2.html 
advnumbers3.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 advnumbers.m4 > advnumbers3.html; )
	chmod 644 advnumbers3.html 
advnumbers4.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 advnumbers.m4 > advnumbers4.html; )
	chmod 644 advnumbers4.html 
advnumbers5.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 advnumbers.m4 > advnumbers5.html; )
	chmod 644 advnumbers5.html 
advnumbers6.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=6; m4 advnumbers.m4 > advnumbers6.html; )
	chmod 644 advnumbers6.html 
advnumbers7.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=7; m4 advnumbers.m4 > advnumbers7.html; )
	chmod 644 advnumbers7.html 
advnumbers8.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=8; m4 advnumbers.m4 > advnumbers8.html; )
	chmod 644 advnumbers8.html 
advnumbers9.html: advnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=9; m4 advnumbers.m4 > advnumbers9.html; )
	chmod 644 advnumbers9.html 

modnumbersC.html: modnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 modnumbers.m4 > modnumbersC.html; )
	chmod 644 modnumbersC.html 
modnumbers1.html: modnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 modnumbers.m4 > modnumbers1.html; )
	chmod 644 modnumbers1.html 
modnumbers2.html: modnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 modnumbers.m4 > modnumbers2.html; )
	chmod 644 modnumbers2.html 
modnumbers3.html: modnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 modnumbers.m4 > modnumbers3.html; )
	chmod 644 modnumbers3.html 
modnumbers4.html: modnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 modnumbers.m4 > modnumbers4.html; )
	chmod 644 modnumbers4.html 
modnumbers5.html: modnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 modnumbers.m4 > modnumbers5.html; )
	chmod 644 modnumbers5.html 

startnumbersC.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 startnumbers.m4 > startnumbersC.html; )
	chmod 644 startnumbersC.html 
startnumbers1.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 startnumbers.m4 > startnumbers1.html; )
	chmod 644 startnumbers1.html 
startnumbers2.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 startnumbers.m4 > startnumbers2.html; )
	chmod 644 startnumbers2.html 
startnumbers3.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 startnumbers.m4 > startnumbers3.html; )
	chmod 644 startnumbers3.html 
startnumbers4.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 startnumbers.m4 > startnumbers4.html; )
	chmod 644 startnumbers4.html 
startnumbers5.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 startnumbers.m4 > startnumbers5.html; )
	chmod 644 startnumbers5.html 
startnumbers6.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=6; m4 startnumbers.m4 > startnumbers6.html; )
	chmod 644 startnumbers6.html 
startnumbers7.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=7; m4 startnumbers.m4 > startnumbers7.html; )
	chmod 644 startnumbers7.html 
startnumbers8.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=8; m4 startnumbers.m4 > startnumbers8.html; )
	chmod 644 startnumbers8.html 
startnumbers9.html: startnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=9; m4 startnumbers.m4 > startnumbers9.html; )
	chmod 644 startnumbers9.html 

tutnumbersC.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=C; m4 tutnumbers.m4 > tutnumbersC.html; )
	chmod 644 tutnumbersC.html 
tutnumbers1.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=1; m4 tutnumbers.m4 > tutnumbers1.html; )
	chmod 644 tutnumbers1.html 
tutnumbers2.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=2; m4 tutnumbers.m4 > tutnumbers2.html; )
	chmod 644 tutnumbers2.html 
tutnumbers3.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=3; m4 tutnumbers.m4 > tutnumbers3.html; )
	chmod 644 tutnumbers3.html 
tutnumbers4.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=4; m4 tutnumbers.m4 > tutnumbers4.html; )
	chmod 644 tutnumbers4.html 
tutnumbers5.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=5; m4 tutnumbers.m4 > tutnumbers5.html; )
	chmod 644 tutnumbers5.html 
tutnumbers6.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=6; m4 tutnumbers.m4 > tutnumbers6.html; )
	chmod 644 tutnumbers6.html 
tutnumbers7.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=7; m4 tutnumbers.m4 > tutnumbers7.html; )
	chmod 644 tutnumbers7.html 
tutnumbers8.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=8; m4 tutnumbers.m4 > tutnumbers8.html; )
	chmod 644 tutnumbers8.html 
tutnumbers9.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=9; m4 tutnumbers.m4 > tutnumbers9.html; )
	chmod 644 tutnumbers9.html 
tutnumbers10.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=10; m4 tutnumbers.m4 > tutnumbers10.html; )
	chmod 644 tutnumbers10.html 
tutnumbers11.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=11; m4 tutnumbers.m4 > tutnumbers11.html; )
	chmod 644 tutnumbers11.html 
tutnumbers12.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=12; m4 tutnumbers.m4 > tutnumbers12.html; )
	chmod 644 tutnumbers12.html 
tutnumbers13.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=13; m4 tutnumbers.m4 > tutnumbers13.html; )
	chmod 644 tutnumbers13.html 
tutnumbers14.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=14; m4 tutnumbers.m4 > tutnumbers14.html; )
	chmod 644 tutnumbers14.html 
tutnumbers15.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=15; m4 tutnumbers.m4 > tutnumbers15.html; )
	chmod 644 tutnumbers15.html 
tutnumbers16.html: tutnumbers.m4 gbetastd.m4 Makefile
	( export FOCUS; FOCUS=16; m4 tutnumbers.m4 > tutnumbers16.html; )
	chmod 644 tutnumbers16.html 


advC.html: advancedstd.m4
adv1.html: advancedstd.m4
adv2.html: advancedstd.m4
adv3.html: advancedstd.m4
adv4.html: advancedstd.m4
adv5.html: advancedstd.m4
adv6.html: advancedstd.m4
adv7.html: advancedstd.m4
adv8.html: advancedstd.m4
adv9.html: advancedstd.m4

modC.html: modularizationstd.m4
mod1.html: modularizationstd.m4
mod2.html: modularizationstd.m4
mod3.html: modularizationstd.m4
mod4.html: modularizationstd.m4
mod5.html: modularizationstd.m4

startC.html: startstd.m4
start1.html: startstd.m4
start2.html: startstd.m4
start3.html: startstd.m4
start4.html: startstd.m4
start5.html: startstd.m4
start6.html: startstd.m4
start7.html: startstd.m4
start8.html: startstd.m4
start9.html: startstd.m4

tutC.html: tutorialstd.m4
tut1.html: tutorialstd.m4
tut2.html: tutorialstd.m4
tut3.html: tutorialstd.m4
tut4.html: tutorialstd.m4
tut5.html: tutorialstd.m4
tut6.html: tutorialstd.m4
tut7.html: tutorialstd.m4
tut8.html: tutorialstd.m4
tut9.html: tutorialstd.m4
tut10.html: tutorialstd.m4
tut11.html: tutorialstd.m4
tut12.html: tutorialstd.m4
tut13.html: tutorialstd.m4
tut14.html: tutorialstd.m4
tut15.html: tutorialstd.m4
tut16.html: tutorialstd.m4


##### Rules for index sub-pages



startC.m4: startC.pre startC.post Makefile
	./create_startC
tutC.m4: tutC.pre tutC.post Makefile
	./create_tutC
modC.m4: modC.pre modC.post Makefile
	./create_modC
advC.m4: advC.pre advC.post Makefile
	./create_advC

##### Auxiliary rules

links: Makefile.m4
	ln -sf index_intro.html index.html

make_file: Makefile.m4
	m4 Makefile.m4 > make_file
	cp -f make_file Makefile
	chmod 644 Makefile

showtopics:
	ls *.m4 | grep -ve '[0-9A-G]\.m4' | grep -ve numbers

