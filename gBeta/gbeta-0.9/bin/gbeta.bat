rem 
rem   This script runs gbeta on the Windows NT/95
rem   platform, setting up some env.vars first
rem
rem For installation you should only need to look at the lines
rem between "INSTALL BEGIN" and "INSTALL END".

rem ----- INSTALL BEGIN -----

rem GBETA_ROOT must point to the root directory of the gbeta installation 
set GBETA_ROOT=f:\gbeta-0.9

rem ----- INSTALL END -----

rem Setup paths to the interpreter and to its grammar tables
set GBETA_METAGRAMMAR_PATH=%GBETA_ROOT%\grammars\metagram\v4.4\metagrammar
set GBETA_GRAMMAR_PATH=%GBETA_ROOT%\grammars\beta\v2.6\beta
set GBETA_GGRAMMAR_PATH=%GBETA_ROOT%\grammars\gbeta\v1.0\gbeta
set GBETA=%GBETA_ROOT%\bin\gbeta.exe

%GBETA% %1 %2 %3 %4 %5 %6 %7 %8 %9

rem Local variables:
rem mode: shell-script
rem end:

