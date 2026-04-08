.data
strIntroN: .asciiz "Introduce un numero: \n"
strMayor: .asciiz "El número es mayor que 10: \n"
strMenor: .asciiz "El número es menor que 10: \n"

main:
  li $v0, 4 # Funcion escribir
  la $a0, strIntroN # Muevo la cadena strIntroN a $a0 para que se imprima
  syscall 

  # Guardar dato
  li $v0, 5 # Funcion guardar
  syscall 
  move $s0, $v0 # Mueve a $s0 lo guardado en $v0

  ble $s0, 10, else_if # Si n <= 10 entonces salta a else_if

  li $v0, 4 # Funcion escribir
  la $a0, strMayor
  syscall
  j_if_fin # Salta a la etiqueta if_fin

  else_if:
  li $v0, 4 # Funcion escribir
  la $a0, strMenor
  syscall

  if_fin:

  li $v0, 10
  syscall 