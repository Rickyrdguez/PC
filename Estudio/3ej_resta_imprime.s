.data

.text
.globl main

main:
  li $t0, 10 # La posicion $t0 vale 10
  li $t1, 4 # La posicion $t1 vale 4
 
  sub $a0, $t0, $t1 # $a0 = $t0 - $t1 que es 6
  li $v0, 1 # Imprime el $a0
  syscall

  li $v0, 10 # Acaba el programa

syscall