<<<<<<< Updated upstream
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
  
oldDist:
	.space 404 #ask him in OH about arrays
  
curDist:
	.space 404

tempArr:
	.space 404
  
storemin:
	.long 0


.text

min:
#eax/ edx
  #negation if (num1-num2>0) return num2
  if2:
  
  	cmpl %eax, %edx
    jle else2
    movl %edx, storemin
     
  else2:
  
  	movl %eax, storemin
    
	ret
  
  
swap:
#esi = oldDist/a /edi=curDist/b   #ask about deep copy in OH 
	#temp
  movl $0, %edx #i = 0
  movl s2_len, %eax
  incl %eax
  for_temp_start:
		cmpl %eax, %edx
    jge end_for_start
    movl oldDist(,%edx, 4), %ebx
    movl %ebx, tempArr(,%edx,4)
   	incl %edx
  end_for_start:
  
  movl $0, %edx #i = 0
  for_a_b:
  	cmpl %eax, %edx
  	jge end_for_start
  	movl curDist(,%edx, 4), %ebx
    movl %ebx, oldDist(,%edx,4)
    
    incl %edx
  end_for_a_b:
  
  movl $0, %edx #i = 0
  for_b_temp:
  	cmpl %eax, %edx
    jge end_for_start
  	movl tempArr(,%edx, 4), %ebx
    movl %ebx, curDist(,%edx,4)
    
    incl %edx
  end_for_b_temp:
  
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
		movl %ecx, oldDist
    #second loop
    for_loop2:
      #negation: j >= (word2_len + 1)
      #j - (word2_len + 1) >= 0
      movl s2_len, %esi
    	incl %esi
      cmpl %esi, %ebx #j - (word2_len + 1)x	
      jge end_for
      movb string1-1*1(,%ecx), %ah								#string1[i-1]= *(string1 + i -1)                    
      movb string2-1*1(,%ebx), %al  
																#string2[j-1] = *(string2+j-1)                                       
      if1: 
      	cmpb %ah, %al
        jnz else
      
      #curDist[j] = oldDist[j - 1]; 
       
      	movl curDist(%ebx), %eax                          #open: edx, eax, esi, edi 
        movl %eax, oldDist - 1*4(, %ecx)                    #closed: ecx, ebx
        jmp end_else    
        
      else:
      	movl oldDist(%ebx), %eax
        movl curDist - 1*4(, %ebx), %edx              #eax/edx get passed to min
        call min
        
        movl storemin, %eax #
        movl oldDist -1*4(, %ebx), %edx         #eax/edx get passed to min
        call min 
        
        movl storemin, %eax 
        incl %eax
     	
        movl %eax, curDist(,%ebx)

      
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
  movl s2_len, %ebx
  movl oldDist(,%eax), %eax

  ret



#int main() part
_start:

  call editDist


done:
  nop
=======
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

storemin:
  .long 0

.text

swap:
  #edx (olddist), edi (curdist), esi(temp)
  movl %edx, %esi     #store old dist in temp
  movl %edi, edx      #store curdist in olddist
  movl %esi, %edi     #store olddist(temp) in curdist

ret

min:
#negation if (num1-num2>0) return num2
if2:

  cmpl %eax, %esi
  jle else2
  movl %esi, storemin
  jmp else2end

else2:

  movl %eax, storemin

else2end:

ret

strlen:
  movl $0, %esi # len = 0

	for_start:
		cmpb $0, (%ebx, %esi) #str[len] - '\0'
		jz for_end
		incl %esi
		jmp for_start
	for_end:
	ret


editdist:
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

#FREE: all registers
#TAKEN: 0 registers


movl oldDist, %edx    #store olddist in edx
movl curDist, %edi    #store curdist in edi

#FREE: eax, ebx, ecx, esi
#TAKEN: edx, edi


#first for loop
movl $0, %ecx #ecx = i
movl s2_len, %esi
incl %esi
first_for_start:
  cmpl %esi, %ecx #i - (word2_len + 1)
  jge end_for

  movl %ecx,(%edx, %ecx, 4)     #oldDist[i] = i
  movl %ecx, (%edi, %ecx, 4)     #curDist[i] = i

  incl %ecx #++i
  jmp start_for
first_for_end:

#FREE: eax, ebx, ecx, esi
#TAKEN: edx, edi

#multi for loop
movl $1, %ecx #ecx = i
movl $1, %ebx #ebx = j
#FREE: eax,
#TAKEN: edx, edi, ecx, ebx, esi

multi_for_start1:
  movl s1_len, %esi
  incl %esi
  cmpl %esi, %ecx
  jge multi_for_end1

  movl %ecx, %edi    #curDist[0] = i;

  multi_for_start2:
    movl s2_len, %esi
    incl %esi
    cmpl %esi, %ebx
    jge multi_for_end2

    #if(word1[i-1] == word2[j-1])
    movb string1 - 1(,%ecx), ah
    movb string2 - 1(,%ebx), al
    if1:
      cmpb $ah, $al
      jnz else

      #curDist[j] = oldDist[j - 1]
      movl -1 * 4(%edx, %ebx), (%edi, %ebx, 4)

      jmp end_else1

    else1:
      curDist[j] = min(min(oldDist[j], curDist[j-1]), oldDist[j-1]) + 1;
      movl (%edx, %ebx, 4), %eax
      movl -1 * 4(%edi, %ebx), %esi
      call min

      movl storemin, %eax
      movl -1 * 4(%edx, %ebx), %esi
      call min

      movl storemin, %eax
      incl %eax

      movl %eax, (%edi, %ebx, 4)

    end_else1:

    incl %ebx #++j
    jmp multi_for_start2
  multi_for_end2:

  call swap

  incl %ecx #++i
  jmp multi_for_start1
multi_for_end1:

movl $0, %eax
movl s2_len, %esi
#check if right pointer
movl (%edx, %esi, 4), %eax

ret

#int main() part
_start:

  call editDist


done:
  nop
>>>>>>> Stashed changes
