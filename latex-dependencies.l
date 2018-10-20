%{
//
// cat root.tex | ./latex-dependencies
//
char *input_fn = NULL;
%}
%x INPUT
%%
"%"..*$ {}
"\\input{" {BEGIN INPUT;}
<INPUT>[^\}]+ {input_fn = strdup(yytext);}
<INPUT>"}" {
	if (input_fn != NULL){
		yyin = fopen( input_fn, "r" );
		printf("%s\n",input_fn);
		free(input_fn);
		input_fn = NULL;
		if ( ! yyin ) {fprintf (stderr,"cannot open %s\n",input_fn);}
		yypush_buffer_state(yy_create_buffer( yyin, YY_BUF_SIZE ));
	}
	BEGIN INITIAL;}
 
<<EOF>> {
	yypop_buffer_state();

	if ( !YY_CURRENT_BUFFER ){
		yyterminate();
	}}
"\n" |
. {}

%%
