
name       = asai
reference  = $(wildcard *.bib)
emacs 	   = emacs
latexmk    = latexmk/latexmk.pl
styles     = abbrev.sty aaai_my.sty
tables     = $(addsuffix .tex,$(basename $(wildcard tables/*.org)))
sources    = main.tex $(wildcard [0-9]-*.tex) $(addsuffix /main.tex,$(wildcard chap[0-9])) $(tables)
$(info $(sources))

max_pages   = 50

upload     = ~/Dropbox/FukunagaLabShare/OngoingWorks/Asai/

ncpu       = $(shell grep "processor" /proc/cpuinfo | wc -l)

get-archive = wget -O- $(1) | tar xz ; mv $(2) $(3)

.SUFFIXES: .tex .org .el .elc .svg
.SECONDARY: compile-csv-org.elc compile-main-org.elc __tmp1 __tmp2
.PHONY: all en ja open imgs clean allclean check_pages check_overflow en_pdf ja_pdf automake submission archive clean-submission

all: check_pages check_overflow

check_pages: en
	-./check_pages.sh $(max_pages) $(name)

$(name).log $(name).fls: $(name).pdf

check_overflow: $(name).log
	-./check_overflow.sh $(name).log

en:	$(name).pdf $(sources)

%.pdf: %.tex $(name).tex imgs $(sources) $(styles) $(reference)
	$(latexmk) -pdf \
		   -latexoption="-halt-on-error -shell-escape" \
		   -bibtex \
		   $<
	mkdir -p $(upload)/$(notdir $(PWD))/
	cp $@ $(upload)/$(notdir $(PWD))/$(shell hostname)-$*.pdf

chap%/main.tex:
	$(MAKE) -C $(dir $@)

auto:
	+./make-periodically.sh

imgs:
	$(MAKE) -C img

%.csv: %.csvorg compile-csv-org.elc
	$(emacs) --batch --quick --script compile-csv-org.elc --eval "(progn (load-file \"compile-csv-org.el\")(compile-org \"$<\" \"$@\"))"

img/%.tex: %.gnuplot %.csv
	gnuplot $<

img/%.svg: %.gnuplot %.csv
	gnuplot $<

version = 8.3.4
org-mode:
	$(call get-archive, http://orgmode.org/org-$(version).tar.gz, org-$(version), $@)
	$(MAKE) -C $@ compile

%.tex: %.org compile-main-org.elc
	$(emacs) --batch --quick \
		 --script compile-main-org.elc \
		 --eval "(compile-org \"$<\" \"$(notdir $@)\")"

%.elc : %.el
	$(emacs) -Q --batch -f batch-byte-compile $<

clean: clean-submission
	-rm *~ *.aux *.dvi *.log *.toc *.bbl \
		*.blg *.utf8 *.elc $(name).pdf \
		*.fdb_latexmk __* *.fls
	-rm -r sources

allclean: clean
	$(MAKE) -C img clean

include submission.mk
