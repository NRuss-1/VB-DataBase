.global _start


.data

string1:
  .string "Hello"


string2:
  .string "World"

s1_len:
  .long 5

s2_len:
  .long 5


.text

min:
  ret

swap:
  ret

#taken from examples folder, ask if this code can be used
strlen:
  movl $0, %esi # len = 0

	for_start:
		#str[len] != '\0'
		#str[len] -'\0' != 0
		#neg: str[len] -'\0' == 0
		#*(str + len) -'\0' == 0
		cmpb $0, (%ebx, %esi) #str[len] - '\0'
		jz for_end
		incl %esi
		jmp for_start
	for_end:
	ret

editDist:
  /*
  int word1_len = strlen(word1);
  int word2_len = strlen(word2);
  */
  movl string1, %ebx
  call strlen
  movl %esi, s1_len #store length of string 1

  movl string2, %ebx
  call strlen
  movl %esi, s2_len #store length of string 2


  /*
  int* oldDist = (int*)malloc((word2_len + 1) * sizeof(int));
  int* curDist = (int*)malloc((word2_len + 1) * sizeof(int));
  */

  #finish this

#first for loop
  /*
  for(i = 0; i < word2_len + 1; i++){
  oldDist[i] = i;
  curDist[i] = i;
  }
  */
  movl $0, %ecx #ecx = i
  start_for:
    #negation: i >= (word2_len + 1)
    #i - (word2_len + 1) >= 0
    movl s2_len, %esi
    incl %esi
    cmpl %esi, %ecx #i - (word2_len + 1)
    jge end_for


#code

    incl %ecx #++i
    jmp start_for
  end_for:



#second for loops
  movl $1, %ecx #ecx = i
  movl $1, %ebx #ebx = j
  #1st loop
  for_loop1:
    #negation: i >= (word1_len + 1)
    #i - (word1_len + 1) >= 0
    movl s1_len, %edi
    incl %edi
    cmpl %edi, %ecx #i - (word1_len + 1)
    jge end_for1

    #second loop
    for_loop2:
      #negation: j >= (word2_len + 1)
      #j - (word2_len + 1) >= 0
      cmpl %esi, %ebx #j - (word2_len + 1)
      jge end_for







      incl %ebx #++j
      jmp for_loop2
    end_for2:


    incl %ecx #++i
    jmp for_loop1
  end_for1:



  ret



#int main() part
_start:

  call editDist


done:
  nop
