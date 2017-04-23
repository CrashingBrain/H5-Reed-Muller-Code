# This is a simple AWK script to progressively develop H5 
# - the Reed-Muller code used on the Mariner 9 mission
# The script does not read in any data. Get the effects you
# want by un-commenting the appropriate sections. Run it via:
#	awk -f testH5.awk | less
# Remember to hit the <RETURN> key twice to see your output on screen
# Note: this script is for testing out ideas and for generating lists 
# of codewords. A brute-force decoder *is* included but at ~ 1ms per codeword test, 
# it soon gets impossibly expensive e.g. ~ 15 mins for a 700 X 832 grayscale bitmap
# A transliteration to something more efficient (e.g. C) is needed for serious work.

BEGIN { print "Welcome to the H5 (Reed-Muller) test suite\n";

	}

{ 
# basis vectors for H2
x0 = "0000"; x1 = "0011"; x2 = "0101"; x3 = "1111"
#basis vectors for H3
y0 = "00000000"; y1 = "00001111"; y3 = "00110011"; y2 = "01010101"; y4 = "11111111";
# basis vectors for H4
z0 = "0000000000000000"; z1 = "0000000011111111"; z2 = "0000111100001111"; z3 = "0011001100110011"; z4 = "0101010101010101"; 
z5 = "1111111111111111";
# Basis vectors for H5. Build these from concatenations of the z basis vectors for H4
w0 = conc(z0, z0); w1 = conc(z0,z5); w2 = conc(z1, z1); w3 = conc(z2, z2); 
w4 = conc(z3,z3); w5 = conc(z4,z4); w6 = conc(z5,z5);
#
# H5 codewords will be built up in the array cw from all combinations of the above w[0-6]. 
# Note that the 6 "message bits" in an H5 codeword (reading from the left and starting at 1)
# are at bit positions 1,2,4,8,16,32. The ordering of codewords in the cw array
# might seem arbitrary but it owes much to Pascal's Triangle - which makes hand-checking easier -
# See assignments to "cw" below.
# The integer array "map". that now follows. points at elements in the cw array and reorders 
# them so as to impose an ascending order of 6-bit message values i.e. increasing grayscale vals.. 
# Hence, map[0] leads to msg bits of "000000", map[31]  to msg bits of "011111" and map[63] 
# delivers a msg of "111111" - and so on.
#
map[0] = 0; map[1] = 1;  map[2] = 7; map[3] = 2; map[4] = 12; map[5] = 22; map[6] = 8; map[7] = 3;
map[8] = 16; map[9] = 26; map[10] = 42; map[11] = 32; map[12] =13; map[13] = 23; map[14] = 9; map[15] = 4;  
map[16] = 19; map[17] = 29; map[18] = 45; map[19] = 35; map[20] = 52; map[21] = 57; map[22] = 48; map[23] = 38;  
map[24] = 17; map[25] = 27; map[26] = 43; map[27] = 33; map[28] = 14; map[29] = 24; map[30] = 10; map[31] = 5;
map[32] = 21; map[33] = 31; map[34] = 47; map[35] = 37; map[36] = 54; map[37] = 59; map[38] = 50; map[39] = 40;
map[40] = 56; map[41] = 61; map[42] = 63; map[43] = 62; map[44] = 55; map[45] = 60; map[46] = 51; map[47] = 41;
map[48] = 20; map[49] = 30; map[50] = 46; map[51] = 36; map[52] = 53; map[53] = 58; map[54] = 49; map[55] = 39;
map[56] = 18; map[57] = 28; map[58] = 44; map[59] = 34; map[60] = 15; map[61] = 25; map[62] = 11; map[63] = 6;
#
#Building up the H5 (Reed-Muller) codewords
#
#Single vectors that form the basis set
cw[0] = w0; cw[1] = w1; cw[2] = w2; cw[3] = w3; cw[4] = w4; cw[5] = w5; cw[6] = w6;
# combinations of two basis vectors
cw[7] = rowxor(w1, w2)
cw[8] = rowxor(w1, w3)
cw[9] = rowxor(w1, w4)
cw[10] = rowxor(w1, w5)
cw[11] = rowxor(w1, w6)
cw[12] = rowxor(w2, w3)
cw[13] = rowxor(w2, w4)
cw[14] = rowxor(w2, w5)
cw[15] = rowxor(w2, w6)
cw[16] = rowxor(w3, w4)
cw[17] = rowxor(w3, w5)
cw[18] = rowxor(w3, w6)
cw[19] = rowxor(w4, w5)
cw[20] = rowxor(w4, w6)
cw[21] = rowxor(w5, w6)
# combs of 3 basis vectors
cw[22] = rowxor(cw[7], w3) # triples starting 12
cw[23] = rowxor(cw[7], w4)
cw[24] = rowxor(cw[7], w5)
cw[25] = rowxor(cw[7], w6)
cw[26] = rowxor(cw[8], w4)# triples starting 13
cw[27] = rowxor(cw[8], w5)
cw[28] = rowxor(cw[8], w6)
cw[29] = rowxor(cw[9], w5)# triples starting 14
cw[30] = rowxor(cw[9], w6)
cw[31] = rowxor(cw[10], w6)# 156
cw[32] = rowxor(cw[12], w4) # triples starting 23
cw[33] = rowxor(cw[12], w5) 
cw[34] = rowxor(cw[12], w6) 
cw[35] = rowxor(cw[13], w5) # triples starting 24
cw[36] = rowxor(cw[13], w6) 
cw[37] = rowxor(cw[14], w6) # triples starting 25 
cw[38] = rowxor(cw[16], w5) # triples starting 34 
cw[39] = rowxor(cw[16], w6)  
cw[40] = rowxor(cw[17], w6) #356  
cw[41] = rowxor(cw[19], w6) #456  
# combs of 4 basis vectors
cw[42] = rowxor(cw[22], w4)# quads starting 123
cw[43] = rowxor(cw[22], w5)
cw[44] = rowxor(cw[22], w6)
cw[45] = rowxor(cw[23], w5)# quads starting 124
cw[46] = rowxor(cw[23], w6)
cw[47] = rowxor(cw[24], w6)#  1256
cw[48] = rowxor(cw[26], w5) # quads starting 134
cw[49] = rowxor(cw[26], w6)
cw[50] = rowxor(cw[27], w6) #1356
cw[51] = rowxor(cw[29], w6) # 1456 
cw[52] = rowxor(cw[32], w5) # quads starting 234 
cw[53] = rowxor(cw[32], w6) # 
cw[54] = rowxor(cw[33], w6) # 2356 
cw[55] = rowxor(cw[35], w6) # 2456 
cw[56] = rowxor(cw[38], w6) # 3456 
# quintets and the final sextet
cw[57] = rowxor(cw[42], w5) # 12345 
cw[58] = rowxor(cw[42], w6) # 12346 
cw[59] = rowxor(cw[43], w6) # 12356 
cw[60] = rowxor(cw[45], w6) # 12456 
cw[61] = rowxor(cw[48], w6) # 13456 
cw[62] = rowxor(cw[52], w6) # 23456 
cw[63] = rowxor(cw[57], w6) #123456
#
# print out codewords in "Pascal Triangle" order
for (k = 0; k <= 63; k++) print cw[k];
#
print ("\nHere are the H5 codewords in ascending order of message bit values \n\n");
for (j = 0; j <= 63; j++) print cw[map[j]];
# And here's a test printout to verify that message-bit values are OK and range from 0-63
print "\n Here are the 64 gray values contained in msg bits at posns 1, 2, 4, 8, 16, 32\n"
for (j = 0; j <= 63; j++) print msgval(cw[map[j]]);
#
# Declare a few  test  messages
test63 = "11111111111111111111111111111111"
test15 = "00110011001100110011001100110011" #roughly at pos15
test48 = "11001100110011001100110011001100" # roughly at 48 no damage
newtest48 = "10001100100111001100000011000100" # roughly at 48 but 5 bits damaged
test0 =    "00000000000000000000000000000000" #zero vector undamaged
newtest0 = "00100001000110000001000010000001" #zero vector but damaged in 7 places
random =   "10111001010001101000110001010100" # random string of 0s and 1s 
#for (m = 0; m <= 63; m++) print " m =" m  "    dist = " norm(rowxor(cw[map[m]], newtest48))

x = codematch(test15, 0);  
x = codematch(newtest48, 0);  
print "\n Show every stage of brute-force testing for test vector distance 8 from grayshade 44\n" 
x = codematch(random, 1);  
# Test print of the codeword norms
print ("\n here are the norms in order\n\n");
for (k = 0; k <= 63; k++) print norm(cw[map[k]]);

exit




}	#end of H5 program

