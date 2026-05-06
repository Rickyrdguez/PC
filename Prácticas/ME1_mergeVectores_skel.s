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

#########################################################################
# void printvec(double* v, const int n) {
# Parámetros de entrada:
#   double* v --> $a0
#   conss int n --> $a1
# Parámetros de salida: NINGUNO
#
# Sí llama a otra función --> SÍ modifica el $ra --> SÍ HACE USO DE PILA
#
# Tabla de registros:
#  int i --> $s0
#  const int n --> $s1
#  double* v --> $s2
#########################################################################
printvec:

    # PUSH. $ra, $s0-$s2 --> 4 * 4 = 16, que es múltiplo de 8
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    move $s1, $a1
    move $s2, $a0

#     std::cout << "\nVector con dimension " << n << '\n';
    li $v0, 4
    la $a0, cad1
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 11
    li $a0, 10
    syscall 

    # inicializamos i antes de entrar en el bucle
    move $s0, $zero

#     for (int i = 0; i < n; i++)
for_print:
    bge $s0, $s1, for_print_fin

#         std::cout << v[i] << " ";
    li $t2, sizeD
    mul $t0, $s0, $t2
    add $t1, $s2, $t0

    l.d $f12, 0($t1)
    li $v0, 3
    syscall 

    li $v0, 11
    li $a0, 32
    syscall


    addi $s0, $s0, 1
    b for_print

for_print_fin:

#     std::cout << "\n";
    li $v0, 11
    li $a0, 10
    syscall

    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16

#     return;
    jr $ra
# }
printvec__MARCAFIN:


#########################################################################
# int ordenado(double* v, const int n) {
# Parámetros: $a0 = v, $a1 = n | Retorno: $v0 = resultado
#
# Función LEAF: NO llama a nadie --> NO USA PILA (usamos solo regs $t)
#
# Tabla de registros:
#  $t0: i
#  $t1: n - 1 (límite del bucle)
#  $t2: dirección de v[i]
#  $t3: dirección de v[i+1]
#  $f4: valor v[i]
#  $f6: valor v[i+1]
#########################################################################
ordenado:
#   int resultado = 1;
    li $v0, 1
#   int i = 0;
    li $t0, 0

#   Calculamos n-1 una sola vez
    addi $t1, $a1, -1

while_ordenado:
#   while (i < n-1)
    bge $t0, $t1, while_ordenado_fin

    # --- Acceso a v[i] ---
    li $t4, sizeD            # $t4 = 8
    mul $t5, $t0, $t4        # desplazamiento = i * 8
    add $t2, $a0, $t5        # $t2 = dirección de v[i]
    l.d $f4, 0($t2)         # $f4 = v[i]

    # --- Acceso a v[i+1] ---
    addi $t3, $t2, sizeD     # La dirección de v[i+1] es la de v[i] + 8 bytes
    l.d $f6, 0($t3)         # $f6 = v[i+1]

#   if (v[i+1] >= v[i]) {
    # MIPS no tiene "mayor o igual" directo para floats. 
    # Usamos "menor que" (c.lt.d) y si es falso, es que es mayor o igual.
    c.lt.d $f6, $f4          # ¿v[i+1] < v[i]?
    bc1t no_hay_problema     # Si es verdad (está bien ordenado), saltamos el if

#       resultado = 0; break;
    li $v0, 0
    j while_ordenado_fin     # break

no_hay_problema:
#       i++;
    addi $t0, $t0, 1
    j while_ordenado

while_ordenado_fin:
#   return resultado;
    jr $ra

ordenado__MARCAFIN:


#########################################################################
# void merge(double* v1, const int n1,double* v2, const int n2) {
# Variables de entrada:
#   double* v1 --> $a0
#   const int n1 --> $a1
#   double* v2 --> $a2
#   const int n2 --> $a3
#
# Variables de salida --> NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de la pila
#
# Tabla de registros:
#   double* v1 --> $s0
#   const int n1 --> $s1
#   double* v2 --> $s2
#   const int n2 --> $s3
#   double v1 --> $f20
#   double v2 --> $f22
#   int i --> $s4
#   int j --> $s5
#   int o1 --> $t0
#   int o2 --> $t1   
#########################################################################
merge:
    # PUSH --> $ra + $s0-$s5 + $f20 + $f22 --> 4 * 7 + 16 --> 48
    addi $sp, $sp, -48
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    s.d $f20, 32($sp)
    s.d $f22, 40($sp)

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3

#     int  o1 = ordenado(v1,n1);
    move $a0, $s0
    move $a1, $s1
    jal ordenado

    move $t0, $v0
if_o1:
#     if (o1 == 0) {
    bne $t0, $zero, if_o1_fin
#       std::cout << "Primer vector no ordenado. NO se puede mezclar\n";
    li $v0, 4
    la $a0, cad51
    syscall
    
#       return;
    j return
     
#     }
if_o1_fin:

#     int o2 = ordenado(v2,n2);
    move $a0, $s2
    move $a1, $s3
    jal ordenado

    move $t0, $v0

#     if (o2 == 0) {
if_o2:
    bne $t0, $zero, if_o2_fin

#       std::cout << "Segundo vector no ordenado. NO se puede mezclar\n";
    li $v0, 4
    move $a0, cad52

#       return;
    j return

#     }
if_o2_fin:

#     int i = 0; // índice para recorrer el v1
    move $s4, $zero

#     int j = 0; // índice para recorrer el v2
    move $s5, $zero
    
#     while ( ( i < n1) && (j < n2) ) {
while_merge:
    bge $s4, $s1, while_merge_fin
    bge $s5, $s3, while_merge_fin

#         if (v1[i] >= v2[j]) {
    li $t0, 
if_while:

#             std::cout << v1[i] << ' ';
#             i++;
#         }
#         else {
#             std::cout << v2[j] << ' ';
#             j++;
#         }
#     }
while_merge_fin:
#     while ( i < n1) {
#         std::cout << v1[i] << ' ';
#         i++;
#     }
#     while ( j < n2) {
#         std::cout << v2[j] << ' ';
#         j++;
#     }
#     std::cout << '\n';
return:

#     return;
# }
merge__MARCAFIN: