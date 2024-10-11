%{
#include<bits/stdc++.h>
#include <map>
#include "project.tab.h"
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern char* yytext;

double result;
void yyerror(const char *s) {
    std::cerr << "Error: " << s << " at token: " << yytext << std::endl;
    
}

using namespace std;
ofstream outfile("output.txt");

int cd=0, csl=0, cid=0, cs=0, temp=0, cif=0, celif=0,celse=0,ci=0,cfor=0,c=0,cwhile=0,cF=0,cW=0,nfun=0,ni=0,nf=0,nc=0,nv=0,nfor=0,nwhile=0,nforin=0,cml=0,cfun=0,F=0,W=0,C=0,na=0,nii=0,nff=0,ncc=0,invalid=0,E=0,S=0;
string funname;
map<string, int> intVariables;
map<string, float> floatVariables;
map<string, char> charVariables;
map<string, float> constants;
set<string> stt;
set<string> sarr;
map<string, map<string, string>> func;
map<string, map<string, string>>::iterator it;
map<string, string>::iterator it2;
void funprint(const string& identifier)
{
int f =0;
string value;
    for (it = func.begin(); it != func.end(); ++it) {
        if(it->first == funname ){
            for (it2 = it->second.begin(); it2 != it->second.end(); ++it2) {
                if(it2->first == identifier)
                {
                f=1;
                    value = it2->second;
                    break;
                    
                }
               
            }
            if(f==1)
            {
                cout<<"Prints: "<<value<<endl;
            }
             else
                {
                    cout<<"Undeclared variable can't be handled"<<endl;
                }

        }
 }
}

void fundeclare(const string& identifier, float value)
{
int f =0;
float fl;
    for (it = func.begin(); it != func.end(); ++it) {
        if(it->first == funname){
        for (it2 = it->second.begin(); it2 != it->second.end(); ++it2) {
        if(it2->first == identifier)
        {
           f=1;
           
           break;
          
        }
        }
        if(f==1)
        {
            cout << "Statement Evaluates: " << identifier << " = " << value << endl;
            it2->second = to_string(value);
        }
        else
        {
        cout<<"Undeclared variable can't be handled"<<endl;
        }
        }
    }
     
}
float funval(const string& identifier)
{
int f =0;
string value;
float fl;
    for (it = func.begin(); it != func.end(); ++it) {
        if(it->first == funname ){
            for (it2 = it->second.begin(); it2 != it->second.end(); ++it2) {
                if(it2->first == identifier)
                {
                   f=1;
                    value = it2->second;
                    fl= stof(value);
                    break;
                }
                
            }
             if(f==1)
        {
           return fl;
        }
        else
        {
        cout<<"Undeclared variable can't be handled"<<endl;
        }
        }
 }
  return -11111111.0;
 }

 float funret(const string& identifier)
{
int f =0;
string value;
float fl;
    for (it = func.begin(); it != func.end(); ++it) {
        if(it->first == funname ){
            for (it2 = it->second.begin(); it2 != it->second.end(); ++it2) {
                if(it2->first == identifier)
                {
                   f=1;
                    value = it2->second;
                    break;
                }
                else
                {
                    cout<<"Undeclared variable can't be handled"<<endl;
                }
            }
             if(f==1)
        {
        
           size_t found = value.find('.');

    if (found != string::npos) {
        if(ni==1)
        {
        fl=stof(value);
        return fl;
        }
        else
        {
        cout<<"The return variable type and the function type doesn't match!"<<endl;
        return -11111111.0;
        }
        
    } else {
        if(nf==1)
        {
        fl=stof(value);
        return fl;
        }
        else
        {
        cout<<"The return variable type and the function type doesn't match!"<<endl;
        }
    }
        }
        else
        {
        cout<<"Undeclared variable can't be handled"<<endl;
        return -11111111.0;
        }
        }
 }
  return -11111111.0;
 }

void declareIntVariable(const string& identifier, int value) {
    if (intVariables.find(identifier) == intVariables.end() && floatVariables.find(identifier) == floatVariables.end() && charVariables.find(identifier) == charVariables.end()) {
        intVariables[identifier] = value;
        cout << "Integer variable: " << identifier << " is declared and the value is " << value << endl;
    } else {
        cout << "Error: Duplicate variable: " << identifier << " can't be used " << endl;
    }
}

void declareFloatVariable(const string& identifier, float value) {
    if (intVariables.find(identifier) == intVariables.end() && floatVariables.find(identifier) == floatVariables.end() && charVariables.find(identifier) == charVariables.end()) {
        floatVariables[identifier] = value;
        cout << "Float variable: " << identifier << " is declared and the value is " << value << endl;
    } else {
        cout << "Error: Duplicate variable: " << identifier << " can't be used " << endl;
    }
}

void declareCharVariable(const string& identifier, char value) {
    if (intVariables.find(identifier) == intVariables.end() && floatVariables.find(identifier) == floatVariables.end() && charVariables.find(identifier) == charVariables.end()) {
        charVariables[identifier] = 0;
        cout << "Char variable: " << identifier << " is declared and the value is " << value << endl;
    } else {
        cout << "Error: Duplicate variable: " << identifier << " can't be used " << endl;
    }
}

void declareFloatConstant(const string& identifier, float value) {
    if (constants.find(identifier) == constants.end()) {
        constants[identifier] = value;
        cout << "Float Constant: " << identifier << " is declared and the value is " << value << endl;
    } else {
        cout << "Error: Duplicate constant: " << identifier << " can't be used " << endl;
    }
}

void declareIntConstant(const string& identifier, int value) {
    if (constants.find(identifier) == constants.end()) {
        constants[identifier] = value;
        cout << "Integer Constant: " << identifier << " is declared and the value is " << value << endl;
    } else {
        cout << "Error: Duplicate constant: " << identifier << " can't be used " << endl;
    }
}
%}