# Various utility functions

function conc (m, n) { return m n }

# the function below is not needed on Linux awk - 
# where xor seems to be built in
#
function xor (a, b){
# primitive xor on single char zeroes and ones
if ((a=="0" && b == "0") || (a == 1 && b == 1))
return "0"
else return "1"
}

function rowxor (a, b) {
# bitwise xor on bit-strings
# a, b must be bitsrings of the same, non-zero, length
s = ""; len1=length(a); len2 = length(b);
if (len1 != len2) { print "string lengths unequal\n"; exit }
nbits = split(a, arr1, ""); split(b, arr2, ""); 
for(i = 1; i <= len1; i++) {res[i] = xor(arr1[i],arr2[i]); s = s res[i] }
return s
}

function norm (a) {
# counts number of 1s in a bit-string
nbits = split(a, arr, ""); cnt = 0; 
for (j = 0; j<=nbits; j++) if (arr[j] == 1) cnt++;
return cnt
}

function msgval (m) {
# weighted addition of bit vals at posns 1,2,4,8,16,32
# to give a message/grayscale value in range 0-63
split(m, arm,  ""); 
return (32*arm[1] + 16*arm[2] + 8*arm[4] + 4* arm[8] + 2*arm[16] + arm[32])
}


function codematch (testcode, flag)  {
# finds the Hamming distance of testcode from each of the codewords in H5
# referenced via the map array. Returns position of best match i.e. smallest distance
# if "flag" is set to 0 then default behaviour is to report map position with smallest 
# distance. A flag value of 1 is for diagnostic printout of all distances. 
pos = 0; bestdist = 32;
for (d = 0; d <= 63; d++)  { dist =  norm(rowxor(cw[map[d]], testcode)); 
				if (dist < bestdist) {bestdist = dist; pos = d; }
			    if (flag == 1) print "grayscale = " d "  dist =  " dist 
			    else  if (bestdist == 0) break; #leave loop early if match found and flag == 0 
} 
print "Input vector is   " testcode "    \nBest match is     " cw[map[pos]] "   at  posn/grayscale =   "  pos "  , dist =   "  bestdist 
return bestdist
}

END	{ print "\nEnd of run \n"}