#Shira Taitelbaum 322207341
.section .rodata
.align 8
case_5060: .string "first pstring length: %d, second pstring length: %d\n"

case_52: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"

case_53: .string "length: %d, string: %s\n"

case_54: .string "length: %d, string: %s\n"

case_55: .string "compare result: %d\n"

case_default: .string "invalid option!\n"

format_int: .string "%d"
format_str: .string "%s"
.switch_case:
    .quad .case_5060
    .quad .default_case #"case 51"
    .quad .case_52
    .quad .case_53
    .quad .case_54
    .quad .case_55
    .quad .default_case         #"case 56"
    .quad .default_case         #"case 57"
    .quad .default_case         #"case 58"
    .quad .default_case         #"case 59"
    .quad .case_5060
  
  
.section .text
.global run_func
.extern pstrlen,replaceChar, pstrijcpy, swapCase, pstrijcmp
.type  run_func ,@function
run_func:
    #rdi = opt, rsi = pstr1, rdx = pstr2
    pushq %r12                  #push to the stack
    pushq %r13
    movq  %rsi, %r12            #r12=pstr1
    movq  %rdx, %r13            #r13=pstr2
  
    sub   $50,%rdi              #opt-50
    cmp   $10,%rdi              #if opt>10
    ja    .default_case         #goto default_case, worng input
    jmp   *.switch_case(,%rdi,8)#else, jump to the switch case table


.case_5060:
    movq  %r12, %rdi            #rdi=pstr1
    call  pstrlen               #call pstrlen
    movq  %rax, %rsi            #rsi=pstr1.len
    
    movq  %r13, %rdi            #rdi=pstr2
    call  pstrlen               #call pstrlen
    movq  %rax, %rdx            #rdx=pstr2.len

    movq  $case_5060, %rdi      # 
    movq  $0, %rax              #
    call  printf                #print the len of 2 pstr
    
    jmp   .end                  #jump to the end
 
       
.case_52:
    push  %rbp                  #push to the stack
    movq  %rsp, %rbp
    subq  $16, %rsp
    push  %r14                  #for the oldC
    push  %r15                  #for the newC

    leaq  -8(%rbp), %rsi        #-8(%rbp), 8 for the oldC
    movq  $format_str, %rdi     #
    movq  $0, %rax              #
    call  scanf                 #scan the oldC
    movq  -8(%rbp), %r14        #move oldC to %r14

    leaq  -16(%rbp), %rsi       #-16(%rbp), 8 for the newC
    movq  $format_str, %rdi     #
    movq  $0, %rax              #
    call  scanf                 #scan the newC
    movq  -16(%rbp), %r15       #move newC to %r15

    movq  %r15, %rdx            #rdx=newC 
    movq  %r14, %rsi            #rsi=oldC
    movq  %r12, %rdi            #rdi=pstr1
    call  replaceChar           #call replaceChar
    movq  %rax, %r12            #r12=the new first string

    movq  %r15, %rdx            #rdx=newC
    movq  %r14, %rsi            #rsi=oldC
    movq  %r13, %rdi            #rdi=pstr2
    call  replaceChar           #call replaceChar
    movq  %rax, %r13            #r13=the new second string

    movq  %r14, %rsi            #rsi=oldC
    movq  %r15, %rdx            #rdx=newC
    leaq  1(%r12), %rcx         #rcx=pstr1
    leaq  1(%r13), %r8          #r8=pstr2
    movq  $case_52, %rdi        #
    movq  $0, %rax              #
    call  printf                #print the newc, oldc ang the 2 new pstr
  
    pop   %r15                  #clean the stack
    pop   %r14                  #
    addq  $16, %rsp             #
    movq  %rbp, %rsp            #
    pop   %rbp                  #
    jmp   .end                  #jump to the end
 
       
