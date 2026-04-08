.data 
strNum: .asciiz "Introduce un número (0 para salir): \n"
strResult: .asciiz "El resultado es: \n"

.text
# numero $t0
# suma $s0

main:
  li $s0, 0 # inicializamos la suma a 0

doWhile:
  #cout
  li $v0, 4 # Funcion escribir
  la $a0, strNum # Mueve a $a0 el string Num
  syscall # Imprime el string por pantalla

  #cin
  li $v0, 5 # Funcion guardar
  syscall
  move $t0, $v0 # Guarda lo introducido a $t0

  add $s0, $s0, $t0 # s0 = s0 + t0

  bne $t0, $zero, doWhile # si $t0 != 0 salta a doWhile para repetir

doWhileFin:
  li $v0, 4 
  la $a0, strResult
  syscall

  li $v0, 1
  move $a0, $s0
  syscall

  li $v0, 10
  syscall