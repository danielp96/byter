
MODULE=fetch
VC?=iverilog
VFLAGS?=-g2012


build: ${MODULE}.out

${MODULE}.out: ${MODULE}.v ${MODULE}_tb.v
	${VC} ${VFLAGS} $^ -o ${MODULE}.out

run: ${MODULE}.out
	./${MODULE}.out

clean:
	rm -vf ${MODULE}.out
