# Ricardo Jesus Rodriguez Pérez 19/06/2026

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
#   double *v --> $a0
#   const in n --> $a1
# Parámetros de salida: NINGUNO
#
# SÍ lhace uso de otras funciones --> SI modifica el $ra --> SI hace uso de pila
#
# Tabla de parametros
#   double *v --> $a0 --> $s0
#   const int n --> $a1 --> $s1
#   int i --> $s2
#   v[i] --> $f12
#   i * tamaño dato --> $t0
#   dir. base  * t0 --> $t1
###############################################################################
printvec:
    # PUSH $ra, $s0, $s1, $s2,-- > 4 * 4 = 16  que es multiplo de 8
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
    li $a0, 10
    syscall 


#     for (int i = 0; i < n; i++)
    li $s2, 0
for:
    bge $s2, $s1, for_fin

#         std::cout << v[i] << " ";
    mul $t0, $s2, sizeD
    add $t1, $s0, $t0
    l.d $f12, 0($t1)

    li $v0, 3
    syscall

    li $v0, 11
    li $a0, 32
    syscall

    addi $s2, $s2, 1
    b for

for_fin:

#     std::cout << "\n";
    li $v0, 11
    li $a0, 10
    syscall

#     return;

    # POP 
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16

    jr $ra
# }
printvec__MARCAFIN:

###############################################################################
# int ordenado(double* v, const int n) {
#
# Parámetros de entrada:
#   double* v --> $a0
#   const int n --> $a1
# Parámetros de salida
#   int resultado --> $v0
#
# NO hace uso de otras funciones --> NO modifica el $ra --> NO hace uso de pila
#
# Tabla de parámetros:
#   double* v --> $a0 --> $t0
#   const int n --> $a1 --> $t1
#   int resultado --> $v0 --> $t2
#   int i --> $t3
#   i * tamaño dato --> $t4
#   dir base * $t4 --> $t5 --> $f18
#   (i + 1) --> $t6
#   $t6 * tamaño dato --> $t6
#   dir base * $t6 --> $t7 --> $f16
#   n -1 --> $t8
###############################################################################
ordenado:
    move $t0, $a0
    move $t1, $a1

#     int resultado = 1;
    li $t2, 1

#     int i = 0;
    li $t3, 0

    # Guardamos en $t8 la condicion del while n - 1
    addi $t8, $t1, -1

#     while (i < n-1) {
while:
    bge $t3, $t8, while_fin

    # Accedemos a las posiciones de los vectores

    # v[i+1]
    addi $t6, $t3, 1
    mul $t6, $t6, sizeD
    add $t7, $t0, $t6
    l.d $f16, 0($t7)

    # v[i]
    mul $t4, $t3, sizeD
    add $t5, $t0, $t4
    l.d $f18, 0($t5) 
    
#         if (v[i+1] >= v[i]) {
if:
    c.lt.d $f16, $f18
    bc1t if_fin
#             resultado = 0;
    li $t2, 0
#             break;
    b while_fin
#         }
if_fin:
#         i++;
    addi $t3, $t3, 1
    b while
#     }
while_fin:

#     return resultado;
    move $v0, $t2

# }
    jr $ra

ordenado__MARCAFIN:

###############################################################################
# void merge(double* v1, const int n1,double* v2, const int n2) {
#
# Parámetros de entrada:
#   double *v1 --> $a0
#   const int n1 --> $a1
#   double* v2 --> $a2
#   const int n2 --> $a3
#
# Parámetros salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica el $ra --> SÍ hace uso de pila
#
# Tabla de variables:
#   double *v1 --> $a0 --> $s0
#   const int n1 --> $a1 --> $s1
#   double* v2 --> $a2 --> $s2
#   const int n2 --> $a3 --> $s3
#   int i --> $s4
#   int j --> $s5
#   v[i] --> $f20
#   v[j] --> $f22
#
#   int o1 --> $t0
#   int o2 --> $t1
#   i * tam dato --> $t2
#   dir base + $t2 --> $t3
#   j * tam dato --> $t4
#   dir base + $t4 --> $t5


