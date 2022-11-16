#Shira Taitelbaum 322207341
.section .rodata
str_format: .string "%s\n"
inval_input: .string "invalid input!\n"


.text
.global pstrlen,pstrijcpy,replaceChar,swapCase,pstrijcmp

.type pstrlen, @function
#get *pstr: return it's len
pstrlen:
#%rdi = *pstr
    movq  $0, %rax              #
    movb  (%rdi), %al           #rax=*pstr, the first byte is the len of the pstr
    ret                         #


.type replaceChar, @function
#get pstring, oldC and newC: return the pstr with the newC instend of the oldc
replaceChar:
#%rdi = *pstr, %rsi = oldChar, %rdx = newChar
    movq   %rdi, %r10           #the first letter in pstr
    movq   $0,%r11              #
    movq   $0,%rax              #
    movb   %sil, %r11b          #r11 = oldC
    movb   %dl, %al             #rax = newC
    movq   $0, %r9              #
    movb   (%r10), %r9b         #r9 = str.len
    movq   $0, %rcx             #int i = 0
    inc    %r10                 #the next in r10 (point on the first letter)

.loop_replace:
    cmpb   %r11b, (%r10)        #if A[i]-oldCr=0
    jne    .next_letter         #if not, go to the next letter
    movb   %al, (%r10)          #A[i] = newChar
    #jmp    .next_letter         #go to the next letter

.next_letter:
    addq   $1, %rcx             #i++
    incq   %r10                 #move to the next letter
    cmpq   %rcx, %r9            #if i < str.len
    jg     .loop_replace        #goto loop with this letter
    movq   $0, %rax             #
    movq   %rdi, %rax           #
    ret                         #return rhe new str
 
 
.type pstrijcpy @function
#get 2 pstr and 2 indexes: copy the chars from src[i:j] pstr to dst[i:j]
pstrijcpy:
#rdi = *dst str, %rsi = *src str, %rdx = i , %rcx = j
    movq   %rdx, %r12           #r12 = i
    movq   %rcx, %r13           #r13 = j
    movq   %rdi, %r14           #r14 = *dst
    movq   %rsi, %r15           #r15 = *src
    addq   $1, %r13             #j +=1
    movzbq (%r14), %r11         #*dst.len
    cmpq   %r13, %r11           #if j > *dst.len
    jl     .pstrijcpy_invalid   #if yes, invalid input

    movzbq (%r15), %r11         #*src.len
    cmpq   %r13, %r11           #if j > *src.len
    jl     .pstrijcpy_invalid   #if yes, invalid input
  
    addq   $1, %r14             #the str in *dst-A
    addq   $1, %r15             #the str in *src-B
    addq   %rdx, %r14           #A[i]
    addq   %rdx, %r15           #B[i]
    jmp    .pstrijcpy_copmij    #

.pstrijcpy_copm_loop:
    movq   $0,%rcx              #
    movb   (%r15), %cl          #%rcx = current char in dst str
    movb   %cl, (%r14)          #
    jmp    .pstrijcpy_inc_i     #if chars equal - increase i, and go for next char

.pstrijcpy_inc_i:
    addq   $1, %r12             #i++
    incq   %r14                 #A[i+1]
    incq   %r15                 #B[i+1]

.pstrijcpy_copmij:
    cmp    %r12, %r13           #i < j
    jg     .pstrijcpy_copm_loop #if yes, goto pstrijcpy_copm_loop
    jmp    .pstrijcpy_copm_end  #if not, end the function
  
.pstrijcpy_invalid:
    movq   %rdi, %r14           #r14=str
    mov    $inval_input, %rdi   #   
    movq   $0, %rax             #
    call   printf               #print the error
    movq   %r14, %rdi           #rdi=str
    jmp    .pstrijcpy_copm_end  #end the function
  
.pstrijcpy_copm_end:
    movq   %rdi, %rax           #rax= the pstr
    ret                         #ret rax
    
      