%union {
    char* str;
    double floatValue;
    int intValue;
    char charValue;
    struct DirectiveAndComment {
        char* directive;
        char* comment;
    } dirAndCom;
}

%token <str> DIRECTIVE INVALID_DIRECTIVE SINGLECOM VOID DOUBLE INT FLOAT CHAR ID CONSTANT CONST FUNC_NAME ARR
%token <dirAndCom> DIR_AND_COM INVALID_DIR_AND_COM
%token <floatValue> FLOATVAL
%token <intValue> INTVAL
%token <charValue> CHARVAL 
%token COLON EQUAL SPACE GT LT EQ GE LE NE AND OR NOT PRINTS FUNC MAIN MAINEND IF IFF ELSE  ELIF NEWLINE INC DEC WHILEEND WHILE FOR FOREND IN DOT FUNCEND NILL RETURN multi_com
%nonassoc STT
%nonassoc ST
%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc kom
%nonassoc beshi
%type <floatValue> stmt1
%type <floatValue> code
%type <str> single_com
%type <floatValue> expression
%type <floatValue> exp
%type <str> t

%%
start: /* empty */
	| start code
	;
code: DIRECTIVE {cd++; cout << "Valid Directive: " << $1 << endl; }
    | INVALID_DIRECTIVE {cid++; cout << "Invalid Directive: " << $1 << endl; }
    | single_com
    | DIR_AND_COM {cd++, csl++; cout << "Valid Directive: " << $1.directive << ", Valid Comment: " << $1.comment << endl; }
    | INVALID_DIR_AND_COM {cid++, csl++; cout << "Invalid Directive: " << $1.directive << ", Valid Comment: " << $1.comment << endl; }
    | main_function NEWLINE
    | function {nfun=0,cfun++;}
    | NEWLINE
	;
main_function: FUNC MAIN NEWLINE all MAINEND { cout << "Main Function has executed properly"<<endl; }
	;


all: declaration NEWLINE all 
    | NEWLINE 
    | 
    ;
all2: declaration2 NEWLINE all2 
    | NEWLINE 
    | 
    ;
declaration2: for %prec beshi {cout<<"*****Nested for*****"<<endl<<endl; F++;}
	|while %prec beshi {cout<<"*****Nested for*****"<<endl<<endl; F++;}
	| declaration %prec kom
	;
allwhile: declarationwhile NEWLINE allwhile 
    | NEWLINE 
    | 
    ;
declarationwhile: for %prec beshi {cout<<"*****Nested while*****"<<endl<<endl; W++;}
	|while %prec beshi {cout<<"*****Nested while*****"<<endl<<endl; W++;}
	| declaration %prec kom
	;
