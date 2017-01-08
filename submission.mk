.PRECIOUS: %.subm

%.subm: $(name).fls submission.mk
	awk '/INPUT .*\.$*/{print $$2}' $< | xargs readlink -ef | sort | uniq | grep -v "texlive" | sed -e "s~$$(pwd)/~~g" > $@

bb.subm:  png.subm submission.mk
	sed -e 's/png/bb/g' $< > $@

submission: en sty.subm png.subm pdf.subm bb.subm tex.subm bbl.subm
	bash -c "rsync --files-from=<(cat *.subm) . submission/"
	cd submission ; ../inline-tex $(name).tex
	find submission -name "*\.log" -delete
	find submission -name "*\.bbl" -delete
	find submission -type d -empty -exec rmdir {} \;
	ls submission
	cd submission ; pdflatex $(name).tex
	cd submission ; pdflatex $(name).tex
	cd submission ; pdflatex $(name).tex
	find submission -name "*\.log" -delete
	find submission -name "*\.bbl" -delete
	find submission -name "*\.aux" -delete
	find submission -name "*\.out" -delete

clean-submission:
	-rm -rf *.subm submission

archive: submission
	cd submission ; tar cvzf $(name).tar.gz * ; mv $(name).tar.gz ../
