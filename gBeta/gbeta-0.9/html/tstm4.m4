define(`foo',`ifelse(`',`$1',`',`$1: not empty')')
dnl traceon
foo
foo(`test')