.type swapCase @function
#get pstr: replace bigger case with lower and opposite.
swapCase:
#rdi = pstr
    movq   %rdi, %rbx           #save string pointer to rbx
    movq   $0, %r9              #init counter r9
    movb   (%rbx), %r9b         #mov str.len into counter r9
 
.loop_entry:
    cmpq   $0, %r9              #counter=?0
    je     .end_of_loop         #if equal, end loop
    dec    %r9                  #decrement loop counter
    inc    %rbx                 #increment pointer of string
 
  #Case in range of lower case
    cmpb   $0x61, (%rbx)        #compare with "a" (ascii of "a" equale 0x61)
    jb     .check_upper_case    #if below, goto check_upper_case
    cmpb   $0x7a, (%rbx)        #compare with "z" (ascii of "z" equale 0x7a)
    ja     .loop_entry          #if above, goto loop_entry
    movb   (%rbx), %r14b        #mov char to r14
    sub    $0x20, %r14          #change letter to upper case
    movb   %r14b, (%rbx)        #update char change in string
    jmp    .loop_entry          #goto loop_entry
  
  #Case in range of upper case
.check_upper_case:
    cmpb   $0x41, (%rbx)        #compare with "A" (ascii of "A" quale 0x41)
    jb     .loop_entry          #if below, goto check_upper_case
    cmpb   $0x5a, (%rbx)        #compare with "Z" (ascii of "Z" quale 0x5a)      
    ja     .loop_entry          #if above, goto loop_entry
    movb   (%rbx), %r14b        #mov char to r14
    add    $0x20, %r14          #change letter to upper case
    movb   %r14b, (%rbx)        #update char change in string
    jmp    .loop_entry          #goto loop_entry
    
.end_of_loop:
    movq   %rdi, %rax           #rax=*pstr
    ret                         #return rax   
  
   
.type pstrijcmp @function
#get 2 pstring and 2 indexes: compare char by char from src[i:j] pstring to dst[i:j]
pstrijcmp:
#rdi = *dst str, %rsi = *src str, %rdx = i , %rcx = j
    movq   %rdx, %r12           #r12 = i
    movq   %rcx, %r13           #r13 = j
    movq   %rdi, %r14           #r14 = *dst
    movq   %rsi, %r15           #r15 = *src
    addq   $1, %r13             #j +=1

  
    movzbq (%r14), %r11         #*dst.len
    cmpq   %r13, %r11           #if j > *dst.len
    jl     .pstrijcmp_invalid   #goto pstrijcmp_invalid

    movzbq (%r15), %r11         #*src.len
    cmpq   %r13, %r11           #if j > *src.len
    jl     .pstrijcmp_invalid   #goto pstrijcmp_invalid

    addq   $1, %r14             #the string in *dst
    addq   $1, %r15             #the string in *src
    addq   %rdx, %r14           #A[i]
    addq   %rdx, %r15           #B[i]
    jmp    .pstrijcmp_copm

.pstrijcmp_copm_loop:
    movzbq (%r14), %rcx         #rcx=current char in dst str
    movzbq (%r15), %rax         #rax=current char in src str
    cmpq   %rax, %rcx           #check dst char ? src char
    je     .pstrijcmp_inc_i     #if chars equal, increase i, and go for next char
    jg     .dst_bigger          #if pstr1 char bigger than pstr 2 char
    jl     .src_bigger          #if pstr1 char smaller than pstr 2 char
    
.pstrijcmp_inc_i:
    addq   $1, %r12             #i++
    incq   %r14                 #A[i+1]
    incq   %r15                 #B[i+1]                

.pstrijcmp_copm:
    cmp    %r12, %r13           #i < j
    jg     .pstrijcmp_copm_loop #goto pstrijcmp_copm_loop

.char_eq:
    movq   $0, %rax             #return 0
    ret                         #

.dst_bigger:
    movq   $1, %rax             #return 1
    ret                         #

.src_bigger:
    movq  $-1, %rax             #return -1
    ret                         #

.pstrijcmp_invalid:
    movq   $inval_input, %rdi   #
    movq   $0, %rax             #
    call   printf               #print error,invalid input
    mov    $-2, %rax            #return -2
    ret                         #
    