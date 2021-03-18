%{
#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <sys/resource.h>

static int (*PushNone)(void);
static int (*CreateObjectDescriptor)(void);
static int (*CreateNoEnterObjectDescriptor)(void);
static int (*CreatePatternDecl)(void);
static int (*CreateVirtualDecl)(int type);
static int (*CreateSimpleDecl)(int type);
static int (*CreateRepetitionDecl)(int type);
static int (*CreatePatternVariableDecl)();
static int (*CreateName)(int string);
static int (*CreateNameApl)(int string);
static int (*CreateRemote)(int string);
static int (*CreateComputedRemote)(int string);
static int (*CreateThisObject)(int string);
static int (*CreateEvaluationImp)(void);
static int (*CreateInnerImp)(int string);
static int (*CreateSimpleIfImp)(int haselse);
static int (*CreateGeneralIfImp)(int haselse);
static int (*CreateCaseSelection)(void);
static int (*CreateAlternative)(void);
static int (*CreateLeaveImp)(int string);
static int (*CreateRestartImp)(int string);
static int (*CreateLabelledImp)(int string);
static int (*CreateObjectEvaluation)(int dynamic);
static int (*CreateObjectReference)(void);
static int (*CreateStructureReference)(void);
static int (*CreateAssignmentEvaluation)(void);
static int (*CreateEqExp)(void);
static int (*CreateNeExp)(void);
static int (*CreateLtExp)(void);
static int (*CreateLeExp)(void);
static int (*CreateGtExp)(void);
static int (*CreateGeExp)(void);
static int (*CreatePlusExp)(void);
static int (*CreateMinusExp)(void);
static int (*CreateTimesExp)(void);
static int (*CreateRealDivExp)(void);
static int (*CreateIntDivExp)(void);
static int (*CreateModExp)(void);
static int (*CreateAndExp)(void);
static int (*CreateOrExp)(void);
static int (*CreateXorExp)(void);
static int (*CreateNotExp)(void);
static int (*CreateNoneExp)(void);
static int (*CreateRepetitionSlice)(void);
static int (*CreateUnaryPlusExp)(void);
static int (*CreateUnaryMinusExp)(void);
static int (*CreateIndexed)(void);
static int (*CreateIntegerConst)(int i);
static int (*CreateRealConst)(int real);
static int (*CreateStringConst)(int str);
static int (*CreateEvalList)(void);
static int (*CreateFragment)(int type, int name);
static int (*CreateSlot)(int type, int name);

static int (*AddAttribute)(void);
static int (*AddName)(void);
static int (*AddImperative)(void);
static int (*AddEvaluation)(void);
static int (*AddAlternative)(void);
static int (*AddSelection)(void);

static char *thisfilename;


void install2beta0(int i, int (*cb)(void))
{
    switch(i) {
    case  0: PushNone = cb; break;
    case  1: AddName = cb; break;
    case  2: AddAttribute = cb; break;
    case  3: AddImperative = cb; break;
    case  4: AddEvaluation = cb; break;
    case  5: CreateObjectDescriptor = cb; break;
    case  6: CreateNoEnterObjectDescriptor = cb; break;
    case  7: CreatePatternDecl = cb; break;
    case  8: CreateEvalList = cb; break;
    case  9: CreateAssignmentEvaluation = cb; break;
    case 10: CreatePlusExp = cb; break;
    case 11: CreateMinusExp = cb; break;
    case 12: CreateTimesExp = cb;
    case 13: CreateRealDivExp = cb;
    case 14: CreateIntDivExp = cb;
    case 15: CreateModExp = cb;
    case 16: CreateAndExp = cb;
    case 17: CreateOrExp = cb;
    case 18: CreateXorExp = cb;
    case 19: CreateNotExp = cb;
    case 20: CreateNoneExp = cb;
    case 21: CreateUnaryPlusExp = cb;
    case 22: CreateUnaryMinusExp = cb;
    case 23: CreateEvaluationImp = cb; break;
    case 24: CreateObjectReference = cb; break;
    case 25: CreateStructureReference = cb; break;
    case 26: CreateEqExp = cb; break;
    case 27: CreateNeExp = cb; break;
    case 28: CreateLtExp = cb; break;
    case 29: CreateLeExp = cb; break;
    case 30: CreateGtExp = cb; break;
    case 31: CreateGeExp = cb; break;
    case 32: CreateIndexed = cb; break;
    case 33: CreateRepetitionSlice = cb; break;
    case 34: CreatePatternVariableDecl = cb; break;
    case 35: CreateAlternative = cb; break;
    case 36: CreateCaseSelection = cb; break;
    case 37: AddAlternative = cb; break;
    case 38: AddSelection = cb; break;
    }
}
void install2beta1(int i, int (*cb)(int))
{
    switch(i) {
    case  1: CreateName = cb; break;
    case  2: CreateNameApl = cb; break;
    case  3: CreateRemote = cb; break;
    case  4: CreateSimpleDecl = cb; break;
    case  5: CreateVirtualDecl = cb; break;
    case  6: CreateInnerImp = cb; break;
    case  7: CreateIntegerConst = cb; break;
    case  8: CreateRealConst = cb; break;
    case  9: CreateObjectEvaluation = cb; break;
    case 10: CreateRepetitionDecl = cb; break;
    case 11: CreateSimpleIfImp = cb; break;
    case 12: CreateLeaveImp = cb; break;
    case 13: CreateRestartImp = cb; break;
    case 14: CreateLabelledImp = cb; break;
    case 15: CreateStringConst = cb; break;
    case 16: CreateThisObject = cb; break;
    case 17: CreateGeneralIfImp = cb; break;
    case 18: CreateComputedRemote = cb; break;
    }
}
void install2beta2(int i, int (*cb)(int, int))
{
    switch(i) {
    case 1: CreateFragment = cb; break;
    case 2: CreateSlot = cb; break;
    }
}
void install2beta3(int i, int (*cb)(int, int, int))
{
    switch(i) {
    }
}
/*
 * These do not strictly belong here - but I want to keep the
 * number of .c files small:
 */
static struct timeval start_time;
void set_start_time(void)
{
    struct timezone tz;
    gettimeofday(&start_time, &tz);
}
void print_usage(void)
{
    struct timeval end_time;
    struct timezone tz;
    struct rusage me;
    struct rusage child;
    double me_user, me_sys, child_user, child_sys, real, percent;

    getrusage(RUSAGE_SELF, &me);
    getrusage(RUSAGE_CHILDREN, &child);
    me_user = me.ru_utime.tv_sec + 0.000001*me.ru_utime.tv_usec;
    me_sys = me.ru_stime.tv_sec + 0.000001*me.ru_stime.tv_usec;
    child_user = child.ru_utime.tv_sec + 0.000001*child.ru_utime.tv_usec;
    child_sys = child.ru_stime.tv_sec + 0.000001*child.ru_stime.tv_usec;

    gettimeofday(&end_time, &tz);
    real = (end_time.tv_sec - start_time.tv_sec) +
	   0.000001 * (end_time.tv_usec - start_time.tv_usec);
    percent = 100.0;
    if(real > 0.0)
	percent = 100.0 * (me_user+me_sys+child_user+child_sys) / real;

    printf("CPU time: %.2f/%.2f (user/sys) for self, and %.2f/%.2f for C compiler/linker.\n", me_user, me_sys, child_user, child_sys);
    printf("That are %.1f%% of the %.2fs real elapsed time.\n", percent, real);
}

#define YYSTYPE int

	/*
	OptPrefix PAT_BEG Attributes EnterPart DoPartOrSlot ExitPart PAT_END
	    { $$ = (*CreateObjectDescriptor)($1, $3, $4, $5, $6); }
	*/
%}


