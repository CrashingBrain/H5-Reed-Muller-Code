#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*Basis vectors for H2*/
char* x0 = "0000";
char* x1 = "0011";
char* x2 = "0101";
char* x3 = "1111";

/*Basis vectors for H3*/
char* y0 = "00000000";
char* y1 = "00001111";
char* y3 = "00110011";
char* y2 = "01010101";
char* y4 = "11111111";

/*Basis vectors for H4*/
char* z0 = "0000000000000000";
char* z1 = "0000000011111111";
char* z2 = "0000111100001111";
char* z3 = "0011001100110011";
char* z4 = "0101010101010101"; 
char* z5 = "1111111111111111";

int main(int argc, char const *argv[])
{
	printf("Welcome to the H5 (Reed-Muller) test suite\n" );
	return 0;
}