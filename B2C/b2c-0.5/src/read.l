%{

/* scanner for BETA2c */

#include <ctype.h>

%}

digit		[0-9]
letter		[_A-Za-z]
alphanum	[_A-Za-z0-9]

name		{letter}{alphanum}*
intconst	{digit}+
exponent	e[+-]?{intconst}
realconst	({digit}+|{digit}+\.{digit}*|{digit}*\.{digit}+){exponent}?
stringconst	'([^'\\]|''|\\.)*'

whitespace	[ \t\n\f]

%%

\(\*([^*]|\*+[^*)])*\*+\)	{ /* ignore comments */ }

"(#"			{ return PAT_BEG; }
"#)"			{ return PAT_END; }
"##"			{ return PATTERNVAR; }
"@@"			{ return ADDRESS; }
"->"			{ return ASSIGN; }
"<<"			{ return SLOT_BEG; }
">>"			{ return SLOT_END; }
"//"			{ return CASE_SELECTION; }
"\[\]"			{ return REFERENCE; }
---*			{ return FRAGMENT; }
slot			{ return SLOT; }

enter			{ return ENTER; }
do			{ return DO; }
exit			{ return EXIT; }
inner			{ return INNER; }
leave			{ return LEAVE; }
restart			{ return RESTART; }
if			{ return IF; }
then			{ return THEN; }
else			{ return ELSE; }
for			{ return FOR; }

mod			{ return MOD; }
div			{ return DIV; }
and			{ return AND; }
or			{ return OR; }
xor			{ return XOR; }
not			{ return NOT; }
none			{ return NONE; }
this			{ return THIS; }
"<>"			{ return NE; }
"<="			{ return LE; }
">="			{ return GE; }

objectdescriptor	{ return OBJECTDESCRIPTOR; }
descriptor		{ return OBJECTDESCRIPTOR; }
attributes?		{ return ATTRIBUTES; }
attributedecl		{ return ATTRIBUTES; }
dopart			{ return DOPART; }
{name}			{ return NAME; }

{intconst}		{ return INTEGER; }
{realconst}		{ return REAL; }
{stringconst}		{ return STRING; }

{whitespace}		{ /* empty */ }

.			{ return yytext[0]; }

%%

int yywrap(void)
{
    return 1;
}

int yyerror(char *str)
{
    fprintf(stderr, "%s:%d: %s\n", thisfilename, yylineno, str);
}
