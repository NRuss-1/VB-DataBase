.global knapsack
.equ ws, 4
.text


max_fnc: # add registers here later
    maxif:
        cmpl %b, %a
        jbe maxelse

        movl %a, dest
        jmp maxifend
    
    maxelse: 
        movl %b, dest
    
    maxifend:

    ret 



knapsack:
    .equ num_locals, 2
    .equ num_regs, 1
    .equ num_temps, 0

    knapsack_prologue_start:
        push %ebp
        movl %esp, %ebp
        subl $ws * (num_locals + num_temps + num_regs), %esp  # make space for locals

        # stack after prologue
        # ebp + 24: cur_value
        # ebp + 20: capacity
        # ebp + 16: num_items
        # ebp + 12: values
        # ebp + 8: weights
        # ebp + 4: return address  (1 * ws)
        # ebp: old ebp
        # ebp - 1 * ws: i 
        # ebp - 2 * ws: best_value
        # ebp - 3 * ws: old_ebx
        


        .equ weights, (2 * ws) # (%ebp)
        .equ values, (3 * ws) # (%ebp)
        .equ num_items, (4 * ws) # (%ebp)
        .equ capacity, (5 * ws) # (%ebp)
        .equ cur_value, (6 * ws) # (%ebp)
        .equ i, (-1 * ws) # (%ebp)
        .equ best_value (-2 * ws) # (%ebp)
        .equ old_ebx(-3 * ws) # (%ebp)

        # save callee saved registers

    knapsack_prologue_end:

    movl $0, %ecx # counter = i
    movl capacity(%ebp), %eax # eax = bestvalue


    for_loop_start:
        cmpl num_items(%ebp), %ecx
        jae for_loop_end

        if_start:
            movl weights(%ebp), %ebx
            movl (%ebx, %ecx, 4), %ebx
            cmpl %ebx, capacity(%ebp)
            jl if_end 

        # best_value = max(best_value, knapsack(weights + i + 1, values + i + 1, num_items - i - 1, 
        #            capacity - weights[i], cur_value + values[i]));
        # eax stores best value
        # 

        if_end:

        incl %ecx
        jmp for_loop_start
    for_loop_end:



    # return value
    movl best_value(%ebp), %eax # set return value


    epilogue:
        # restore saved registers
        movl old_ebx(%ebp), %ebx 


        movl %ebp, %esp
        pop %ebp
        ret

