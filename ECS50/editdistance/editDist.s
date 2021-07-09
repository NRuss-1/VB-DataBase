.global _start


.data

string1:
  .space 101

string2:
  .space 101

s1_len:
  .long 5

s2_len:
  .long 5

oldDist:
	.space 404

curDist:
	.space 404

tempArr:
	.space 404

storemin:
	.long 0


.text

min:
#eax/ edx
  #negation if (num1-num2>=0) return num2
  if2:

  	cmpl %edx, %eax
    jge else2
    movl %eax, storemin
    jmp else2_end

  else2:

  	movl %edx, storemin

  else2_end:

	ret


swap:
#esi = oldDist/a /edi=curDist/b
	#temp
  movl $0, %edx #i = 0
  movl s2_len, %eax
  incl %eax
  for_temp_start:
		cmpl %eax, %edx
    jge end_for_start
    movl oldDist(,%edx, 4), %edi
    movl %edi, tempArr(,%edx,4)
   	incl %edx
    jmp for_temp_start
  end_for_start:

  movl $0, %edx #i = 0
  for_a_b:
  	cmpl %eax, %edx
  	jge end_for_a_b
  	movl curDist(,%edx, 4), %edi
    movl %edi, oldDist(,%edx,4)

    incl %edx
    jmp for_a_b
  end_for_a_b:

  movl $0, %edx #i = 0
  for_b_temp:
  	cmpl %eax, %edx
    jge end_for_b_temp
  	movl tempArr(,%edx, 4), %edi
    movl %edi, curDist(,%edx,4)

    incl %edx
    jmp for_b_temp
  end_for_b_temp:

  ret

#taken from examples folder, ask if this code can be used
strlen1:
  movl $0, %esi # len = 0

	for_start_str1:
		#str[len] != '\0'
		#str[len] -'\0' != 0
		#neg: str[len] -'\0' == 0
		#*(str + len) -'\0' == 0
		cmpb $0, string1(,%esi) #str[len] - '\0'
		jz for_end_str1
		incl %esi
		jmp for_start_str1
	for_end_str1:
	ret

strlen2:
  movl $0, %esi # len = 0

	for_start_str2:
		#str[len] != '\0'
		#str[len] -'\0' != 0
		#neg: str[len] -'\0' == 0
		#*(str + len) -'\0' == 0
		cmpb $0, string2(,%esi) #str[len] - '\0'
		jz for_end_str2
		incl %esi
		jmp for_start_str2
	for_end_str2:
	ret

editDist:


  /*
  int word1_len = strlen(word1);
  int word2_len = strlen(word2);
  */
  call strlen1
  movl %esi, s1_len #store length of string 1


  call strlen2
  movl %esi, s2_len #store length of string 2


  /*
  int* oldDist = (int*)malloc((word2_len + 1) * sizeof(int));
  int* curDist = (int*)malloc((word2_len + 1) * sizeof(int));
  */



#first for loop
  /*
  for(i = 0; i < word2_len + 1; i++){
  oldDist[i] = i;
  curDist[i] = i;
  }
  */
  movl $0, %ecx #ecx = i                                            #negation: i >= (word2_len + 1)
  start_for:														#i - (word2_len + 1) >= 0
    movl s2_len, %esi
    incl %esi
    cmpl %esi, %ecx #i - (word2_len + 1)
    jge end_for
    movl %ecx, oldDist(, %ecx, 4)     #oldDist[i] = i
    movl %ecx, curDist(, %ecx, 4)
    incl %ecx #++i
    jmp start_for
  end_for:



#second for loops
  movl $1, %ecx #ecx = i
  movl $1, %ebx #ebx = j
  #1st loop
  for_loop1:                         #negation: i >= (word1_len + 1)
    movl s1_len, %edi			     #i - (word1_len + 1) >= 0
    incl %edi
    cmpl %edi, %ecx                  #i - (word1_len + 1)
    jge end_for1
		movl %ecx, curDist
    #second loop
    for_loop2:
      #negation: j >= (word2_len + 1)
      #j - (word2_len + 1) >= 0
      movl s2_len, %esi
    	incl %esi
      cmpl %esi, %ebx #j - (word2_len + 1)x
      jge end_for2
      movb string1-1*1(,%ecx), %ah								#string1[i-1]= *(string1 + i -1)
      movb string2-1*1(,%ebx), %al
																#string2[j-1] = *(string2+j-1)
      if1:
      	cmpb %ah, %al
        jnz else

      #curDist[j] = oldDist[j - 1];

      	movl oldDist - 1*4(, %ecx, 4), %eax                          #open: edx, eax, esi, edi
        movl %eax, curDist(,%ecx)                    #closed: ecx, ebx
        jmp end_else

      else:
      	movl oldDist(,%ebx,4), %eax
        movl curDist - 1*4(, %ebx, 4), %edx              #eax/edx get passed to min
        call min

        movl storemin, %eax #
        movl oldDist -1*4(, %ebx, 4), %edx         #eax/edx get passed to min
        call min

        movl storemin, %eax
        incl %eax

        movl %eax, curDist(,%ebx,4)


      end_else:

      incl %ebx #++j
      jmp for_loop2

    end_for2:
    #swap goes here
    #decide variables here
   call swap

    incl %ecx #++i
    jmp for_loop1
  end_for1:

	#dist = oldDist[word2_len]s2_len, %ebx
  movl $0, %eax
  movl s2_len, %ebx
  movl oldDist(,%ebx,4), %eax

  ret



#int main() part
_start:

  call editDist


done:
  nop
