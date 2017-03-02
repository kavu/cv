export PATH := $(PATH):/Library/TeX/texbin

CLASSES_PATH = classes
CLASSES      = $(CLASSES_PATH)/moderncv.cls

STYLES_PATH  = styles
STYLES       = $(STYLES_PATH)/moderncvthemecasual.sty $(STYLES_PATH)/moderncvcompatibility.sty

BIBS         = publications.bib
PHOTO        = photo.jpg

LATEXMK  = -gg -silent -pdf -bibtex
PDFLATEX = -halt-on-error -file-line-error -recorder -interaction=errorstopmode -synctex=1

TARGETS = cv.pdf resume.pdf

# couldn't fix the `references itself (eventually)' warning
TEXINPUTS = .:$(STYLES_PATH):$(CLASSES_PATH):$$TEXINPUTS

.PHONY: all

all: $(TARGETS)

clean:
	-rm *.aux *.fls *.fdb_latexmk *.log *.out *.synctex.gz *.pdf

*.tex: $(CLASSES) $(STYLES) $(BIBS) $(PHOTO)

%.pdf: %.tex
	TEXINPUTS=$(TEXINPUTS) latexmk $(LATEXMK) -pdflatex='pdflatex $(PDFLATEX) %S %O' $<
