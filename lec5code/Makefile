# exactly like the code for homework 1 except we also have a 
# pseudo-denotational semantics in denote.ml and executable denote

# We are not really tracking dependencies because everything is small
# enough to recompile at will.

# change to a different ocamlc if you prefer (e.g., ocamlopt)
COMPILER=ocamlc

all: clean
	$(COMPILER) -c ast.ml
	ocamlyacc parse.mly
	$(COMPILER) -c parse.mli
	$(COMPILER) -c parse.ml
	ocamllex lex.mll
	$(COMPILER) -c lex.ml
	$(COMPILER) -c interp.ml
	$(COMPILER) -o interp ast.cmo parse.cmo lex.cmo interp.cmo # order matters
	$(COMPILER) -c denote.ml
	$(COMPILER) -o denote ast.cmo parse.cmo lex.cmo denote.cmo # order matters

clean:
	-rm *.cmo *.cmi parse.ml parse.mli lex.ml denote interp
