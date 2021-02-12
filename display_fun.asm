.data 
arr: .space 20
line: .asciiz "\n"
arrvalues:.word 1 0 3 5 8
.text 
main:
	addi $s0,$zero,1
	addi $s1,$zero,0
	addi $s2,$zero,3
	addi $s3,$zero,5
	addi $s4,$zero,8
	#reset t0
	addi $t0,$zero,0
	
	sw $s0,arr($t0)
	  addi $t0,$t0,4
	sw $s1,arr($t0)
	  addi $t0,$t0,4
	sw $s2,arr($t0)
	  addi $t0,$t0,4
	sw $s3,arr($t0)
	  addi $t0,$t0,4
	sw $s4,arr($t0)
	  addi $t0,$t0,4
	  #reset t0 again
	addi $t0,$zero,0
display:
	beq $t0,20,exitdisplay
	lw $t2,arr($t0)
	addi $t0,$t0,4
	#print current numper 
	li $v0,1
	move $a0,$t2
	syscall 
	#print line 
	li $v0,4
	la $a0,line 
	syscall
	j display
exitdisplay: 
	li $v0,10
	syscall