/* Commands */

%token	PAT_BEG PAT_END PATTERNVAR ASSIGN CASE_SELECTION REFERENCE
%token	ENTER DO EXIT INNER LEAVE RESTART IF THEN ELSE FOR
%token	DIV MOD AND OR XOR NOT NONE THIS NE LE GE
%token	NAME INTEGER REAL STRING
%token	OBJECTDESCRIPTOR ATTRIBUTES DOPART
%token	FRAGMENT SLOT_BEG SLOT_END SLOT

/* precedence */
%left	ENTER
%left	SLOT_BEG

%left	';'
%left	','
%right	'='
%nonassoc Op
%left	'+' '-' OR
%left	'*' '/' AND
%right	NOT
%right	UMINUS
%left	'&'
%left	'.'
/* %left  	'[' ']'  */

%%

formpart:
	form_low { (*CreateFragment)($1, 0); }
	| formpart FRAGMENT aname ':' form_low
		{ (*CreateFragment)($5, $3); free((char *) $3); }
	;

form_low:
	OBJECTDESCRIPTOR FRAGMENT ObjectDescriptorNoSlot { $$ = 0; }
	| ATTRIBUTES FRAGMENT Attributes { $$ = 1; }
	| DOPART FRAGMENT DoPart { $$ = 2; }
	;

