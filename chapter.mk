
all: main.tex

main.tex: $(sort $(wildcard [0-9]*.tex))
	parallel echo '\\input{{}}' > $@ ::: $^