allif: declarationif NEWLINE allif 
    | NEWLINE 
    | 
    ;
declarationif: if %prec beshi {cout<<"*****Nested if*****"<<endl<<endl; C++;}
	| declaration %prec kom
	;

declaration:NEWLINE
	| variable {cout<<endl;}
    | constant {cout<<endl;}
    | invalid_constant  {cout<<endl;}
    | stmt_eval {cout<<endl;}
    | print {cout<<endl;}
    | if {ci=0; cout<<endl;}
    | single_com {cout<<endl;}
    | expression {E++; cout<<"This expression evaluates: "<<$1<<endl<<endl; }
    | incdec {cout<<endl;}
    | for {cF=0;cout<<endl;}
    | while {cW=0; cout<<endl;}
    | function {nfun=0;cfun++; cout<<endl;}
    | multi_com {cml++;cout<<"Multiline Comment"<<endl<<endl;}
    | array { invalid=0; nii=0,nff=0,ncc=0; cout<<endl;}
    ;
incdec: indec1 COLON {S++;}
	| indec1 COLON single_com {S++;}
	;
indec1: indec_list
	| indec_list indec1
	;
indec_list: INC ID {if (intVariables.find($2) == intVariables.end() && floatVariables.find($2) == floatVariables.end()) {
                   c=0;
        cout << "Identifier : " <<$2 << " is not declared!" << endl;
    } else {
    c=1;
    if (intVariables.find($2) != intVariables.end()) {
        intVariables[$2] = intVariables[$2]+1;
        cout << "Statement Evaluates: " << intVariables[$2] << endl;
    } else if (floatVariables.find($2) != floatVariables.end()) {
        floatVariables[$2] = floatVariables[$2]+1;
        cout << "Statement Evaluates: " << floatVariables[$2] << endl;
    }
   
    }
    }
	| DEC ID {if (intVariables.find($2) == intVariables.end() && floatVariables.find($2) == floatVariables.end()) {
	   c=0;
        cout << "Identifier : " <<$2 << " is not declared!" << endl;
    } else {
    c=1;
    if (intVariables.find($2) != intVariables.end()) {
        intVariables[$2] = intVariables[$2]-1;
        cout << "Statement Evaluates: " << intVariables[$2] << endl;
    } else if (floatVariables.find($2) != floatVariables.end()) {
        floatVariables[$2] = floatVariables[$2]-1;
        cout << "Statement Evaluates: " << floatVariables[$2] << endl;
    }
   
    }}

expression: exp AND expression { $$ = $1 && $3 ;}
	| exp OR expression { $$ = $1 || $3 ;}
	| NOT exp { $$ = !$2 ;}
	| exp { $$ = $1 ;}
	;
exp: exp GT exp { $$ = $1 > $3 ;}
	| exp LT exp { $$ = $1 < $3 ;}
	| exp EQ exp { $$ = $1 == $3 ;}
	| exp NE exp { $$ = $1 != $3 ;}
	| exp LE exp { $$ = $1 <= $3 ;}
	| exp GE exp { $$ = $1 >= $3 ;}
	| ID {
	   if(nfun>=1)
	   {
          $$=funval($1);
	   }
	   else{
	   if (intVariables.find($1) != intVariables.end()) {
        $$ = intVariables[$1];
        
    } else if (floatVariables.find($1) != floatVariables.end()) {
        $$ = floatVariables[$1];
        
    } else if (constants.find($1) != constants.end()) {
        $$ = constants[$1];
        
    } else {
        cout << "Unassigned variable: " << $1 << " can't be used as the evaluation of a statement" << endl;
        
    }
    }
    }
	| INTVAL { $$ = $1; }
	;
array: array1 COLON {S++;}
	| array1 COLON single_com {S++;}
	;
array1: t ARR ar  { if(invalid==1)
                     {cout<<"Type of array is conflicting!"<<endl;}
                     else{
                  if (sarr.find($2) == sarr.end())
                   {sarr.insert($2);
                   if(nff==1)
                   cout<<"Float type array"<<endl;
                   else if(nii==1)
                   {
                   cout<<"Integer type array"<<endl;
                   }
                   else
                   {
                   cout<<"Character type array"<<endl;
                   }}
                   else
                   {
                   cout<<"Duplicate name of array can't be used"<<endl;
                   }
                   }
                   }
	;

