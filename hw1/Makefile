# We are not really tracking dependencies because everything is small
# enough to recompile at will.

# change to a different ocamlc if you prefer (e.g., ocamlopt)
COMPILER=ocamlc

all: clean
	$(COMPILER) -o trees trees.ml
	$(COMPILER) -c ast.ml
	ocamlyacc parse.mly
	$(COMPILER) -c parse.mli
	$(COMPILER) -c parse.ml
	ocamllex lex.mll
	$(COMPILER) -c lex.ml
	$(COMPILER) -c interp.ml
	$(COMPILER) -o interp ast.cmo parse.cmo lex.cmo interp.cmo # order matters

clean:
	-rm *.cmo *.cmi parse.ml parse.mli lex.ml interp trees