Empty:	{ (*PushNone)(); }			%prec ENTER
	;

ObjectSpecification:
	ObjectDescriptor
	| AttributeDenotation
	;

ObjectDescriptor:
	ObjectDescriptorNoSlot
	| SLOT_BEG SLOT aname ':' OBJECTDESCRIPTOR SLOT_END
	    { (*CreateSlot)(0, $3); free((char *) $3); }
	;

ObjectDescriptorNoSlot:
	OptPrefix PAT_BEG Attributes AttributeSlotOpt EnterPart DoPartOrSlot
		ExitPart PAT_END
		{ (*CreateObjectDescriptor)(); }
	| OptPrefix PAT_BEG Attributes DoSlot ExitPart PAT_END
	    /* { (*CreateObjectDescriptor)($1, $3, 0, $4, $5); } */
	    { (*CreateNoEnterObjectDescriptor)(); }
	;

OptPrefix:
	Empty
	| AttributeDenotation
	;

AttributeSlotOpt:
	Empty
	| AttributeSlot Attributes { (*AddAttribute)(); }
	;

AttributeSlot:
	SLOT_BEG SLOT aname ':' ATTRIBUTES SLOT_END
		{ (*CreateSlot)(1, $3); free((char *) $3); }
	;

Attributes:
	Empty
	| AttributeDecl
	| Attributes ';'
	| Attributes ';' AttributeDecl { (*AddAttribute)(); }
	;

AttributeDecl:
	Names ':' ObjectDescriptor { (*CreatePatternDecl)(); }
	| Names ':' '<' ObjectSpecification { (*CreateVirtualDecl)(0); }
	| Names ':' ':' '<' ObjectSpecification { (*CreateVirtualDecl)(1); }
	| Names ':' ':' ObjectSpecification { (*CreateVirtualDecl)(2); }
	| Names ':' ReferenceSpecification { (*CreateSimpleDecl)($3); }
	| Names ':' PATTERNVAR AttributeDenotation
		{ (*CreatePatternVariableDecl)(); }
	| Names ':' '[' Evaluation ']' ReferenceSpecification
		{ (*CreateRepetitionDecl)($6); }
	;

ReferenceSpecification:
	'@' ObjectSpecification { $$=0; }
	| '^' AttributeDenotation { $$=1; }
	;

/* end of declarations */

/* parts of a pattern (besides declarations): */
EnterPart:
	Empty
	| ENTER Evaluation
	;

DoPart:
	DO Imperatives
	;

DoSlot:
	SLOT_BEG SLOT aname ':' DOPART SLOT_END
	    { (*CreateSlot)(2, $3); free((char *) $3); }

DoPartOrSlot:
	Empty
	| DoPart
	| DoSlot
	;

ExitPart:
	Empty
	| EXIT Evaluation
	;

/* Imperatives */
Imperatives:
	Empty
	| Imperatives ';' Imperatives { (*AddImperative)(); }
	| Imperative
	;

Imperative:
	Evaluation { (*CreateEvaluationImp)(); }
	| InnerImp
	| SimpleIfImp
	| GeneralIfImp
	| LeaveImp
	| RestartImp
	| LabelledImp
	;

/* InnerImp, the INNER directive of a pattern */
InnerImp:
	INNER { (*CreateInnerImp)(0); }
	| INNER ANAME { (*CreateInnerImp)((int) yytext); }
	;

/* GeneralIfImp - compare an evaluation to one or more alternatives */
GeneralIfImp:
	'(' IF Evaluation Alternatives ElsePartOpt IF ')'
		{ (*CreateGeneralIfImp)($5); }
	;

Alternatives:
	Alternative
	| Alternatives Alternative { (*AddAlternative)(); }
	;

Alternative:
	Selections THEN Imperatives { (*CreateAlternative)(); }
	;

Selections:
	CASE_SELECTION Evaluation { (*CreateCaseSelection)(); }
	| Selections CASE_SELECTION Evaluation
	    { (*CreateCaseSelection)(); (*AddSelection)(); }
	;

/* SimpleIfImp - a yes/no decision */
SimpleIfImp:
	'(' IF Evaluation THEN Imperatives ElsePartOpt IF ')'
		{ (*CreateSimpleIfImp)($6); }
	;

/* LeaveImp - leave a labelled block */
LeaveImp:
	LEAVE ANAME { (*CreateLeaveImp)((int) yytext); }
	;

/* RestartImp - restart a labelled block */
RestartImp:
	RESTART ANAME { (*CreateRestartImp)((int) yytext); }
	;

