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
	$(COMPILER) -c main.ml
	$(COMPILER) -o hw3 ast.cmo parse.cmo lex.cmo main.cmo

clean:
	-rm *.cmo *.cmi parse.ml parse.mli lex.ml hw3
