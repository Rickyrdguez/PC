# Ricardo Jesús Rodríguez Pérez 15/06/2026
#
# // Principio de Computadores.
# // Operaciones con funciones y direccionamiento indirecto
# // Autores: Carlos Martín Galán y Alberto Hamilton Castro
# // Fecha última modificación: 2025-04-11
# #include <iostream>

# const int n1 = 10;
# double v1[n1] = {10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0};
# const int n2 = 5;
# double v2[n2] = {5.5, 4.5, 4.25, 2.5, 2.5 };
# const int n3 = 4;
# double v3[n3] = {7.0, 5.0, 2.0, 1.0};


# void printvec(double* v, const int n) {
#     std::cout << "\nVector con dimension " << n << '\n';
#     for (int i = 0; i < n; i++)
#         std::cout << v[i] << " ";

#     std::cout << "\n";
#     return;
# }

# int ordenado(double* v, const int n) {
#     int resultado = 1;
#     int i = 0;
#     while (i < n-1) {
#         if (v[i+1] >= v[i]) {
#             resultado = 0;
#             break;
#         }
#         i++;
#     }
#     return resultado;
# }

# void merge(double* v1, const int n1,double* v2, const int n2) {

#     int  o1 = ordenado(v1,n1);
#     if (o1 == 0) {
#       std::cout << "Primer vector no ordenado. NO se puede mezclar\n";
#       return;
#     }
#     int o2 = ordenado(v2,n2);
#     if (o2 == 0) {
#       std::cout << "Segundo vector no ordenado. NO se puede mezclar\n";
#       return;
#     }
#     int i = 0; // índice para recorrer el v1
#     int j = 0; // índice para recorrer el v2
#     while ( ( i < n1) && (j < n2) ) {
#         if (v1[i] >= v2[j]) {
#             std::cout << v1[i] << ' ';
#             i++;
#         }
#         else {
#             std::cout << v2[j] << ' ';
#             j++;
#         }
#     }
#     while ( i < n1) {
#         std::cout << v1[i] << ' ';
#         i++;
#     }
#     while ( j < n2) {
#         std::cout << v2[j] << ' ';
#         j++;
#     }
#     std::cout << '\n';
#     return;
# }

# int main(void) {
#   std::cout << "\nPrograma de mezcla de vectores\n";

#   printvec(v1,n1);
#   printvec(v2,n2);
#   printvec(v3,n3);

#   std::cout << "\nIntentando mezcla con dos vectores ...\n";
#   merge(v1,n1,v2,n2);

#   std::cout << "\nIntentando mezcla con dos vectores ...\n";
#   merge(v1,n1,v3,n3);

#   std::cout << "\nIntentando mezcla con dos vectores ...\n";
#   merge(v2,n2,v3,n3);

#   std::cout << "\nFIN DEL PROGRAMA\n";
#   return 0;
# }

sizeD = 8

    .data
n1:     .word 10
v1:     .double 10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0
n2:     .word 5
v2:     .double 5.5, 4.5, 4.25, 2.5, 2.5
n3:     .word 4
v3:     .double 7.0, 5.0, 2.0, 1.0

cad0:	.asciiz	"\nPrograma de mezcla de vectores\n"
cad1:   .asciiz "\nVector con dimension "
cad51:	.asciiz	"Primer vector no ordenado. NO se puede mezclar\n"
cad52:	.asciiz	"Segundo vector no ordenado. NO se puede mezclar\n"
cad2:   .asciiz "\nIntentando mezcla con dos vectores ...\n"
cad3:   .asciiz "\nFIN DEL PROGRAMA\n"

.text

###############################################################################
# void printvec(double* v, const int n) {
#
# Parámetros de entrada:
#   double* v --> $a0
#   const int n --> $a1
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   double* v --> $a0 --> $s0
#   const int n --> $a1 --> $s1
#   indice i --> $s2
#   
#   Cálculos momentaneos --> $t0
###############################################################################
printvec:
  # PUSH --> $ra, $s0, $s1, $s2 --> 4 * 4 = 16 -> multiplo de 8
  addi $sp, $sp, -16
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)

  move $s0, $a0
  move $s1, $a1

#     std::cout << "\nVector con dimension " << n << '\n';
  li $v0, 4
  la $a0, cad1
  syscall

  li $v0, 1
  move $a0, $s1
  syscall

  li $v0, 11
  la $a0, 10
  syscall

  # Inicializamos i = 0 antes de entrar en el bucle
  li $s2, 0

