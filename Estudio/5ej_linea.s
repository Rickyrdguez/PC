.data
  mensaje: .asciiz "Introduzca un número entero: "

.text
.globl main

main: 
  # Imprimir mensaje
  li $v0, 4 # Servicio de imprimir
  la $a0, mensaje
  syscall

  # Leer el número desde el teclado
  li $v0, 5 # Servicio de leer
  syscall # Ejecuta la lectura
  move $t0, $v0 # Guarda el valor leido en $t0

  #sumar 5
  addi $a0, $t0, 5

  #imprimir resultado
  li $v0, 1
  syscall
  

  li $v0, 10
  syscall