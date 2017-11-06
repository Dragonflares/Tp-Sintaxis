%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "parser.h"
  int lex_errs = 0;
%}
ID						{LETRA}({LETRA_O_DIGITO})*
CONSTANTE				{DIGITO}+
LETRA_O_DIGITO			{LETRA}|{DIGITO}
LETRA 					[a-zA-Z]
DIGITO 					[0-9]
ASIGNACION				":="
COMENTARIO 				"//".*
ERRORCOMUN				[[:punct:]]{-}[(),;*/+-]
ERRORID					{ID}{ERRORCOMUN}({ID}|{CONSTANTE}|{ERRORCOMUN})*
ERRORCONSTANTE			{CONSTANTE}({LETRA_O_DIGITO})+
%%
"inicio"					{ yylval = strdup(yytext); return (inicio) ;}
"fin"						{ yylval = strdup(yytext); return (fin) ;}
"leer"						{ yylval = strdup(yytext); return (leer) ;}
"escribir"					{ yylval = strdup(yytext); return (escribir) ;}
[(]							{ yylval = strdup(yytext); return '(' ;}
[)]							{ yylval = strdup(yytext); return ')' ;}
[,]							{ yylval = strdup(yytext); return ',' ;}
[;]							{ yylval = strdup(yytext); return ';' ;}
[+]							{ yylval = strdup(yytext); return '+' ;}
[-]							{ yylval = strdup(yytext); return '-' ;}
[*]							{ yylval = strdup(yytext); return '*' ;}
[/]							{ yylval = strdup(yytext); return '/' ;}
{ID}						{ yylval = strdup(yytext); return (ID) ;}
{CONSTANTE}					{ yylval = strdup(yytext); return (CONSTANTE); }
{ASIGNACION}				{ yylval = strdup(yytext); return (ASIGNACION) ;}
{COMENTARIO}				{};
{ERRORCOMUN}				++lex_errs, printf("Linea #%d: Error léxico: cadena desconocida\n",yylineno);
{ERRORID}					++lex_errs, printf("Linea #%d: Error léxico: identificador inválido\n",yylineno);
{ERRORCONSTANTE}			++lex_errs, printf("Linea #%d: Error léxico: constante con sufijo inválido\n",yylineno);
\n 							{ };
%%