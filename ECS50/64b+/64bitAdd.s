.global _start

.data
num1:
    .long 5
    .long 10

num2:
    .long 15
    .long 20

.text
_start:

    movl num1, %edx

    #add lower bits
    movl num1+4, %eax
    addl num2+4, %eax

    #if there's a carry go to carry section
    jc carry

    #add upper bits
    addl num2, %edx
    jmp done

    #if carry, add upper bits and the carry
carry:
    addl num2, %edx
    addl $1, %edx

done:
    #random garbage
    movl %ecx, %ecx
