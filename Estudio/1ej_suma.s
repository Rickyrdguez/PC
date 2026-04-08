.data

.text
.globl main

main:
  li $t0, 5 # Guardar 5 en el registro $t0
  li $t1, 3 # Guardar 3 en el registro $t1

  add $t2, $t0, $t1 # EL $t2 = $t0 + $t1

  li $v0, 10 # Codigo 10 = terminar programa
  syscall