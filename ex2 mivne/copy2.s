	.text

	.globl	go
	.type	go, @function
go:
.LFB0:
	 endbr64
        movq  $0, %rax             #sum = 0
        movl  $0, %edx             #i = 0 #rdi is the array
.loop:
        #the array in rdi
        movl  (%rdi, %rdx,4), %esi #go to the i in the array and put in register
        testb $1, %sil             #A[i]&1
        jne .odd                   #if A[i]&1!=0 jump to ood
        #if it didnt jump its mean A[i]&1==0
        sall  %cl, %esi            #num = A[i] << i 
        addl  %edx, %eax           #sum+=num
        jmp .l8
.odd:
        addl %esi, %eax            #sum+=A[i]
        jmp .l8
       S
.l8:
        incq  %rdx                 #i++
        cmpq  $10, %rdx            #check if i-10==0
        jne  .loop                 #loop
        ret