.case_53:
    push  %rbp                  #push to the stack
    movq  %rsp, %rbp            #
    subq  $16, %rsp             #

    leaq  -4(%rbp), %rsi        #-4(%rbp)=i
    movq  $format_int, %rdi     #
    movq  $0, %rax
    call  scanf

    leaq  -8(%rbp), %rsi        #-8(%rbp)=j
    movq  $format_int, %rdi     #
    movq  $0, %rax              #
    call  scanf                 #
  
    movq  $0,%r8                #
    movb  (%r12), %r8b          #pstr1.len
    movq  $0,%r9                #
    movb  (%r13), %r9b          #pstr2.len
  
    pushq %r13                  #save the registers in the stack
    pushq %r9                   #
    pushq %r8                   #

    movl  -4(%rbp), %edx        #rdx = i
    movl  -8(%rbp), %ecx        #rcx = j
    movq  %r12, %rdi            #pstr1
    movq  %r13, %rsi            #pstr2
    call  pstrijcpy             #call pstrijcpy
    movq  %rax, %r12            #r12= the result of pstrijcpy, the new pstr
  
    popq  %r8                   #pop r8
  
    movq  %r8, %rsi             #
    leaq  1(%r12),%rdx          #
    movq  $case_53, %rdi        #
    movq  $0, %rax              #
    call  printf                #print the len and the new pstr1 
  
    popq  %r9                   #pop r9,r13
    popq  %r13                  #
  
    movq  %r9, %rsi             #
    leaq  1(%r13),%rdx          #
    movq  $case_53, %rdi        #
    movq  $0, %rax              #
    call  printf                #print the len and the pstr2

    addq  $16, %rsp             #clean the stack
    movq  %rbp, %rsp            #
    pop   %rbp                  #
    jmp   .end                  #jump to the end

    
.case_54:  
    push  %rbp                  #push to the stack          
    movq  %rsp,%rbp             #
    push  %r14                  #
    push  %r15                  #

    movq  %r12, %rdi            #
    call  swapCase              #call swapCase
    movq  %rax, %r12            #r12= swap pstr1
  
    movq  %r13, %rdi            #
    call  swapCase              #call swapCase
    movq  %rax, %r13            #r13= swap pstr2
    movq  $0,%r14               #
    movq  $0,%r15               #
    movb  (%r12), %r14b         #r14=pstr1.len
    movb  (%r13), %r15b         #r15=pstr2.len
  
    movq  %r14, %rsi            #
    leaq  1(%r12), %rdx         #
    mov   $case_54, %rdi        #
    movq  $0, %rax              #
    call  printf                #print the len and swap pstr1

    movq  %r15, %rsi            #
    leaq  1(%r13), %rdx         #
    mov   $case_54, %rdi        #
    movq  $0, %rax              #
    call  printf                #print the len and swap pstr1

  #finish
    pop   %r15                  #clean the stack
    pop   %r14                  #
    movq  %rbp, %rsp            #
    pop   %rbp                  #
    jmp   .end                  #jump to the end
 
       
.case_55:
    push  %rbp                  #push to the stack              
    movq  %rsp, %rbp            #
    subq  $16, %rsp             #

    leaq  -4(%rbp), %rsi        #-4(%rbp)=i
    mov   $format_int, %rdi     #
    movq  $0, %rax              #
    call  scanf                 #scan i

    leaq  -8(%rbp), %rsi        #-8(%rbp)=j
    mov   $format_int, %rdi     #
    movq  $0, %rax              #
    call  scanf                 #scan j

    movl  -4(%rbp), %edx        #rdx = i
    movl  -8(%rbp), %ecx        #rcx = j
    movq  %r12, %rdi            #rdi=pstr1
    movq  %r13, %rsi            #rsi=pstr2
    call  pstrijcmp             #call pstrijcmp
    movq  %rax, %rsi            #rsi=the compare str
               
    mov   $case_55, %rdi        #
    movq  $0, %rax              #
    call  printf                #print the compare str

    addq  $16, %rsp             #clean the stack
    movq  %rbp, %rsp            #
    pop   %rbp                  #
    jmp   .end                  #jump to the end
    
.default_case:
    mov   $case_default, %rdi   #
    movq  $0, %rax              #
    call  printf                #print the default case ,invalid opt
    jmp   .end                  #jump to the end
     
.end: 
    popq  %r13                  #clean the stack
    popq  %r12                  #
    ret                         #
