COFFEE=src/interlude.coffee
DIST=dist
JS=${DIST}/interlude.js

TITLE="// A safe setInterval Alternative"
ATTRIBUTION="// Written by Luke Morton and Richard Willis, MIT licensed."

all: js

coffee: ${COFFEE}

js: coffee
	@@echo -n "Compiling coffee..."
	@@echo ${TITLE} > ${JS}
	@@echo ${ATTRIBUTION} >> ${JS}
	@@coffee -p ${COFFEE} >> ${JS}
	@@echo " done."

$PHONY: all coffee js