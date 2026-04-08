.data

.text
.globl main

main:
  li $t0, 10
  li $t1, 4
 
  sub $t2, $t0, $t1 

  li $v0, 10

syscall