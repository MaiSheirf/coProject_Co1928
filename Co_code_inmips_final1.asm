.data 
myarray:.word 1 0 3 5 8


.text 
main:
	la $a0 ,myarray
	addi $a1,$s0,5
	jal Insertion_sort
	addi $a0,$v0,0
	li $v0,1
	syscall
	li $v0, 10
	syscall
####################################(insertion sort)############################
Insertion_sort: 
# base is a0 length is a1
addi $t0 ,$s0 ,1                   # i=1
loop1:                                       #outer loop
slt  $t3 , $t0 ,$a1
beq  $t3 ,$0 ,exite2
sll $t4 ,$t0,2                   # list[i]
add $t4,$t4,$a0                    #key = list[i]    i*4
lw $t5,0($t4)                    # key 
addi $t1,$t0,-1                # j=i-1
loop2:                                    # iner loop 
slt $t4,$t1,$0                  #checking if j> 0
bne $t4,$0,exite2            # if j not =0
sll $t4 , $t1,2                  #it will move 4  next element adress 
add $t4,$t4,$a0                  #list[j]         
lw  $t4,0($t4)                 # t3=list[j]
                                 # t4=list[j+1]
slt $t6,$t5,$t4                 #check list[j]> key
beq $t6,$zero,exite2
addi $t6,$t1,1
sll $t6 ,$t6,2                     
add $t6,$t6,$a0
sw $t4,0($t6)                      #store list [j]
addi $t1,$t1,-1
j loop2
j loop1
exite2:                                    #end of iner loop 
addi $t1,$t1,1
sll $t7,$t1,2
add $t7,$t7,$a0
sw $t5,0($t7)
add $t0,$t0,1                 #i=++
jr $ra
#############################################(binary search)########################
	binarySearch:

  	  while:

		slt $t0, $a2, $a1           # set $t0 = 1 if last less than first
		bne $t0, $zero, exitLoop    # exit the loop if $t0 not equal zero
        
   					     # next steps will do the following equation
						## int m = l + (r - l) / 2
		addi $t3, $zero, 2
    		sub $t1, $a2, $a1
		add $t2, $t1, $a1
      	 	div $s0, $t2, $t3
        	# check if list[m] == x
       		add $t5, $a0, $s0
       		lw  $t6, 0($t5)
       		beq $t6, $a3, firstIf
        
       		# check if list[m] less than x
       		slt $t7, $t6, $a3
       		beq $t6, $1, secondIf
        	# check if list[m] bigger than x
        	slt $t8, $a3, $t6
        	beq $t6, $1, else
        
        	#this will return m value 
        	firstIf:
        	addi $v1, $s0, 0
            	jr $ra
        
        	#this will increase middle by one and put it in first variable
        secondIf:
        	addi $a1, $s0, 1
        
        	#this will increase middle by one and put it in last variable
        else:
        	addi $a1, $s0, -1
            
        
       		j while # jump to loop to keep loop going until it returns
        
		# return -1 if loop ends
	exitLoop:
       		 li $v1, -1 
      		jr $ra
##############################################(quick)#################################
# consider that list[i] = a0     first =a1   last=a2
# i=s0 , t0  j=s1 , t1  pivot=s2 ,t2    temp=$t7
   quick:
    	if:
    		slt  $t3 , $a0 ,$a1       
		beq  $t3 ,$0 ,exif
		add $t2 ,$s2 ,$a1  			# pivot=first 
		add $t0 ,$s0 ,$a1			# i = first 
		add $t1 ,$s1 ,$a2                    # j = last 
	while1:
		slt  $t4 , $t0 ,$t1                   # i<j 
		beq  $t4 ,$0 ,exwhile1		      # if true t4=1 it will contaiue
		

	while2:
		sll $t4,$t0,2             #i*4
		add $t4,$t4 ,$a0          #list []+4 
		lw $t4,0($t4)		  #list[i]
		sll $t5,$t2,2             #pivot*4
		add $t5,$t5 ,$a0          #list []+4
		lw $t5,0($t5)             #list[pivot]
		#check
		slt $t6,$t4,$t5                  # check if list[i]<=list[pivot]
		bne $t6,$0,exwhile1
		slt $t6,$a2 ,$t0                 # checking i<last
		bne $t6,$0,exwhile1
		addi $t0 ,$t0, 1
		j while2
	while3:
		sll $t6,$t1,2             #j*4
		add $t6,$t6 ,$a0          #list []+4 
		lw $t6,0($t6)             #   $t6=list[j]
		slt $t7,$t6,$t5
		beq $t7,0,exwhile1
		addi $t1,$t1,-1
		j while3
	if2:
	    	slt  $t3 , $a0 ,$t1       #if i<j
		beq  $t3 ,$0 ,exif
		add $t7,$t7,$t4          #temp=list[i];
		add $t4 ,$t4,$t6        #list[i]=list[j]
		add $t6,$t6,$t7         #list[j]=temp
		j while1
	exwhile1:
		add $t7,$t7,$t5	#temp=list[pivot]
		add $t5,$t5,$t6    	#list[pivot]=list[j]
		add $t6,$t6,$t7        # list[j]=temp;
		addi $a2,$t1,-1        #last = j-1
		jal  quick		
		addi $a1,$t1,1		#first =j+1
		jal  quick		
	exif:
		jr $ra
