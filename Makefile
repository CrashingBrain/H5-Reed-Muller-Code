testH5:
	mkdir -p build
	gcc testH5.c -o build/testH5

haskell:
	mkdir -p buildHS
	ghc -c testH5.hs -odir buildHS -o buildHS/testH5

all:
	make testH5
	make haskell

clean:
	rm -R build/*
	rm -R buildHS/*