#     for (int i = 0; i < n; i++)
for_printvec:
  bge $s2, $s1, for_printvec_fin

#         std::cout << v[i] << " ";
  mul $t0, $s2, sizeD
  add $t0, $s0, $t0
  l.d $f12, 0($t0)

  li $v0, 3
  syscall

  li $v0, 11
  li $a0, 32
  syscall

  addi $s2, $s2, 1
  b for_printvec

for_printvec_fin:

#     std::cout << "\n";
  li $v0, 11
  li $a0, 10
  syscall

#     return;
# }
  # POP
  lw $ra, 0($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  lw $s2, 12($sp)
  addi $sp, $sp, 16

  jr $ra

printvec__MARCAFIN:

###############################################################################
# int ordenado(double* v, const int n) {
#
# Parámetros de entrada: 
#   double *v --> $a0
#   cons int n --> $a1
# Parámetros de salida:
#   int resultado --> $v0
#
# Función leaf --> NO modifica $ra --> NO hace uso de pila
#
# Tabla de parámetros:
#   double *v --> $a0 --> $t0
#   cons int n --> $a1 --> $t1
#   int resultado --> $t2
#   int i --> $t3
#   condicion n-1 --> $t4
#   direccion de i + 1 --> $t5
#   direccion de i --> $t6
#
#   vector v[i+1] --> $f4
#   vector v[i] --> $f6
###############################################################################
ordenado:
  move $t0, $a0
  move $t1, $a1

#     int resultado = 1;
  li $t2, 1

#     int i = 0;
  li $t3, 0

  # condicion n - 1
  addi $t4, $t1, -1

#     while (i < n-1) {
while_ordenado:
  bge $t3, $t4, while_ordenado_fin

#         if (v[i+1] >= v[i]) {
  # Accedemos a v[i+1]
  addi $t5, $t3, 1
  mul $t5, $t5, sizeD
  add $t5, $t0, $t5
  l.d $f4, 0($t5)

  # Accedemos a v[i]
  mul $t6, $t3, sizeD
  add $t6, $t0, $t6 
  l.d $f6, 0($t6)

if_ordenado:
  c.lt.d $f4, $f6
  bc1t if_ordenado_fin

#             resultado = 0;
  li $t2, 0
#             break;
  b while_ordenado_fin

#         }
if_ordenado_fin:

#         i++;
  addi $t3, $t3, 1

  b while_ordenado

#     }
while_ordenado_fin:

#     return resultado;
  move $v0, $t2

# }
  jr $ra

ordenado__MARCAFIN:

###############################################################################
# void merge(double* v1, const int n1,double* v2, const int n2) {
#
# Parámetros de entrada:
#   double* v1 --> $a0
#   const int n1 --> $a1
#   double* v2 --> $a2
#   const int n2 --> $a3
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   double* v1 --> $a0 --> $s0
#   const int n1 --> $a1 --> $s1
#   double* v2 --> $a2 --> $s2
#   const int n2 --> $a3 --> $s3
#   int o1 --> $s4
#   int o2 --> $s5
#   int i --> $s6
#   int j --> $s7
#
#   double v1[i] --> $f4
#   double v2[j] --> $f6
#
#   posicion de $f4 --> $t0
#   posicion de $f6, --> $t1 
###############################################################################
merge:
  # PUSH -> $ra, $s0-$s7 = 9 * 4 = 36 -> multiplo de 8
  addi $sp, $sp, -40
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)
  sw $s4, 20($sp)
  sw $s5, 24($sp)
  sw $s6, 28($sp)
  sw $s7, 32($sp)

  move $s0, $a0
  move $s1, $a1
  move $s2, $a2
  move $s3, $a3

#     int  o1 = ordenado(v1,n1);
  move $a0, $s0
  move $a1, $s1
  jal ordenado

  move $s4, $v0

#     if (o1 == 0) {
if_o1_merge:
  bne $s4, 0, if_o1_merge_fin
#       std::cout << "Primer vector no ordenado. NO se puede mezclar\n";
  li $v0, 4 
  la $a0, cad51
  syscall

#       return;
  b return
#     }
if_o1_merge_fin:

#     int o2 = ordenado(v2,n2);
  move $a0, $s2
  move $a1, $s3
  jal ordenado

  move $s5, $v0

#     if (o2 == 0) {
if_o2_merge:
  bne $s5, 0, if_o2_merge_fin

#       std::cout << "Segundo vector no ordenado. NO se puede mezclar\n";
  li $v0, 4
  la $a0, cad52
  syscall

#       return;
  b return

#     }
if_o2_merge_fin:

