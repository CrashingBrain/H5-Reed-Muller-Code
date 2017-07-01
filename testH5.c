#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*Basis vectors for H2*/
char* x[4];
/*Basis vectors for H3*/
char* y[5];
/*Basis vectors for H4*/
char* z[6];
/*Basis vectors for H5*/
char* w[7];

char* rowxor(char* a, const char* b);
char** build_codewords(char** base, int len);
char char_xor(const char a, const char b);
void init();

void init(){
	// printf("# INIT #\n");
	/*Basis vectors for H2*/
	x[0] = "0000";
	x[1] = "0011";
	x[2] = "0101";
	x[3] = "1111";

	/*Basis vectors for H3*/
	y[0] = "00000000";
	y[1] = "00001111";
	y[2] = "00110011";
	y[3] = "01010101";
	y[4] = "11111111";

	/*Basis vectors for H4*/
	z[0] = "0000000000000000";
	z[1] = "0000000011111111";
	z[2] = "0000111100001111";
	z[3] = "0011001100110011";
	z[4] = "0101010101010101"; 
	z[5] = "1111111111111111";

	/*Basis vectors for H5*/
	/* Build these from concatenations of the z basis vectors for H4 */
	size_t h5len = 2*strlen(z[5]);
	for (int i = 1; i < 6; ++i)
	{
		w[i+1] = malloc((h5len+1)*sizeof(char));
		strcpy(w[i+1], z[i]);
		strcat(w[i+1], z[i]);
	}
	w[0] = malloc((h5len+1)*sizeof(char));
	strcpy(w[0], z[0]);
	strcat(w[0], z[0]);
	w[1] = malloc((h5len+1)*sizeof(char));
	strcpy(w[1], z[0]);
	strcat(w[1], z[5]);

	// printf("# END INIT #\n");

}
/*
H5 codewords will be built up in the array cw from all combinations of the above w[0-6]. 
Note that the 6 "message bits" in an H5 codeword (reading from the left and starting at 1)
are at bit positions 1,2,4,8,16,32. The ordering of codewords in the cw array
might seem arbitrary but it owes much to Pascal's Triangle - which makes hand-checking easier -
See assignments to "cw" below.
*/
char** build_codewords(char** base, int len){
	int codedim = 1 << len; /* 2^dim */
	char** cw = (char**) malloc(codedim*sizeof(char*));
	int dimword = (1 << (len-1)) + 1; // length of each word of cw (+1 for '\0')

	/* This gives the firsts codewords, equals to the base vectors*/
	for (int i = 0; i < len; ++i)
	{
		cw[i] = (char*) malloc(dimword*sizeof(char));
		strcpy(cw[i], base[i]);
		printf("cw[%d]\t: %s\n", i, cw[i]);
	}
	/* This gives combinations of two basis vectors */
	int index = len;
	for (int i = 1; i < len; i++)
	{
		for (int j = i+1; j < len; ++j)
		{
			cw[index] = (char*) malloc(dimword*sizeof(char));
			strcpy(cw[index], cw[i]);
			cw[index] = rowxor(cw[index], cw[j]);
			printf("cw[%d]\t: %s\n", index, cw[index]);
			index++;
		}
	}

	return cw;
}

/* Utility function to 'compute' xor value for char-bit representation */
char char_xor(const char a, const char b){
	if ((a=='0' && b == '0') || (a == '1' && b == '1')) return '0';
	else return '1';
}

/* Bitwise xor on bit-strings */
/* a, b must be bitsrings of the same, non-zero, length */
/* Result is overritten in string a if successful */
/* otherwise a NULL pointer is returned */
char* rowxor(char* a, const char* b){
	int len = strlen(a);
	if ( strlen(b) == 0 || len != strlen(b)) return NULL;
	for (int i = 0; i < len; ++i)
	{
		a[i] = char_xor(a[i], b[i]);
	}
	return a;
}

int main(int argc, char const *argv[])
{
	printf("Welcome to the H5 (Reed-Muller) test suite\n" );
	
	init();
	printf("x[2] : %s\n", x[2]);
	printf("y[3] : %s\n", y[3]);
	printf("z[4] : %s\n", z[4]);
	printf("Printing base vectors... :\n");
	for (int i = 0; i < 7; ++i)
	{
		printf("%s\n", w[i]);
	}
	printf("Generating codewords...\n");
	char** cw = build_codewords(w, 7);


close:
	for (int i = 0; i < 7; ++i)
	{
		free(w[i]);
	}
	for (int i = 0; i < 64; ++i)
	{
		free(cw[i]);
	}
	return 0;
}