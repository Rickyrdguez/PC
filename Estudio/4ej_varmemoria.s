.data
  numero: .word 7

.text
.globl main

main: 
  lw $t0, numero # Carga el valor de numero en la variable $t0
  add $a0, $t0, 3 # A $t0 le suma 3 
  li $v0, 1 # Servicio que imprime enteros
syscall

  li $v0, 10 # Servicio que termina el programa
  syscall