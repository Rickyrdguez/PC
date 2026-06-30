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
# Parámetros de entrada:
#   double* v --> $a0
#   const int n --> $a1
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica el $ra --> SÍ hace uso de pila
#
# Tabla de variables a registros:
#   double *v -->$a0 -->$s0
#   const int n --> $a1 --> $s1
#   int i --> $s2
#   double v[i] --> $f12
###############################################################################
printvec:
    # PUSH $ra, $s0, $s1, $s2. Reservamos 16 bytes, para que sea múltiplo de 8
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    move $s0, $a0
    move $s1, $a1

#     std:: << "\nVector con dimension " 
    li $v0, 4
    la $a0, cad1
    syscall
#   << n 
    li $v0, 1 
    move $a0, $s1
    syscall
#   << '\n';
    li $v0, 11
    li $a0, 10
    syscall

#   inicializamos i = 0 antes de entrar en el bucle
    li $s2, 0

for:
#     for (int i = 0; i < n; i++)
    bge $s2, $s1, for_fin
#         std::cout << v[i] << " ";

    # Accedemos a la posicion del vector
    mul $t0, $s2, sizeD
    add $t1, $s0, $t0

    l.d $f12, 0($t1)
    # Mostramos por pantalla
    li $v0, 3
    syscall

    li $v0, 11
    li $a0, 32
    syscall

    addi $s2, $s2,  1
    b for
for_fin:

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


###############################################################################
# int ordenado(double* v, const int n) {
# Variables de entrada:
#   double* v --> $a0
#   cons int n --> $a1
# Variables de salida: resultado --> $v0
#
# Función LEAF --> No hace uso de pila
#
# Tabla de variables 
#   double *v --> $t0
#   const int n --> $t1
#   int resultado --> $t2
#   int i --> $t3
#   int n-1 --> $t4
#   v[i+1] --> $t5
#   double v --> $f4
###############################################################################
ordenado:
    move $t0, $a0
    move $t1, $a1

#     int resultado = 1;
    li $t2, 1
#     int i = 0;
    li $t3, 0

#     while (i < n-1) {
    # Declaramos n-1 antes del while
    addi $t4, $t1, -1
while:
    bge $t3, $t4, while_fin

    # Accedemos a las posiciones de los vectores antes de compararlos:
    # v[i]
    mul $t5, $t3, sizeD
    add $t6, $t0, $t5 
    l.d $f4, 0($t6)

    #v[i + 1]
    addi $t7, $t6, 8
    l.d $f6, 0($t7)

#         if (v[i+1] >= v[i]) {
if:
    c.lt.d $f6, $f4
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

    jr $ra
# }
ordenado__MARCAFIN:

###############################################################################
# void merge(double* v1, const int n1,double* v2, const int n2) {
# Parámetros de entrada: 
#   double* v1 --> $a0
#   const int n1 --> $a1    
#   double* v2 --> $a2
#   const int n2 --> $a3 
# NO tiene parámetros de salida
#
# SÍ llama a otras funciones --> SÍ hace uso de pila --> si modifica el $ra
#
# Tabla de variables:
#   double* v1 --> $a0 --> $s0
#   const int n1 --> $a1 --> $s1
#   double* v2 --> $a2 --> $s2
#   const int n2 --> $a3 --> $s3
#   int i --> $s4
#   int j --> $s5
#   double v1 --> $f20
#   double v2 --> $f22
#   int o1 --> $t0
#   int o2 --> $t1
#   i * tamaño dato --> $t2
#   dir base * $t2 --> $t3
#   j * tamaño dato --> $t4
#   dir base * $t4 --> $t5
###############################################################################
merge:
    # PUSH --> $ra, $s0-$s5, $f20, $f22 --> necesitamos 44 bytes
    # Necesitamos 48 bytes 
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

    # Guardamos los datos usados por la función en la pila
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
    j return 
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
    j return

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

#         if (v1[i] >= v2[j]) { 
    # $f20 es v2, $s4 es i, $f22 es v2, $s5 es j
    mul $t2, $s4, sizeD
    add $t3, $t2, $s0
    l.d $f20, 0($t3)

    #  Calculamos ahora v2[j]
    mul $t4, $s5, sizeD
    add $t5, $t4, $s2
    l.d $f22, 0($t5)
     
if_while:
    c.lt.d $f20, $f22
    bc1t else
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
if_while_fin:

#         else {
else:
#             std::cout << v2[j] << ' ';
    li $v0, 3 
    mov.d $f12, $f22
    syscall

    li $v0, 11
    li $a0, 32
    syscall

#             j++;
    addi $s5, $s5, 1

#         }
else_fin:

    b while_1
#     }
while_1_fin:

#     while ( i < n1) {
while_2:
    bge $s4, $s1, while_2_fin

#         std::cout << v1[i] << ' ';
    mul $t2, $s4, sizeD
    add $t3, $t2, $s0
    l.d $f20, 0($t3)

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

#         std::cout << v2[j] << ' ';
    mul $t4, $s5, sizeD
    add $t5, $t4, $s2
    l.d $f22, 0($t5)

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
# }
merge__MARCAFIN:


###############################################################################
# int main(void) {
# Parámetros de entrada --> No tiene
# Parámetros de saldia --> No tiene
#
# SÍ hace uso de pila --> SÍ modifica el $ra
###############################################################################
main:
    # PUSH --> $ra
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