GRAMMAR_DIR=grammar
MAIN_CLASS=Main

all:
#compile and run Java code
	javac $(MAIN_CLASS).java 
	java $(MAIN_CLASS)

clean:
#clean Java bytecode
	rm $(GRAMMAR_DIR)/*.class *.class 
	rm -rf docs

document:
#generate documentation based on comment lines
	mkdir docs
	javadoc -d docs $(GRAMMAR_DIR)/*.java $(MAIN_CLASS).java

debug:
#debug Java code using CLI
	javac -g $(MAIN_CLASS).java 
	jdb $(MAIN_CLASS)