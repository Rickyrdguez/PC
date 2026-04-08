# Si el número es positivo, debe contar cuántos números pares hay desde 1 hasta ese número.
# Si es negativo, debe imprimir un mensaje de error.

.data
strNumero: .asciiz "Introduce un número: \n"
strError: .asciiz "Error. El programa usa números positivos\n"

.text

main: 
  li $v0, 4 # Funcion escribir
  la $a0, strNumero # Carga el contendio de strNumero a $a0
  syscall # Imprime por pantalla

  li $v0, 5 # Funcion leer 
  syscall 
  move $t0, $v0 # Mueve a $t0 el contenido de $v0

  if:
  blt $t0, $zero, if_else # Si $t0 es menor que $t0, salta a if_else

  b else # salta a la etiqueta else
  
  if_else:
  li $v0, 4 # Funcion imprimir
  la $a0, strError
  syscall

  else:
  li $v0, 10
  syscall