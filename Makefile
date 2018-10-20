
latex-dependencies: lex.yy.c Makefile
	gcc -O3 -o latex-dependencies lex.yy.c -ll

lex.yy.c: latex-dependencies.l Makefile
	flex latex-dependencies.l

clean:
	rm -f lex.yy.c latex-dependencies