t: FLOAT {nff=1; }
	| INT {nii=1; }
	| CHAR {ncc=1;}
	;
ar: '{' '}'
	| '{' '}' EQUAL arr_list
	;
arr_list: '(' rec ')'
	;
rec: rec1 %prec beshi
	|rec2 %prec kom
	| rec3 
	;
rec1: rec1 ',' INTVAL { if(nii==0) invalid=1;}
	| INTVAL {  if(nii==0) invalid=1;}
	;
rec2: rec2 ',' FLOATVAL { if(nff==0) invalid=1;}
	| FLOATVAL { if(nff==0) invalid=1;}
	;
rec3: rec3 ',' CHARVAL {if(ncc==0) invalid=1;}
	| CHARVAL {if(ncc==0) invalid=1;}
	;	
function: type FUNC FUNC_NAME '{' parameter '}' NEWLINE all return NEWLINE FUNCEND {
     nfun=0;
     ni=0;
     nf=0;
     nc=0;
     nv=0;
     if(stt.find($3) == stt.end())
     {
     cout<<"Valid function with the unique name "<<$3 <<endl;
     stt.insert($3);
     
     funname=$3;
     }
     else
     {
     cout<<"Invalid function_name :" << $3 <<" is declared as the name has been already used as a function name!"<<endl;
     }
     } 

     ;
type: INT {ni=1; nfun++;}
	| FLOAT {nf=1; nfun++;}
	| CHAR {nc=1; nfun++;}
	| VOID {nv=1; nfun++;}
	;
parameter: parameter ',' ID {func[funname][$3]="0";}
	| ID {func[funname][$1]="0";}
	;
return: ret COLON 
	| ret COLON single_com
	;
ret: RETURN ID {
    float result = funret($2); 
    if(result != -11111111.0) {
        cout << "This function returns the value: " << result << endl;
    }
}

	| RETURN NILL { if(nv==1) cout<<"Function returns the value: NULL"<<endl; else {cout<<"The return variable type and the function type doesn't match!"<<endl;}}
	;
for: FOR '{' A expression COLON B '}' NEWLINE all2 FOREND { nfor++;
    cout << "For loop is properly declared" << endl;
    if ($4 != 0) {
        cout << "It has a valid condition. So the loop will be Executed" << endl;
    } else {
        cout << "It has an invalid condition. So the loop will not be Executed" << endl;
    }
} 

	| FOR ID IN INTVAL DOT INTVAL NEWLINE all FOREND { nforin++; intVariables[$2] = $4;
                                                        if(($6 - $4)>1) {
                                                        cout<< "Valid For In Loop has been declared!"<<endl;
                                                        cout<<"Loop will be executed "<< $6 - $4 <<" times"<<endl;
                                                        }
                                                        else{
                                                        cout<<"For In loop has invalid condition.so it will not be executed"<<endl;
                                                        }}
	| FOR ID IN FLOATVAL DOT INTVAL NEWLINE all FOREND { cout<< "Invalid For In Loop has been declared!"<<endl;
	                                                     cout<<"Float value can not be assigned as range!"<<endl;}
    ;

A: variable
	| stmt_eval
	;
B: incdec { cout<<"Valid increment or decrement"<<endl; }
	| ID EQUAL ID '+' INTVAL COLON {
	                            if(intVariables.find($1) != intVariables.end() && $1 == $3)
	                            {
	                            cout<<"Valid increment"<<endl;
	                            }
	                            else{
	                            cout<<"Invalid increment"<<endl;
	                            }
	}
	| ID EQUAL ID '-' INTVAL COLON{
	if(intVariables.find($1) != intVariables.end() && $1 == $3)
	                            {
	                            cout<<"Valid decrement"<<endl;
	                            }
	                            else{
	                            cout<<"Invalid decrement"<<endl;
	                            }
	}
	| ID EQUAL ID '*' INTVAL COLON {if(intVariables.find($1) != intVariables.end() && $1 == $3)
	                            {
	                            cout<<"Valid increment"<<endl;
	                            }
	                            else{
	                            cout<<"Invalid increment"<<endl;
	                            }}
	| ID EQUAL ID '/' INTVAL COLON { if (intVariables.find($1) != intVariables.end() && $1 == $3)
	                            {
	                                cout << "Valid decrement" << endl;
	                            }
	                            else
	                            {
	                                cout << "Invalid decrement" << endl;
	                            }
	                        }

	;
