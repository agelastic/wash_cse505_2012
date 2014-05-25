# We are not really tracking dependencies because everything is small
# enough to recompile at will.

# change to a different ocamlc if you prefer (e.g., ocamlopt)
COMPILER=ocamlc

all: clean
	$(COMPILER) hw5.mli
	$(COMPILER) -vmthread -o hw5 threads.cma hw5.ml

clean:
	-rm *.cmo *.cmi hw5

