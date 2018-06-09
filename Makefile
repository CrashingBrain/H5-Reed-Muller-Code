testH5:
	mkdir -p build
	gcc testH5.c -o build/testH5

haskell:
	mkdir -p buildHS
	ghc testH5.hs -o buildHS/testH5

all:
	make testH5
	make haskell

clean:
	rm -r build/*
	rm -r buildHS/*