.data
  numero1: .asciiz "Introduce el primer número: "
  numero2: .asciiz "Introduce el segundo número: "
  resultado: .asciiz "El resultado de la suma es: "

.text
.globl main

main: 
  # Lectura del primer número

  li $v0, 4 # Servicio de mostrar por pantalla
  la $a0, numero1
  syscall

  li $v0, 5 # Servicio de leer 
  syscall # Ejecuta la lectura
  move $s0, $v0 # El dato leido se guarda en s0

  # Lectura del segundo número

  li $v0, 4 # Servicio de mostrar por pantalla
  la $a0, numero2
  syscall

  li $v0, 5 # Servicio de leer 
  syscall # Ejecuta la lectura
  move $s1, $v0 # El dato leido se guarda en s1

  add $t0, $s0, $s1

  li $a0, $t0
  li $v0, 1 # Servicio de mostrar entero
  syscall

  li $v0, 4 
  la $a0, resultado
  syscall

  li $v0, 10
  syscall