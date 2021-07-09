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
