COFFEE=src/interlude.coffee
DIST=dist

all: js

coffee: ${COFFEE}

js: coffee
	@@echo -n "Compiling coffee..."
	@@coffee -c -o ${DIST} ${COFFEE}
	@@echo " done."

$PHONY: all coffee js