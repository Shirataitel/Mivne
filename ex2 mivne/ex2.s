#Shira Taitelbaum 322207341
	.text

	.globl	go
	.type	go, @function
go:
.LFB0:
        movq  $0, %rax             #sum = 0
        movl  $0, %ecx             #i = 0 #rdi is the array
.loop:
        #the array in rdi
        movl  (%rdi, %rcx,4), %esi #go to the i in the array and put in register
        testb $1, %sil             #A[i]&1
        jne .odd                   #if A[i]&1!=0 jump to ood
        #if it didnt jump its mean A[i]&1==0
        sall  %cl, %esi            #num = A[i] << i 
        addl  %esi, %eax           #sum+=num
        jmp .lastofloop            #jump to the last part of the loop
.odd:
        addl %esi, %eax            #sum+=A[i]
        jmp .lastofloop            #jump to the last part of the loop
.lastofloop:
        incq  %rcx                 #i++
        cmpq  $10, %rcx            #check if i-10==0
        jne  .loop                 #loop
        ret
        
