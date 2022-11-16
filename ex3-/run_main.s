#Shira Taitelbaum 322207341
.section .rodata
format_int: .string "%d"
format_str: .string "%s"


.section .text
.global run_main
.type  run_main ,@function
run_main:
    movq   %rsp, %rbp          #for correct debugging
    subq   $536, %rsp          #between rbp to rsp there is 528 bytes
    #pstring1
    movq   $format_int, %rdi   #put in rdi the format of int
    leaq   -536(%rbp), %rsi    #put in rsi rhe -528(%rbp), start of pstring1
    movq   $0, %rax            #
    call   scanf               #scan the len of pstr1
    
    movq   $format_str, %rdi   #put in rdi the format of string
    leaq   -535(%rbp), %rsi    #put in rsi rhe -527(%rbp)
    movq   $0, %rax            #
    call   scanf               #scan the str of pstr1
    #pstring2
    movq   $format_int, %rdi   #put in rdi the format of int
    leaq   -280(%rbp), %rsi    #put in rsi rhe -272(%rbp), start of pstring1
    movq   $0, %rax            #
    call   scanf               #scan the len of pstr2
    
    movq   $format_str, %rdi   #put in rdi the format of string
    leaq   -279(%rbp), %rsi    #put in rsi rhe -271(%rbp)
    movq   $0, %rax            #
    call   scanf               #scan the str of pstr2
    #opt
    movq   $format_int, %rdi   #put in rdi the format of int
    leaq   -28(%rbp), %rsi     #put in rsi rhe -16(%rbp)
    movq   $0, %rax            #
    call   scanf               #scan the opt
    movzbq -28(%rbp), %r8
    
    #call run func
    leaq   -536(%rbp), %rsi    #rsi = pstring1
    leaq   -280(%rbp), %rdx    #rdx = pstring2
    movq    %r8, %rdi          #rdi = opt
    call   run_func
    #end
    movq   $0, %rax            #
    movq   %rbp, %rsp          #
    ret                        #return 0
  