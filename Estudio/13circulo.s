.data
  strIntroR: .asciiz "Introduce el radio: \n"
  strResult: .asciiz "El área del círculo es: \n"
  pi: .float 3.14159

  .text
  # radio -> $t0 ($f4)
  # pi -> $f6
  # radio^2 -> $f8
  # radio * pi -> $12

  .main:

  li $v0, 4 # Función escribir por pantalla
  la $a0, strIntroR # Mueve el string IntroR  $a0
  syscall # Llama al sistema y muestra por pantalla

  li $v0, 5 # Funcion leer
  syscall # Llama al sistema y lleva a cabo leer
  move $t0, $v0 # Mueve a $t0 el valor almacenado en $v0

  # Convertir entero en punto flotante
  mtc1 $t0, $f4 # Llama al copro y pasa $t0 a $f0
  cvt.s.w $f4, $f4 # Convierte $f4 en simple precision y lo guarda en el mismo

  # Arreglo para poder usar pi
  lwc1 $f6, pi # Mueve pi a $f6 con load word a traves del copro

  # Cálculo del área
  mul.s $f8, $f4, $f4 # $f8 = $f4 * $f4
  mul.s $f12, $f6, $f8 # $f12 = $f6 * $f8

  li $v0, 4 # Funcion imprimir
  la $a0, strResult
  syscall

  li $v0, 2 # Funcion imprimir numeros en punto flotatne es $v0, 2 e imprime el numero almacenado en $f12
  syscall

  li $v0, 10
  syscall   