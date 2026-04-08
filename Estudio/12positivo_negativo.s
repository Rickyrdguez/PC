.data
strNum: .asciiz "Introduce un número: \n"
strPos: .asciiz "EL número es positivo \n"
strNeg: .asciiz "El número es negativo \n"
strCero: .asciiz "El número introducido es el 0 \n"

.text
# int x --> $t0 

main:
  li $v0, 4 # Funcion escribir
  la $a0, strNum # Carga en a0 el string Num
  syscall # Llama al sistema para escribir por pantalla

  li $v0, 5 # Funcion guardar
  syscall 
  move $t0, $v0 # Mueve a $t0 el valor introducido por el usuario y guardado en $v0

  if: 
    bgt	$t0, $zero, if_then  # Si se cumple que t0 > 0 salta a if_then

  if_then:
    li $v0, 4 # Funcion escribir
    la $a0, strPos # Mueve a $a0 el string Pos
    syscall # Llama al sistema mostrando por pantalla
    b if_fin # Salta a if_fin una vez completado 

  else_if:
    blt $t0, $zero, else_if_then # Si se cumple t0 > 0 salta else_if_then

  else_if_then:
    li $v0, 4 # Funcion escribir
    la $a0, strNeg # Carga en a0 el string strNeg
    syscall # LLamada al systema muestra texto por pantalla
    b if_fin

  else:
    beq $t0, $zero, else_then # si t0 = zero entonces salta a else_then

  else_then:
    li $v0, 4 # Funcion escribir
    la $a0, strCero # Mueve el string Cero a a0
    syscall # Muestra el texto por pantalla
    b if_fin 

  if_fin:
    li $v0, 10 # Funcion final de programa
    syscall  