###############################################################################
merge:
    # PUSH
    # $ra, $s0, $s1, $s2, $s3, $s4, $s5, $f20, $f22 --> 4 * 7 + 8 * 2 = 44
    # Para que sea multiplo de 8, necesitamos 48
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

#     if (o1 == 0) {
if_o1:
    bne $t0, $zero, if_o1_fin
#       std::cout << "Primer vector no ordenado. NO se puede mezclar\n";
    li $v0, 4 
    la $a0, cad51
    syscall

#       return;
    b return
#     }
if_o1_fin:

#     int o2 = ordenado(v2,n2);
    move $a0, $s2
    move $a1, $s3
    jal ordenado

    move $t1, $v0

#     if (o2 == 0) {
if_o2:
    bne $t1, $zero, if_o2_fin

#       std::cout << "Segundo vector no ordenado. NO se puede mezclar\n";
    li $v0, 4 
    la $a0, cad52
    syscall

#       return;
    b return

#     }
if_o2_fin:

#     int i = 0; // índice para recorrer el v1
    li $s4, 0

#     int j = 0; // índice para recorrer el v2
    li $s5, 0

#     while ( ( i < n1) && (j < n2) ) {
while_1:
    bge $s4, $s1, while_1_fin
    bge $s5, $s3, while_1_fin

    # Buscamos la posicion v1[i]
    mul $t2, $s4, sizeD
    add $t3, $s0, $t2
    l.d $f20, 0($t3)

    # Buscamos la posicion v2[j]
    mul $t4, $s5, sizeD
    add $t5, $s2, $t4
    l.d $f22, 0($t5)

#         if (v1[i] >= v2[j]) {
if_while_1:
    c.lt.d $f20, $f22
    bc1t if_while_1_fin

#             std::cout << v1[i] << ' ';
    li $v0, 3
    mov.d $f12, $f20
    syscall 

    li $v0, 11
    li $a0, 32
    syscall

#             i++;
    addi $s4, $s4, 1

    b while_1

#         }
if_while_1_fin:

#         else {
else_if_while:

#             std::cout << v2[j] << ' ';
    li $v0, 3
    mov.d $f12, $f22
    syscall

    li $v0, 11
    li $a0, 32
    syscall

#             j++;
    addi $s5, $s5, 1

    b while_1

#         }
else_if_while_fin:
    b while_1
#     }
while_1_fin:

#     while ( i < n1) {
while_2:
    bge $s4, $s1, while_2_fin

    # Buscamos la posicion v1[i]
    mul $t2, $s4, sizeD
    add $t3, $s0, $t2
    l.d $f20, 0($t3)

#         std::cout << v1[i] << ' ';
    li $v0, 3
    mov.d $f12, $f20
    syscall

    li $v0, 11
    li $a0, 32
    syscall

#         i++;
    addi $s4, $s4, 1
    b while_2

#     }
while_2_fin:

#     while ( j < n2) {
while_3:
    bge $s5, $s3, while_3_fin

    # Buscamos la posicion v2[j]
    mul $t4, $s5, sizeD
    add $t5, $s2, $t4
    l.d $f22, 0($t5)

#         std::cout << v2[j] << ' ';
    li $v0, 3
    mov.d $f12, $f22
    syscall

    li $v0, 11
    li $a0, 32
    syscall

#         j++;
    addi $s5, $s5, 1
    b while_3

#     }
while_3_fin:

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
    l.d $f20, 32($sp)
    l.d $f22, 40($sp)
    addi $sp, $sp, 48

    jr $ra

merge__MARCAFIN:




###############################################################################
# int main(void) {
# No hay parametros de entrada
# No hay parametros de salida
#
# SÍ llama a otras funciones --> SÍ modifica el $ra --> SÍ hace uso de la pila
#
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
    # POP
    lw $ra, 0($sp)
    addi $sp, $sp, 8

    jr $ra
# }
main__MARCAFIN: