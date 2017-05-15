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

void init(){
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

	for (int i = 1; i < 6; ++i)
	{
		w[i+1] = malloc(2*strlen(z[5])*sizeof(char));
		strcpy(w[i+1], z[i]);
		strcat(w[i+1], z[i]);
	}
	w[0] = malloc(2*strlen(z[5])*sizeof(char));
	strcpy(w[0], z[0]);
	strcat(w[0], z[0]);
	w[1] = malloc(2*strlen(z[5])*sizeof(char));
	strcpy(w[1], z[0]);
	strcat(w[1], z[1]);

}

char** build_codewords(char** base, int dim){
	int codedim = 1 << dim; /* 2^dim */
	char* result = (char*) malloc(codedim*sizeof(char));

	for (int i = 0; i < dim; ++i)
	{
		strcpy(result[i], base[i]);

	}

	return result;
}

int main(int argc, char const *argv[])
{
	printf("Welcome to the H5 (Reed-Muller) test suite\n" );
	
	init();
	printf("%s\n", x[2]);
	printf("%s\n", y[3]);
	printf("%s\n", z[4]);
	printf("%s\n", w[5]);
	printf("%d\n", strlen(w[5]));


	return 0;
}