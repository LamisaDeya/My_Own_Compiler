%{
#include <bits/stdc++.h>
using namespace std;
#include "project.tab.h"
extern YYSTYPE yylval;
extern char* yytext;
int yylex();
struct DirectiveAndComment {
    char* directive;
    char* comment;
};
char* strndup(const char* str, size_t n) {
    char* result = (char*)malloc(n + 1);
    if (result != NULL) {
        strncpy(result, str, n);
        result[n] = '\0';
    }
    return result;
}
%}

%option noyywrap
%option yylineno noinput nounput

delim   [ \t]
white   {delim}+





%%
: {return COLON;}
-as {return EQUAL;}
-pl {return '+';}
-mn {return '-';}
-mul {return '*';}
-div {return '/';}
-exp {return '^';}
-mod {return '%';}
-gt { return GT; }
-lt { return LT; }
-eq { return EQ; }
-ge { return GE; }
-le { return LE; }
-ne { return NE; }
-and { return AND; }
-or { return OR; }
-not { return NOT; }
-inc { return INC; }
-dec { return DEC; }
-in { return IN; }
\.\.\. {return DOT;}
FUNC { return FUNC; }
FUNCEND { return FUNCEND; }
RETURN { return RETURN; }
![a-z_]+ { yylval.str = strdup(yytext); return FUNC_NAME; }
MAIN { return MAIN; }
MAINEND { return MAINEND; } 
FOR { return FOR; }
FOREND { return FOREND; } 
WHILE { return WHILE; }
WHILEEND { return WHILEEND; } 
PRINTS { return PRINTS; }
IF { return IF; }
IFF { return IFF; }
ELIF { return ELIF; }
ELSE { return ELSE; }
NILL {return NILL; }
RETURN {return RETURN; }
~(.|\n)+~ {return multi_com;}
[(){},]     { return *yytext; }
$[a-z_]+ {yylval.str = strdup(yytext); return ID;}
\?[A-Z_] {yylval.str = strdup(yytext); return CONSTANT;}
[+-]?[0-9]+ { yylval.intValue = atoi(yytext); return INTVAL; }
\*[a-z_]+ {yylval.str = strdup(yytext); return ARR;}
[+-]?[0-9]+(\.[0-9]+)? { yylval.floatValue = atof(yytext); return FLOATVAL; }
'[a-z]' {yylval.charValue=yytext[1]; return CHARVAL; }
IF {yylval.str = strdup(yytext); return IF;}
ELIF {yylval.str = strdup(yytext); return ELIF;}
ELSE {yylval.str = strdup(yytext); return ELSE;}
INT {yylval.str = strdup(yytext); return INT;}
FLOAT {yylval.str = strdup(yytext); return FLOAT;}
CHAR {yylval.str = strdup(yytext); return CHAR;}
DOUBLE {yylval.str = strdup(yytext); return DOUBLE;}
VOID {yylval.str = strdup(yytext); return VOID;}
CONST {yylval.str = strdup(yytext); return CONST;}
``.* { yylval.str = strdup(yytext); return SINGLECOM; }
^includes[ ]+.*\.h([ ]*``.*)?|(defines[ ]+[$][A-Z][ ]+[+-]?[0-9]+(\.[0-9]+)?\*)([ ]*``.*)? {
    int directive_length = 0;
    int ch = 0;
    for (int i = 0; i < strlen(yytext) - 1; i++) {
        if (yytext[i] == '`' && yytext[i + 1] == '`') {
            ch = 1;
            break;
        }
        directive_length++;
    }

    if (ch == 0) {
        yylval.str = strdup(yytext);
        return DIRECTIVE;
    } else {
        yylval.dirAndCom.directive = strndup(yytext, directive_length);
        yylval.dirAndCom.comment = strdup(yytext + directive_length + 2);  // Skip the '`' characters
        return DIR_AND_COM;
    }
}


^includes.*|defines.* { int directive_length = 0;
    int ch = 0;
    for (int i = 0; i < strlen(yytext) - 1; i++) {
        if (yytext[i] == '`' && yytext[i + 1] == '`') {
            ch = 1;
            break;
        }
        directive_length++;
    }

    if (ch == 0) {
        yylval.str = strdup(yytext);
        return INVALID_DIRECTIVE;
    } else {
        yylval.dirAndCom.directive = strndup(yytext, directive_length);
        yylval.dirAndCom.comment = strdup(yytext + directive_length + 2);  // Skip the '`' characters
        return INVALID_DIR_AND_COM;
    }; 
    }

"\n"    { return NEWLINE; }
{white} {}
.       { cerr << "Error: Unexpected input at line " << yylineno << ": " << yytext << endl;  }
%%