/* LabelledImp - assign a label to an imperative */
LabelledImp:
	aname ':' Imperative; { (*CreateLabelledImp)($1); free((char *) $1); }
	;

ElsePartOpt:
	/* empty */ { $$=0; }
	| ELSE Imperatives { $$=1; }
	;

/* Evaluation, the most general expression */
Evaluation:
	Evaluation ASSIGN Transaction { (*CreateAssignmentEvaluation)(); }
	| Expression
	;

Expression:
	SimpleExp
	| SimpleExp '=' SimpleExp { (*CreateEqExp)(); }
	| SimpleExp NE  SimpleExp { (*CreateNeExp)(); }
	| SimpleExp '<' SimpleExp { (*CreateLtExp)(); }
	| SimpleExp LE  SimpleExp { (*CreateLeExp)(); }
	| SimpleExp '>' SimpleExp { (*CreateGtExp)(); }
	| SimpleExp GE  SimpleExp { (*CreateGeExp)(); }
	;

SimpleExp:
	Term
	| SimpleExp '+' Term { (*CreatePlusExp)(); }
	| SimpleExp '-' Term { (*CreateMinusExp)(); }
	| SimpleExp OR Term { (*CreateOrExp)(); }
	| SimpleExp XOR Term { (*CreateXorExp)(); }
	| '+' Term { (*CreateUnaryPlusExp)(); }
	| '-' Term { (*CreateUnaryMinusExp)(); }
	;

Term:
	Factor
	| Term '*' Factor { (*CreateTimesExp)(); }
	| Term '/' Factor { (*CreateRealDivExp)(); }
	| Term DIV Factor { (*CreateIntDivExp)(); }
	| Term MOD Factor { (*CreateModExp)(); }
	| Term AND Factor { (*CreateAndExp)(); }
	;

Factor:
	INTEGER { (*CreateIntegerConst)(atoi(yytext)); }
	| REAL { (*CreateRealConst)((int) yytext); }
	| STRING { (*CreateStringConst)((int) yytext); }
	| NONE { (*CreateNoneExp)(); }
	| NOT Factor { (*CreateNotExp)(); }
	| AttributeDenotation '[' Evaluation ':' Evaluation ']'
		{ (*CreateRepetitionSlice)(); }
	| Transaction
	;

Transaction:
	ObjectEvaluation
	| ObjectReference
	| StructureReference
	| EvalList { (*CreateEvalList)(); }
	;

EvalList: '(' Evaluations ')'
	;

Evaluations:
	Evaluation
	| Evaluations ',' Evaluation { (*AddEvaluation)(); }
	;

/*
 * This definition of ObjectReference is too broad.  It allows
 * to use an inserted ObjectDescriptor in a reference.  However,
 * I consider it more reasonable to test for this error condition
 * in the checker, not in the parser.
 */
ObjectReference:
	ObjectEvaluation REFERENCE { (*CreateObjectReference)(); }
	;

StructureReference:
	AttributeDenotation PATTERNVAR { (*CreateStructureReference)(); }
	;

ObjectEvaluation:
	ObjectSpecification { (*CreateObjectEvaluation)(0); }
	| '&' ObjectSpecification { (*CreateObjectEvaluation)(1); }
	/* dynamic creation of components not yet supported */
	;

Names:
	ANAME { (*CreateName)((int) yytext); }
	| Names ',' ANAME { (*CreateName)((int) yytext); (*AddName)(); }
	;

AttributeDenotation:
	aname { (*CreateNameApl)($1); free((char *) $1); }
	| AttributeDenotation '.' ANAME { (*CreateRemote)((int) yytext); }
	| EvalList '.' ANAME { (*CreateComputedRemote)((int)yytext); }
	| AttributeDenotation '[' Evaluation ']' { (*CreateIndexed)(); }
	| THIS '(' aname ')' { (*CreateThisObject)($3); free((char *) $3); }
	;

aname:	ANAME { $$ = (int) strdup(yytext); } ;
ANAME:	NAME | OBJECTDESCRIPTOR | ATTRIBUTES | DOPART | SLOT;

%%

#include "read.c"

#if 0
int parsefile(char *fn)
{
    int res;
    FILE *fp;

    fp = fopen(fn, "r");
    if(! fp)
	return -1;

    yyin = fp;
    res = yyparse();
    close(fp);

    return res;
}
#endif

int parsefile(FILE *fp, char *fn, int line)
{
    yyin = fp;
    thisfilename = fn;
    yylineno = line;
    return yyparse();
}
