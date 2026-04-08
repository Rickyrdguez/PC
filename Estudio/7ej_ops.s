.data
  resultado_suma: .asciiz "El resultado de la suma es: " 
  resultado_resta: .asciiz "El resultado de la resta es: "
  resultado_mult: .asciiz "El resultado de la multiplicación es: "

.text
.globl main

main:
  li $s0, 4
  li $s1, 3

  add $a0, $s0, $s1 # Suma de números
  move $a1, resultado_suma
  li $v0, 1 # Imprime un numero entero

  subi $a1, $t0, $t1