while : WHILE '{' expression COLON '}' NEWLINE allwhile WHILEEND { nwhile++;
    cout << "While loop declared" << endl;
    if ($3 != 0) {
        cout << "Loop has a valid condition" << endl;
    } else {
        cout << "Invalid loop condition!!" << endl;
    }
    if (c == 1) {
        cout << "Proper increment-decrement statement" << endl;
    } else {
        cout << "Loop doesn't have a proper increment-decrement statement. So the loop will not be Executed" << endl;
        c = 0;
    }
}
	;
if: IF '{' expression '}' NEWLINE allif ELIF '{' expression '}' NEWLINE allif ELSE NEWLINE allif IFF {
cout << "The valid block containing IF-ELSE-IF is declared properly" << endl;
    if($3 != 0)
    {
        cout<<"IF block will be executed"<<endl;
    }
    else if($9 != 0)
    {
        cout<<"ELIF block will be executed"<<endl;
    }
    else
    {
       cout<<"ELSE block will be executed"<<endl;
    }
    
        
   
    ci++;
    celif++;
}
	| IF '{' expression '}' NEWLINE allif ELSE NEWLINE allif IFF { cout << "The valid block containing IF-ELSE is declared properly" << endl;
	if($3 != 0)
    {
        cout<<"IF block will be executed"<<endl;
    }
    else
    {
       cout<<"ELSE block will be executed"<<endl;
    }

	
    
    ci++;
    celse++;
}
	| IF '{' expression '}' NEWLINE allif IFF { cout << "The valid block containing IF-ELSE is declared properly" << endl;
	if($3 != 0)
    {
        cout<<"IF block will be executed"<<endl;
    }
    else
    {
        cout<<"IF block will be executed"<<endl;
    }
	
    ci++;
    cif++;
};

single_com: SINGLECOM {csl++; cout << "Valid Comment: " << $1 << endl;}
	;

print: PRINTS print1 COLON {S++;}
	| PRINTS print1 COLON single_com {S++;}
	;
print1: print_list
	| print_list ',' print1
	;
print_list: ID {
    if (nfun >= 1) {
        funprint($1);
    } else {
        if (intVariables.find($1) == intVariables.end() && floatVariables.find($1) == floatVariables.end()) {
            cout << "The identifier : " << $1 << " is not declared!" << endl;
        } else {
            if (intVariables.find($1) != intVariables.end()) {
                cout << "The Value of " << $1 << " is :" << intVariables[$1] << endl;
            } else if (floatVariables.find($1) != floatVariables.end()) {
                cout << "The Value of " << $1 << " is :" << floatVariables[$1] << endl;
            }
        }
    }
}

	;
stmt_eval: stmt_eval1 COLON {S++;}
	| stmt_eval1 COLON single_com {S++;}
	;
stmt_eval1: stmt_eval_list
	| stmt_eval_list ',' stmt_eval1
	;


stmt_eval_list: ID EQUAL stmt1 { 
    if(nfun>=1)
    {
      if(temp == 0)
      {
         fundeclare($1,$3);
      }
      else
      {
      temp=0;
      }
    }
    else{
    if (intVariables.find($1) == intVariables.end() && floatVariables.find($1) == floatVariables.end()) {
        cout << "The identifier : " <<$1 << " is not declared!" << endl;
    } else {
    if( temp == 0 ){
    if (intVariables.find($1) != intVariables.end()) {
        intVariables[$1] = $3;
    } else if (floatVariables.find($1) != floatVariables.end()) {
        floatVariables[$1] = $3;
    }

        cout << "This Statement Evaluates: " << $1 << " = " << $3 << endl;
    }
    else
    {
    temp = 0 ;
    }
    }
    }
}
	| ID EQUAL expression { 
	if(nfun>=1)
    {
      if(temp == 0)
      {
         fundeclare($1,$3);
      }
      else
      {
      temp=0;
      }
    }
    else{
	if (intVariables.find($1) == intVariables.end() && floatVariables.find($1) == floatVariables.end()) {
        cout << "The identifier : " <<$1 << " is not declared!" << endl;
    } else {
    if( temp == 0 ){
    if (intVariables.find($1) != intVariables.end()) {
        intVariables[$1] = $3;
    } else if (floatVariables.find($1) != floatVariables.end()) {
        floatVariables[$1] = $3;
    }

        cout << "This Statement Evaluates: " << $1 << " = " << $3 << endl;
    }
    else
    {
    temp = 0 ;
    }
    }
	}
	}
	;


