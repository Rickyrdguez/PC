.data
.globl main

main:
  li $t0, 1 # Carga en t0 el nº 1
  li $t1, 0 # Carga en t1 el nº 0

doWhile: 
  add $t1, $t1, $t0 # $t1 = $t1 + $t0
  add $t0, 1 # $t0 = $t0 + 1

  ble $t0, 10, doWhile # Siempre que $t0 <= 10 repite el bucle

doWhileFin:
  li $v0, 10
  syscall