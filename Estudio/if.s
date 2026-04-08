  .data
  .globl main

  main:
    li $t0, 15 # Carga en $t0 el nº 15
    li $t1, 25 # Carga en $t1 el nº 25

  if:
    bgt $t0, $t1, if_true # si se cumple $t0 > $t1 salta a la parte true
    li $s0, 0 # Carga en $s0 en 1
    j if_fin 

  if_true:
    li $s0, 1 # Carga en $s0 en 1

  if_fin:
    li $v0, 10
    syscall