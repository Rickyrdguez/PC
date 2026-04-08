.data
.globl main

main:
  li $a0, 5
  li $v0, 1 

doWhile:
  mul $t0, $v0, $a0 # v0 = v0 * a0
  addi $a0, $a0, -1 # a0 = a0 - 1

  bgt $a0, 0, doWhile # si a0 > 0 salta a doWhile para repetir

doWhileFin:
  move $a0, $t0 # movemos el resultado de la multiplicacion a a0
  li $v0, 1 # imprime por pantalla
  syscall

  li $v0, 10 # fin de programa 
  syscall