#     int i = 0; // índice para recorrer el v1
  li $s6, 0

#     int j = 0; // índice para recorrer el v2
  li $s7, 0

#     while ( ( i < n1) && (j < n2) ) {
while1_merge:
  bge $s6, $s1, while1_merge_fin
  bge $s7, $s3, while1_merge_fin

#         if (v1[i] >= v2[j]) {
  mul $t0, $s6, sizeD
  add $t0, $s0, $t0
  l.d $f4, 0($t0)

  mul $t1, $s7, sizeD
  add $t1, $s2, $t1
  l.d $f6, 0($t1)

if_while1:
  c.lt.d $f4, $f6
  bc1t if_while1_fin

#             std::cout << v1[i] << ' ';
  li $v0, 3
  mov.d $f12, $f4
  syscall

  li $v0, 11
  li $a0, 32
  syscall

#             i++;
  addi $s6, $s6, 1

  b else_while1_fin

#         }
if_while1_fin:

#         else {
else_while1:

#             std::cout << v2[j] << ' ';
  li $v0, 3
  mov.d $f12, $f6
  syscall

  li $v0, 11
  li $a0, 32
  syscall

#             j++;
  addi $s7, $s7, 1

#         }
else_while1_fin:

  b while1_merge

#     }
while1_merge_fin:

#     while ( i < n1) {
while2_merge:
  bge $s6, $s1, while2_merge_fin

#         std::cout << v1[i] << ' ';
  mul $t0, $s6, sizeD
  add $t0, $s0, $t0
  l.d $f4, 0($t0)

  li $v0, 3
  mov.d $f12, $f4
  syscall

  li $v0, 11
  li $a0, 32
  syscall

#         i++;
  addi $s6, $s6, 1 
  b while2_merge

#     }
while2_merge_fin:

#     while ( j < n2) {
while3_merge:
  bge $s7, $s3, while3_merge_fin

#         std::cout << v2[j] << ' ';
  mul $t1, $s7, sizeD
  add $t1, $s2, $t1
  l.d $f6, 0($t1)


  li $v0, 3
  mov.d $f12, $f6
  syscall

  li $v0, 11
  li $a0, 32
  syscall

#         j++;
  addi $s7, $s7, 1 
  b while3_merge

#     }
while3_merge_fin:

#     std::cout << '\n';
  li $v0, 11
  li $a0, 10
  syscall

#     return;
return:

# }
  # POP
  lw $ra, 0($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  lw $s2, 12($sp)
  lw $s3, 16($sp)
  lw $s4, 20($sp)
  lw $s5, 24($sp)
  lw $s6, 28($sp)
  lw $s7, 32($sp)
  addi $sp, $sp, 40

  jr $ra

merge__MARCAFIN:

###############################################################################
# int main(void) {
#
# Parámetros de entrada: NINGUNO
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
###############################################################################
main:
  # PUSH
  addi $sp, $sp, -8
  sw $ra, 0($sp)

#   std::cout << "\nPrograma de mezcla de vectores\n";
  li $v0, 4
  la $a0, cad0
  syscall

#   printvec(v1,n1);
  la $a0, v1
  lw $a1, n1
  jal printvec

#   printvec(v2,n2);
  la $a0, v2
  lw $a1, n2
  jal printvec

#   printvec(v3,n3);
  la $a0, v3
  lw $a1, n3
  jal printvec

#   std::cout << "\nIntentando mezcla con dos vectores ...\n";
  li $v0, 4
  la $a0, cad2
  syscall

#   merge(v1,n1,v2,n2);
  la $a0, v1
  lw $a1, n1
  la $a2, v2
  lw $a3, n2
  jal merge


#   std::cout << "\nIntentando mezcla con dos vectores ...\n";
  li $v0, 4
  la $a0, cad2
  syscall

#   merge(v1,n1,v3,n3);
  la $a0, v1
  lw $a1, n1
  la $a2, v3
  lw $a3, n3
  jal merge

#   std::cout << "\nIntentando mezcla con dos vectores ...\n";
  li $v0, 4
  la $a0, cad2
  syscall

#   merge(v2,n2,v3,n3);
  la $a0, v2
  lw $a1, n2
  la $a2, v3
  lw $a3, n3
  jal merge

#   std::cout << "\nFIN DEL PROGRAMA\n";
  li $v0, 4
  la $a0, cad3
  syscall

#   return 0;
# }
  # PULL
  lw $ra, 0($sp)
  addi $sp, $sp, 8

  jr $ra
  
main__MARCAFIN: