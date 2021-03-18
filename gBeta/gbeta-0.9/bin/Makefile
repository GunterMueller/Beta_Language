
default: gbeta-0.9-i386-linux-elf-bin ../emacs/gud-gbeta.elc

force: 
	mv -f ../src/main/gbeta ../src/main/gbeta-deleted

linux: 
	rm gbeta-0.9-i386-linux-elf-bin 
	cp ../src/main/gbeta gbeta-0.9-i386-linux-elf-bin

sun: 
	rm gbeta-0.9-sparc-sun-solaris2.5-bin
	cp ../src/main/gbeta gbeta-0.9-sparc-sun-solaris2.5-bin

gbeta-0.9-i386-linux-elf-bin: ../src/main/gbeta
	ln -fs ../src/main/gbeta gbeta-0.9-i386-linux-elf-bin

../src/main/gbeta: 
	( cd ../grammars; ../bin/dogrammar )
	( cd ../src/main; beta -lq gbeta )

../emacs/gud-gbeta.elc: 
	( cd ../emacs; ./compile-elisp )
