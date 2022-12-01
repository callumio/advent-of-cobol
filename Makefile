CO=cobc
COFLAGS=-x -O -o bin/
year = 2022

%: %.cbl
	$(CO) $^ $(COFLAGS)current

clean:
	rm -rf bin/ &>/dev/null 