constant: const COLON {S++;}
	| const COLON single_com {S++;}
	;
variable: var COLON 
	| var COLON single_com
	; 
invalid_constant: CONSTANT EQUAL FLOATVAL COLON {cout<<"Invalid as Constant Values Can't be Changed"<<endl;}
	| CONSTANT EQUAL FLOATVAL COLON single_com {cout<<"Invalid as Constant Values Can't be Changed"<<endl;}
	| CONSTANT EQUAL INTVAL COLON {cout<<"Invalid as Constant Values Can't be Changed"<<endl;}
	| CONSTANT EQUAL INTVAL COLON single_com {cout<<"Invalid as Constant Values Can't be Changed"<<endl;}
	;

const: const_list
	| const_list ',' const
	;
var: var_list %prec STT
	| var_list  ',' var %prec ST 
	;
stmt1:stmt1 '+' stmt1  { $$ = $1 + $3; result = $$; }
    | stmt1 '-' stmt1 { $$ = $1 - $3; result = $$; }
    | stmt1 '*' stmt1 { $$ = $1 * $3; result = $$; }
    | stmt1 '/' stmt1 { $$ = $1 / $3; result = $$; }
    | '(' stmt1 ')' { $$ = $2; result = $$;}
    | INTVAL { $$ = $1; result = $$;}
    | ID { 
    if(nfun>=1)
    {
      
       $$ = funval($1);
      
    }
    else{
    if (intVariables.find($1) != intVariables.end()) {
        $$ = intVariables[$1];
        result = $$;
    } else if (floatVariables.find($1) != floatVariables.end()) {
        $$ = floatVariables[$1];
        result = $$;
    } else if (constants.find($1) != constants.end()) {
        $$ = constants[$1];
        result = $$;
    } else {
        cout << "Unassigned variable: " << $1 << " can't be used as the evaluation of a statement" << endl;
        temp = 1;
        result = $$;
    }
    }
}
	;




const_list: CONST CONSTANT EQUAL FLOATVAL { declareFloatConstant($2, $4); }
	| CONST CONSTANT EQUAL INTVAL { declareIntConstant($2, $4); }
	;


var_list: INT expi
	| FLOAT expf
    | CHAR expc
   	;

expi: ID EQUAL ID '+' INTVAL {
     if (intVariables.find($3) != intVariables.end()) {
        declareIntVariable($1, intVariables[$3] + $5);
    } else {
        cout << "Error: Undeclared integer variable used: " << $3 << endl;
    }}
	| ID EQUAL ID '-' INTVAL {
     if (intVariables.find($3) != intVariables.end()) {
        declareIntVariable($1, intVariables[$3] - $5);
    } else {
        cout << "Error: Undeclared integer variable used: " << $3 << endl;
    }}
	| ID EQUAL ID '*' INTVAL {
     if (intVariables.find($3) != intVariables.end()) {
        declareIntVariable($1, intVariables[$3] * $5);
    } else {
        cout << "Error: Undeclared integer variable used: " << $3 << endl;
    }}
	| ID EQUAL ID '/' INTVAL {
     if (intVariables.find($3) != intVariables.end()) {
        declareIntVariable($1, intVariables[$3] / $5);
    } else {
        cout << "Error: Undeclared integer variable used: " << $3 << endl;
    }}
	| ID EQUAL ID '%' INTVAL {
     if (intVariables.find($3) != intVariables.end()) {
        declareIntVariable($1, intVariables[$3] % $5);
    } else {
        cout << "Error: Undeclared integer variable used: " << $3 << endl;
    }}
	| ID EQUAL ID '^' INTVAL {
     if (intVariables.find($3) != intVariables.end()) {
        declareIntVariable($1, pow(intVariables[$3], $5));
    } else {
        cout << "Error: Undeclared integer variable used: " << $3 << endl;
    }}
	| ID EQUAL INTVAL {
        declareIntVariable($1, $3);
    }
    | ID EQUAL expression {
        declareIntVariable($1, (int)$3);
    }
	| ID {
        declareIntVariable($1, 0);
    }
    ;
expf: ID EQUAL ID '+' FLOATVAL {
    if (floatVariables.find($3) != floatVariables.end()) {
        declareFloatVariable($1, floatVariables[$3] + $5);
    } else {
        cout << "Error: Undeclared float variable used: " << $3 << endl;
        
    }}
 	| ID EQUAL ID '-' FLOATVAL {
     if (floatVariables.find($3) != floatVariables.end()) {
        declareFloatVariable($1, floatVariables[$3] - $5);
    } else {
        cout << "Error: Undeclared float variable used: " << $3 << endl;
    }}
    | ID EQUAL ID '*' FLOATVAL {
     if (floatVariables.find($3) != floatVariables.end()) {
        declareFloatVariable($1, floatVariables[$3] * $5);
    } else {
        cout << "Error: Undeclared float variable used: " << $3 << endl;
    }}
    | ID EQUAL ID '/' FLOATVAL {
     if (floatVariables.find($3) != floatVariables.end()) {
        declareFloatVariable($1, floatVariables[$3] / $5);
    } else {
        cout << "Error: Undeclared float variable used: " << $3 << endl;
    }}
    | ID EQUAL ID '^' FLOATVAL {
     if (floatVariables.find($3) != floatVariables.end()) {
        declareFloatVariable($1, pow(floatVariables[$3], $5));
    } else {
        cout << "Error: Undeclared float variable used: " << $3 << endl;
    }}
	| ID EQUAL FLOATVAL {
    declareFloatVariable($1, $3);}
    | ID {declareFloatVariable($1,0)}
    | ID EQUAL exp {
        declareFloatVariable($1, $3);
    }
    ;
expc: ID EQUAL ID '+' INTVAL {
    if (charVariables.find($3) != charVariables.end()) {
        declareCharVariable($1, charVariables[$3] + $5);
    } else {
        cout << "Error: Undeclared char variable used: " << $3 << endl;
        
    }}
	|ID EQUAL CHARVAL {
    declareCharVariable($1, $3);}
 	|ID {declareCharVariable($1, 0);}
    ;

end: MAINEND NEWLINE {cout<<"main ends here!"<<endl;}
    | MAINEND {cout<<"main ends here!"<<endl;}
    ;

%%

int main()
{
    
    freopen("input49.txt", "r", stdin);
    freopen("output49.txt", "w", stdout);    yyparse();
    cout<<endl<<endl;
    cout<<"Number of Valid Satements: "<<S<<endl;
    cout<<"Number of Valid Directives: "<<cd<<endl;
    cout<<"Number of Invalid Directives: "<<cid<<endl;
    cout<<"Number of Valid Single Line Comment: "<<csl<<endl;
    cout<<"Number of Valid Multi Line Comment: "<<cml<<endl;
    cout<<"Number of Valid Integer Variables: "<<intVariables.size()<<endl;
    cout<<"Number of Valid Float Variables: "<<floatVariables.size()<<endl;
    cout<<"Number of Valid Character Variables: "<<charVariables.size()<<endl;
    cout<<"Number of Valid Constants: "<<constants.size()<<endl;
    cout<<"Number of Valid Expressions: "<<E<<endl;
    cout<<"Number of block containing if-elif-else : "<<celif<<endl;
    cout<<"Number of block containing if-else : "<<celse<<endl;
    cout<<"Number of block containing only if : "<<cif<<endl;
    cout<<"Number of valid for loop : "<<nfor<<endl;
    cout<<"Number of valid while loop : "<<nwhile<<endl;
    cout<<"Number of nested for loop : "<<F<<endl;
    cout<<"Number of nested while loop : "<<W<<endl;
    cout<<"Number of nested condition : "<<C<<endl;
    cout<<"Number of valid function : "<<cfun<<endl;
    cout<<"Number of valid array : "<<sarr.size()<<endl;
    intVariables.clear();
    floatVariables.clear();
    return 0;
}