# // Manejo de matrices con funciones
# Ricardo Jesús Rodríguez Pérez
# 24/06/2026

# #include <iostream>
# #include <iomanip>
# #include <tuple>

# typedef struct {
#   int nFil;
#   int nCol;
#   double elementos[];
# } structMat;


# structMat mat0 {
#   6,
#   6,
#   {
#     11.125, 12.125, 13.125, 14.125, 15.125, 16.125,
#     21.125, 22.125, 23.125, 24.125, 25.375, 26.375,
#     31.375, 32.375, 33.375, 34.375, 35.375, 36.375,
#     41.375, 42.375, 43.375, 44.375, 45.375, 46.375,
#     51.625, 52.625, 53.625, 54.625, 55.625, 56.625,
#     61.625, 62.625, 63.625, 64.625, 65.625, 66.625,

#   }
# };

# structMat mat1 {
#   10,
#   7,
#   {
#     -36.9375, -58.1875, 78.65625, 19.09375, -50.8125, 33.96875, -59.5625,
#     12.34375, 57.28125, -1.96875, -86.8125, -81.8125, 54.59375, -22.5625,
#     88.21875, 64.34375, 52.90625, 47.90625, -83.5625, 19.03125, 4.265625,
#     -31.9375, 82.53125, 27.40625, 56.53125, 39.46875, 18.40625, 97.03125,
#     76.90625, 14.59375, 67.78125, -9.84375, -97.9375, 32.34375, -18.4375,
#     -43.4375, 39.84375, 87.65625, -31.9375, -17.8125, 30.09375, 87.65625,
#     -6.90625, 64.59375, -85.0625, 70.53125, -48.8125, -62.6875, -60.1875,
#     -5.53125, 84.34375, -51.6875, 93.15625, -10.8125, 32.09375, 98.34375,
#     69.46875, 73.84375, 3.734375, 57.21875, -41.5625, -17.4375, -64.1875,
#     -71.3125, -97.9375, 7.109375, -79.0625, 33.84375, 63.53125, -96.1875,

#   }
# };

# structMat mat2 {
#   1,
#   8,
#   {
#     -36.75, 35.375, 79.125, -58.75, -55.25, -19.25, -88.75, -93.75,
#   }
# };

# structMat mat3 {
#   16,
#   1,
#   {
#     -90.75, -65.25, -58.25, -73.25, -89.25, -79.25, 16.875, 66.375,
#     -96.25, -97.25, -24.75, 5.3125, -33.75, -13.25, 27.125, -74.75,

#   }
# };

# structMat mat4 {
#   1,
#   1,
#   { 78.875 }
# };

# structMat mat5 {
#   0,
#   0,
#   { 0 }
# };

# #define NUM_MATRICES  6
# structMat* matrices[NUM_MATRICES]={&mat0, &mat1, &mat2, &mat3, &mat4, &mat5};

# void print_mat(structMat* mat) {
#   int nFil = mat->nFil;
#   int nCol = mat->nCol;
#   double* datos = mat->elementos;
#   std::cout << "\n\nLa matriz tiene dimension " << nFil
#       << 'x' << nCol << '\n';
#   for(int f = 0; f < nFil; f++) {
#     for(int c = 0; c < nCol; c++) {
#       std::cout << datos[f*nCol + c] << ' ';  // datos[f][c]
#     }
#     std::cout << '\n';
#   }
#   std::cout << '\n';
# }

# void change_elto(structMat* mat, int indF, int indC, double valor) {
#   int numCol = mat->nCol;
#   double* datos = mat->elementos;
#   datos[indF * numCol + indC] = valor;  // datos[indF][indC]
# }

# void swap(double* e1, double* e2) {
#   double temp1 = *e1;
#   double temp2 = *e2;
#   *e1 = temp2;
#   *e2 = temp1;
# }

# void intercambia(structMat* mat, int indF, int indC) {
#   int numCol = mat->nCol;
#   int numFil = mat->nFil;
#   double* datos = mat->elementos;
#   // e1 = &(datos[indF][indC]);
#   double* e1 = datos + (indF * numCol + indC);
#   int indFilaOpuesta = (numFil - indF - 1);
#   int indColOpuesta = (numCol - indC - 1);
#   // e1 = &(datos[indFilaOpuesta][indColOpuesta])
#   double* e2 = datos + (indFilaOpuesta * numCol + indColOpuesta);
#   swap(e1, e2);
# }

# void procesa_cols(structMat* mat, int indC1, int indC2) {
#   int numCol = mat->nCol;
#   int numFil = mat->nFil;
#   double* datos = mat->elementos;
#   for(int fa = 0; fa < numFil; fa++) {
#     // e1 = &(datos[fa][indC1]);
#     double* e1 = datos + (fa * numCol + indC1);
#     // e2 = &(datos[fa][indC2]);
#     double* e2 = datos + (fa * numCol + indC2);
#     double val1 = *e1;
#     double val2 = *e2;
#     if(val1 > val2) {
#       *e1 = val1 / 2.0;
#     } else {
#       swap(e1, e2);
#     }
#     *e2 = *e2 + 0.5625;
#   }
# }

# double find_max(structMat* mat) {
#   int numCol = mat->nCol;
#   int numFil = mat->nFil;
#   double* datos = mat->elementos;
#   double max = datos[0];
#   for(int f = 0; f < numFil; f++) {
#     for(int c = 0; c < numCol; c++) {
#       double valor = datos[f * numCol + c];  // datos[f][c]
#       if (valor > max) {
#         max = valor;
#         std::cout << "\nNuevo maximo " << max;
#       }
#     }
#   }
#   return max;
# }

# int leeFila(int numFilas) {
#   int indFil;
#   std::cin >> indFil;
#   if ((indFil < 0) || (indFil >= numFilas)) {
#     std::cout << "Error: Numero de fila incorrecto\n";
#     return -1;
#   }
#   return indFil;
# }

# int leeColumna(int numColumnas) {
#   int indCol;
#   std::cin >> indCol;
#   if ((indCol < 0) || (indCol >= numColumnas)){
#     std::cout << "Error: Numero de columna incorrecto\n";
#     return -1;
#   }
#   return indCol;
# }

# std::tuple<int, int> pideFilaYColumna(structMat* mat) {
#   std::cout << "\nIndice de fila: ";
#   int indFil = leeFila(mat->nFil);
#   if (indFil < 0) {
#     return {-1, -1};
#   }
#   std::cout << "Indice de columna: ";
#   int indCol = leeColumna(mat->nCol);
#   if (indCol < 0) {
#     return {-1, -1};
#   }
#   return {indFil, indCol};
# }

# int main() {
#   std::cout << std::setprecision(18); // Ignorar
#   std::cout << "\nComienza programa manejo matrices con funciones";

#   structMat* matTrabajo = matrices[0];
#   int opcion;
#   do {
#     print_mat(matTrabajo);
#     std::cout <<
#     "(0) Terminar el programa\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(3) Cambiar el valor de un elemento\n"
#     "(4) Intercambiar un elemento con su opuesto\n"
#     "(5) Procesa columnas\n"
#     "(7) Encuentra maximo\n"
#     "\nIntroduce opción elegida: ";

#     std::cin >> opcion;

#     int indFil;
#     int indCol;
#     switch (opcion) {
#       // Opción 0 //////////////////////////////////////////////////////////
#       case 0:
#         std::cout << "\nEligida opción de salir";
#         break; // salimos del switch
#       // Opción 1 //////////////////////////////////////////////////////////
#       case 1:
#         std::cout << "\nElije la matriz de trabajo: ";
#         int matT;
#         std::cin >> matT;
#         if ((matT < 0) || (matT >= NUM_MATRICES)) {
#           std::cout << "Numero de matriz de trabajo incorrecto\n";
#           break; // salimos del switch
#         }
#         matTrabajo = matrices[matT];
#         break; // salimos del switch

#       // Opción 3 //////////////////////////////////////////////////////////
#       case 3:
#         std::tie(indFil, indCol) = pideFilaYColumna(matTrabajo);
#         if (indFil < 0)
#           break; // salimos del switch
#         std::cout << "Nuevo valor para el elemento: ";
#         double valor;
#         std::cin >> valor;

#         change_elto(matTrabajo, indFil, indCol, valor);

#         break; // salimos del switch

#       // Opción 4 //////////////////////////////////////////////////////////
#       case 4:
#         std::tie(indFil, indCol) = pideFilaYColumna(matTrabajo);
#         if (indFil < 0)
#           break; // salimos del switch

#         intercambia(matTrabajo, indFil, indCol);

#         break; // salimos del switch

#       // Opción 5 //////////////////////////////////////////////////////////
#       case 5:
#         std::cout << "\nPrimera columna a procesar: ";
#         int indC1;
#         indC1 = leeColumna(matTrabajo->nCol);
#         if (indC1 < 0) {
#           break; // salimos del switch
#         }
#         std::cout << "Segunda columna a procesar: ";
#         int indC2;
#         indC2 = leeColumna(matTrabajo->nCol);
#         if (indC2 < 0) {
#           break;  // salimos del switch
#         }

#         procesa_cols(matTrabajo, indC1, indC2);
#         break;  // salimos del switch

#       // Opción 7 //////////////////////////////////////////////////////////
#       case 7:
#         double maximo;
#         maximo = find_max(matTrabajo);
#         std::cout << "\nEl valor maximo en la matriz es " << maximo;
#         break; // salimos del switch

#       default:
#         // Opción Incorrecta ////////////////////////////////////////////////
#         std::cout << "Error: opcion incorrecta\n";
#     }  // fin del switch
#     std::cout << "\nTerminada la opción " << opcion;
#   } while (opcion != 0);
#   std::cout << "\n\nTermina el programa\n";
# }
    .data
mat0:   .word 6, 6
    .double 11.125, 12.125, 13.125, 14.125, 15.125, 16.125
    .double 21.125, 22.125, 23.125, 24.125, 25.375, 26.375
    .double 31.375, 32.375, 33.375, 34.375, 35.375, 36.375
    .double 41.375, 42.375, 43.375, 44.375, 45.375, 46.375
    .double 51.625, 52.625, 53.625, 54.625, 55.625, 56.625
    .double 61.625, 62.625, 63.625, 64.625, 65.625, 66.625

mat1:   .word 10, 7
    .double -36.9375, -58.1875, 78.65625, 19.09375, -50.8125, 33.96875, -59.5625
    .double 12.34375, 57.28125, -1.96875, -86.8125, -81.8125, 54.59375, -22.5625
    .double 88.21875, 64.34375, 52.90625, 47.90625, -83.5625, 19.03125, 4.265625
    .double -31.9375, 82.53125, 27.40625, 56.53125, 39.46875, 18.40625, 97.03125
    .double 76.90625, 14.59375, 67.78125, -9.84375, -97.9375, 32.34375, -18.4375
    .double -43.4375, 39.84375, 87.65625, -31.9375, -17.8125, 30.09375, 87.65625
    .double -6.90625, 64.59375, -85.0625, 70.53125, -48.8125, -62.6875, -60.1875
    .double -5.53125, 84.34375, -51.6875, 93.15625, -10.8125, 32.09375, 98.34375
    .double 69.46875, 73.84375, 3.734375, 57.21875, -41.5625, -17.4375, -64.1875
    .double -71.3125, -97.9375, 7.109375, -79.0625, 33.84375, 63.53125, -96.1875

mat2:   .word 1, 8
    .double -36.75, 35.375, 79.125, -58.75, -55.25, -19.25, -88.75, -93.75

mat3:   .word 16, 1
    .double -90.75, -65.25, -58.25, -73.25, -89.25, -79.25, 16.875, 66.375
    .double -96.25, -97.25, -24.75, 5.3125, -33.75, -13.25, 27.125, -74.75

mat4:   .word 1, 1
    .double 78.875
mat5:   .word 0, 0
    .double 0.0

# #define NUM_MATRICES  6
NUM_MATRICES = 6
tamD=8  # tamaño de un double en bytes
tamP=4  # tamaño de una palabra (dirección) en bytes
nFil=0  # desplazamiento para acceder a nFil en la estructura
nCol=4  # desplazamiento para acceder a nCol en la estructura
elementos=8  # desplazamiento para acceder a elementos en la estructura
# structMat* matrices[NUM_MATRICES]={&mat0, &mat1, &mat2, &mat3, &mat4, &mat5};
matrices:       .word mat0, mat1, mat2, mat3, mat4, mat5
cadTitulo:      .asciiz "\nComienza programa manejo matrices con funciones"
cadMenu:        .ascii "(0) Terminar el programa\n"
                .ascii "(1) Cambiar la matriz de trabajo\n"
                .ascii "(3) Cambiar el valor de un elemento\n"
                .ascii "(4) Intercambiar un elemento con su opuesto\n"
                .ascii "(5) Procesa columnas\n"
                .ascii "(7) Encuentra maximo\n"
                .asciiz "\nIntroduce opción elegida: ";
cadDim:         .asciiz "\n\nLa matriz tiene dimension "
cadErrorFila:   .asciiz "Error: Numero de fila incorrecto\n"
cadErrorCol:    .asciiz "Error: Numero de columna incorrecto\n"
pideFila:       .asciiz "\nIndice de fila: "
pideCol:        .asciiz "Indice de columna: "
cadNuevoMax:    .asciiz "\nNuevo maximo "
cadSalir:       .asciiz "\nElegida opción de salir"
cadEligeMat:    .asciiz "\nElije la matriz de trabajo: "
cadErrorMat:    .asciiz "Numero de matriz de trabajo incorrecto\n"
cadNuevoValor:  .asciiz "Nuevo valor para el elemento: "
cadTerOpc:      .asciiz "\nTerminada la opción "
cadErrorOpcion: .asciiz "Error: opcion incorrecta\n"
cadPrimCol:     .asciiz "\nPrimera columna a procesar: "
cadSegCol:      .asciiz "Segunda columna a procesar: "
cadMax:         .asciiz "\nEl valor maximo en la matriz es "
cadFin:         .asciiz "\n\nTermina el programa\n"


.text

###############################################################################
# void print_mat(structMat* mat) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0
#   int nFil --> $s0
#   int nCol --> $s1
#   double* datos --> $s2
#   int f --> $s3
#   int c --> $s4
# 
#   datos --> $f12
#   variables para cálculos --> $t0
###############################################################################
print_mat:
    # PUSH --> $ra, $s0-$s4 = 4 * 6 = 24 --> multiplo de 8
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)

#   int nFil = mat->nFil;
    lw $s0, nFil($a0)

#   int nCol = mat->nCol;
    lw $s1, nCol($a0)

#   double* datos = mat->elementos;
    addi $s2, $a0, elementos

#   std::cout << "\n\nLa matriz tiene dimension " << nFil
    li $v0, 4
    la $a0, cadDim
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

#       << 'x' << nCol << '\n';
    li $v0, 11
    li $a0, 120
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    # Declaramos f = 0 antes de entrar en el bucle
    li $s3, 0

#   for(int f = 0; f < nFil; f++) {
for_f_print:
    bge $s3, $s0, for_f_print_fin

    # Declaramos c = 0 antes del bucle
    li $s4, 0

#     for(int c = 0; c < nCol; c++) {
for_c_print:
    bge $s4, $s1, for_c_print_fin

#       std::cout << datos[f*nCol + c] << ' ';  // datos[f][c]
    mul $t0, $s3, $s1
    add $t0, $t0, $s4
    mul $t0, $t0, tamD
    add $t0, $t0, $s2
    l.d $f12, 0($t0)

    li $v0, 3
    syscall

    li $v0, 11
    li $a0, 32
    syscall

    addi $s4, $s4, 1
    b for_c_print

#     }
for_c_print_fin:

#     std::cout << '\n';
    li $v0, 11
    li $a0, 10
    syscall

    addi $s3, $s3, 1
    b for_f_print

#   }
for_f_print_fin:

#   std::cout << '\n';
    li $v0, 11
    li $a0, 10
    syscall

# }
    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    addi $sp, $sp, 24

    jr $ra

print_mat__MARCAFIN:

###############################################################################
# void change_elto(structMat* mat, int indF, int indC, double valor) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int indF --> $a1
#   int indC --> $a2
#   double valor --> $f12
# Parámetros de salida: NINGUNO
#
# Función leaf --> NO modifica $ra --> NO hace uso de pila
#
# Tabla de parámetros:
#   int numCol --> $t0
#   double* datos --> $t1
#   Cálculos momentaneos --> $t2
###############################################################################
change_elto:
#   int numCol = mat->nCol;
    lw $t0, nCol($a0)

#   double* datos = mat->elementos;
    addi $t1, $a0, elementos

#   datos[indF * numCol + indC] = valor;  // datos[indF][indC]
    mul $t2, $a1, $t0
    add $t2, $t2, $a2
    mul $t2, $t2, tamD
    add $t2, $t2, $t1 
    s.d $f12, 0($t2)

# }
    jr $ra

change_elto__MARCAFIN:

###############################################################################
# void swap(double* e1, double* e2) {
#
# Parámetros de entrada:
#   double* e1 --> $a0
#   double* e2 --> $a1
# Parámetros de salida: NINGUNO
#
# Tabla de variables:
#   double* e1 --> $a0
#   double* e2 --> $a1
#   double temp1 --> $f4
#   double temp2 --> $f6
###############################################################################
swap:
#   double temp1 = *e1;
    l.d $f4, 0($a0)

#   double temp2 = *e2;
    l.d $f6, 0($a1)

#   *e1 = temp2;
    s.d $f6, 0($a0)

#   *e2 = temp1;
    s.d $f4, 0($a1)

# }
    jr $ra
swap__MARCAFIN:

###############################################################################
# void intercambia(structMat* mat, int indF, int indC) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int indF --> $a1
#   int indC --> $a2
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0
#   int indF --> $a1 --> $t0
#   int indC --> $a2 --> $t1
#   int numCol --> $t2
#   int numFil --> $t3
#   double* datos --> $t4
#   int indFilaOpuesta --> $t5
#   int indColOpuesta --> $t6
#   Cálculos momentáneos --> $t7

#   double* e1 --> $s0
#   double* e2 --> $s1
###############################################################################
intercambia:
    # PUSH --> $ra, $s0-$s5 --> 3 * 4 = 12 --> 16
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $t0, $a1
    move $t1, $a2

#   int numCol = mat->nCol;
    lw $t2, nCol($a0)

#   int numFil = mat->nFil;
    lw $t3, nFil($a0)

#   double* datos = mat->elementos;
    addi $t4, $a0, elementos

#   // e1 = &(datos[indF][indC]);
#   double* e1 = datos + (indF * numCol + indC);
    mul $t7, $t0, $t2
    add $t7, $t7, $t1
    mul $t7, $t7, tamD
    add $s0, $t4, $t7

#   int indFilaOpuesta = (numFil - indF - 1);
    sub $t7, $t3, $t0
    addi $t5, $t7, -1

#   int indColOpuesta = (numCol - indC - 1);
    sub $t7, $t2, $t1
    addi $t6, $t7, -1

#   // e1 = &(datos[indFilaOpuesta][indColOpuesta])
#   double* e2 = datos + (indFilaOpuesta * numCol + indColOpuesta);
    mul $t7, $t5, $t2
    add $t7, $t7, $t6
    mul $t7, $t7, tamD
    add $s1, $t4, $t7

#   swap(e1, e2);
    move $a0, $s0
    move $a1, $s1
    jal swap

# }

    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 16

    jr $ra

intercambia__MARCAFIN:

###############################################################################
# void procesa_cols(structMat* mat, int indC1, int indC2) {
#
# Parámetros de entrada: 
#   structMat* mat --> $a0
#   int indC1 --> $a1
#   int indC2 --> $a2
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0
#   int indC1 --> $a1 --> $s0
#   int indC2 --> $a2 --> $s1
#   int numCol --> $s2
#   int numFil --> $s3
#   double* datos --> $s4
#   int fa --> $s5
#   double *e2 --> $s6
#   
#   double *e1 --> $t0
#   Cálculos --> $t1
#   double val1 --> $f4
#   double val2 --> $f6
#   double 2.0 --> $f8
#   double 0.5625 --> $f10
###############################################################################  
procesa_cols:
  # PUSH: $ra, $s0-$s5 -> 8 * 4 = 32 --> 32 Multiplo de 8
    addi $sp, $sp, -32
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    sw $s6, 28($sp)

    move $s0, $a1
    move $s1, $a2

#   int numCol = mat->nCol;
    lw $s2, nCol($a0)

#   int numFil = mat->nFil;
    lw $s3, nFil($a0)

#   double* datos = mat->elementos;
    addi $s4, $a0, elementos

    # Declaramos fa = 0 antes del bucle
    li $s5, 0

#   for(int fa = 0; fa < numFil; fa++) {
for_procesa_cols:
    bge $s5, $s3, for_procesa_cols_fin

#     // e1 = &(datos[fa][indC1]);
#     double* e1 = datos + (fa * numCol + indC1);
    mul $t1, $s5, $s2
    add $t1, $t1, $s0
    mul $t1, $t1, tamD
    add $t0, $s4, $t1

#     // e2 = &(datos[fa][indC2]);
#     double* e2 = datos + (fa * numCol + indC2);
    mul $t1, $s5, $s2
    add $t1, $t1, $s1
    mul $t1, $t1, tamD
    add $s6, $s4, $t1

#     double val1 = *e1;
    l.d $f4, 0($t0)

#     double val2 = *e2;
    l.d $f6, 0($s6)

#     if(val1 > val2) {
if_procesa_cols:
    c.le.d $f4, $f6
    bc1t if_procesa_cols_fin

    li.d $f8, 2.0
#       *e1 = val1 / 2.0;
    l.d $f4, 0($t0)
    div.d $f4, $f4, $f8
    s.d $f4, 0($t0)

    b else_procesa_cols_fin

#     } else {
if_procesa_cols_fin:

else_procesa_cols:
#       swap(e1, e2);
    move $a0, $t0
    move $a1, $s6
    jal swap

#     }
else_procesa_cols_fin:
#     *e2 = *e2 + 0.5625;
    l.d $f6, 0($s6)
    li.d $f10, 0.5625
    add.d $f6, $f6, $f10
    s.d $f6, 0($s6)


    addi $s5, $s5, 1
    b for_procesa_cols

#   }
for_procesa_cols_fin:

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
    addi $sp, $sp, 32

    jr $ra

procesa_cols__MARCAFIN:

###############################################################################
# double find_max(structMat* mat) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida: 
#   double max --> $f0
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0
#   int numCol --> $s0
#   int numFil --> $s1
#   double* datos --> $s2
#   int f --> $s3
#   int c --> $s4
#
#   double max --> $f20
#
#   double valor --> $f4
#   temporales para calculos --> $t0
###############################################################################
find_max:
    # PUSH --> $ra, $s0-$s4, $f20 = 6 * 4 + 8 = 32 
    # Con 32, $f20 no entra --> 40
    addi $sp, $sp, -40
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    s.d $f20, 32($sp)

#   int numCol = mat->nCol;
    lw $s0, nCol($a0)

#   int numFil = mat->nFil;
    lw $s1, nFil($a0)

#   double* datos = mat->elementos;
    addi $s2, $a0, elementos

#   double max = datos[0];
    l.d $f20, 0($s2)

    # Inicializo f = 0 antes del bucle
    li $s3, 0

#   for(int f = 0; f < numFil; f++) {
for_f_find_max:
    bge $s3, $s1, for_f_find_max_fin

    # Inicializo c = 0 antes del bucle
    li $s4, 0

#     for(int c = 0; c < numCol; c++) {
for_c_find_max:
    bge $s4, $s0, for_c_find_max_fin

#       double valor = datos[f * numCol + c];  // datos[f][c]
    mul $t0, $s3, $s0
    add $t0, $t0, $s4
    mul $t0, $t0, tamD
    add $t0, $s2, $t0
    l.d $f4, 0($t0)

#       if (valor > max) {
if_c_find_max:
    c.le.d $f4, $f20
    bc1t if_c_find_max_fin

#         max = valor;
    mov.d $f20, $f4

#         std::cout << "\nNuevo maximo " << max;
    li $v0, 4
    la $a0, cadNuevoMax
    syscall

    li $v0, 3
    mov.d $f12, $f20
    syscall


#       }
if_c_find_max_fin:

    addi $s4, $s4, 1
    b for_c_find_max

#     }
for_c_find_max_fin:

    addi $s3, $s3, 1
    b for_f_find_max

#   }
for_f_find_max_fin:

#   return max;
    mov.d $f0, $f20

# }

    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    l.d $f20, 32($sp)
    addi $sp, $sp, 40

    jr $ra

find_max__MARCAFIN:

###############################################################################
# int leeFila(int numFilas) {
#
# Parámetros de entrada:
#   int numFilas --> $a0
# Parámetros de salida:
#   int indFil --> $v0
#
# Tabla de parámetros:
#   int numFilas --> $a0 --> $s0
#   int indFil --> $s1 --> $v0
###############################################################################
leeFila:
    # PUSH: $ra, $s0, $s1 = 3 * 4 = 12 --> 16
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0
    
#   int indFil;
#   std::cin >> indFil;
    li $v0, 5
    syscall
    move $s1, $v0

#   if ((indFil < 0) || (indFil >= numFilas)) {
if_lee_fila:
    blt $s1, 0, if_lee_fila_cuerpo
    bge $s1, $s0, if_lee_fila_cuerpo
    b if_lee_fila_fin

if_lee_fila_cuerpo:

#     std::cout << "Error: Numero de fila incorrecto\n";
    li $v0, 4
    la $a0, cadErrorFila
    syscall

#     return -1;
    li $s1, -1
if_lee_fila_cuerpo_fin:

#   }
if_lee_fila_fin:

#   return indFil;
    move $v0, $s1

# }
    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 16

    jr $ra

leeFila__MARCAFIN:

###############################################################################
# int leeColumna(int numColumnas) {
#
# Parámetros de entrada:
#   int numColumnas --> $a0
# Parámetros de salida:
#   int indCol --> $v0
#
# Tabla de parámetros:
#   int numColumnas --> $a0 --> $s0
#   int indCol --> $s1
###############################################################################
leeColumna:
    # PUSH: $ra, $s0, $s1 = 3 * 4 = 12 --> 16
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0

#   int indCol;
#   std::cin >> indCol;
    li $v0, 5
    syscall
    move $s1, $v0

#   if ((indCol < 0) || (indCol >= numColumnas)){
if_leeColumna:
    blt $s1, 0, if_leeColumna_cuerpo
    bge $s1, $s0, if_leeColumna_cuerpo
    b if_leeColumna_fin

if_leeColumna_cuerpo:

#     std::cout << "Error: Numero de columna incorrecto\n";
    li $v0, 4
    la $a0, cadErrorCol
    syscall

#     return -1;
    li $s1, -1
if_leeColumna_cuerpo_fin:

#   }
if_leeColumna_fin:

#   return indCol;
    move $v0, $s1

# }
    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 16

    jr $ra

leeColumna__MARCAFIN:

###############################################################################
# std::tuple<int, int> pideFilaYColumna(structMat* mat) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida:
#   indFil --> $v0
#   indCol --> $v1
#  
# SÍ llama a otrs fucniones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0 --> $s0
#   int indFil --> $s1
#   int indCol --> $s2
###############################################################################
pideFilaYColumna:
    # PUSH: $ra, $s0, $s1 = 4 * 4 = 16
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    move $s0, $a0

#   std::cout << "\nIndice de fila: ";
    li $v0, 4 
    la $a0, pideFila
    syscall

#   int indFil = leeFila(mat->nFil);
    lw $a0, nFil($s0)
    jal leeFila

    move $s1, $v0

#   if (indFil < 0) {
if_indFil_pideFilaYColumna:
    bge $s1, 0, if_indFil_pideFilaYColumna_fin
#     return {-1, -1};
    li $s1, -1
    li $s2, -1
    b return

#   }
if_indFil_pideFilaYColumna_fin:

#   std::cout << "Indice de columna: ";
    li $v0, 4
    la $a0, pideCol
    syscall

#   int indCol = leeColumna(mat->nCol);
    lw $a0, nCol($s0)
    jal leeColumna

    move $s2, $v0

#   if (indCol < 0) {
if_indCol_pideFilaYColumna:
    bge $s2, 0, if_indCol_pideFilaYColumna_fin

#     return {-1, -1};
    li $s1, -1
    li $s2, -1
    b return 

#   }
if_indCol_pideFilaYColumna_fin:

return:
#   return {indFil, indCol};
    move $v0, $s1
    move $v1, $s2

# }
    # POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16

    jr $ra

pideFilaYColumna__MARCAFIN:

###############################################################################
# int main() {
#
# Parámetros de entrada: NINGUNO
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* matTrabajo --> $s0
#   int opcion --> $s1
#   int indFil --> $s2
#   int indCol --> $s3
#   int indC1 --> $s4
#   int indC2 --> $s5
#
#   double maximo --> $f20
#
#   double valor --> $f4
#   matT --> $t0
#   calculos momentaneos --> $t1
###############################################################################
main:
    # PUSH 7 * 4 + 8 = 36 --> 40
    addi $sp, $sp, -40 
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    s.d $f20, 32($sp)


#   std::cout << std::setprecision(18); // Ignorar
#   std::cout << "\nComienza programa manejo matrices con funciones";
    li $v0, 4 
    la $a0, cadTitulo
    syscall

#   structMat* matTrabajo = matrices[0];
    la $t0, matrices
    lw $s0, 0($t0)

#   int opcion;

#   do {
main_doWhile:
#     print_mat(matTrabajo);
    move $a0, $s0
    jal print_mat

#     std::cout <<
#     "(0) Terminar el programa\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(3) Cambiar el valor de un elemento\n"
#     "(4) Intercambiar un elemento con su opuesto\n"
#     "(5) Procesa columnas\n"
#     "(7) Encuentra maximo\n"
#     "\nIntroduce opción elegida: ";
    li $v0, 4
    la $a0, cadMenu
    syscall

#     std::cin >> opcion;
    li $v0, 5
    syscall 
    move $s1, $v0

#     int indFil;
#     int indCol;
#     switch (opcion) {
main_switch:
    beq $s1, 0, case0
    beq $s1, 1, case1
    beq $s1, 3, case3
    beq $s1, 4, case4
    beq $s1, 5, case5
    beq $s1, 7, case7
    b caso_default

#       // Opción 0 //////////////////////////////////////////////////////////
#       case 0:
case0:
#         std::cout << "\nEligida opción de salir";
    li $v0, 4
    la $a0, cadSalir
    syscall

#         break; // salimos del switch
    b main_switch_fin
    
#       // Opción 1 //////////////////////////////////////////////////////////
#       case 1:
case1:
#         std::cout << "\nElije la matriz de trabajo: ";
    li $v0, 4
    la $a0, cadEligeMat
    syscall

#         int matT;
#         std::cin >> matT;
    li $v0, 5
    syscall
    move $t0, $v0

#         if ((matT < 0) || (matT >= NUM_MATRICES)) {
if_case1:
    blt $t0, 0, if_case1_cuerpo
    bge $t0, NUM_MATRICES, if_case1_cuerpo
    b if_case1_cuerpo_fin

if_case1_cuerpo:
#           std::cout << "Numero de matriz de trabajo incorrecto\n";
    li $v0, 4
    la $a0, cadErrorMat
    syscall

#           break; // salimos del switch
    b main_switch_fin

#         }
if_case1_cuerpo_fin:

#         matTrabajo = matrices[matT];
    la $t1, matrices
    mul $t2, $t0, tamP
    add $t2, $t1, $t2
    lw $s0, 0($t2)

#         break; // salimos del switch
    b main_switch_fin

#       // Opción 3 //////////////////////////////////////////////////////////
#       case 3:
case3:
#         std::tie(indFil, indCol) = pideFilaYColumna(matTrabajo);
    move $a0, $s0
    jal pideFilaYColumna

    move $s2, $v0
    move $s3 $v1

#         if (indFil < 0)
#           break; // salimos del switch
if_case3:
    blt $s2, 0, main_switch_fin
if_case3_fin:

#         std::cout << "Nuevo valor para el elemento: ";
    li $v0, 4
    la $a0, cadNuevoValor
    syscall

#         double valor;
#         std::cin >> valor;
    li $v0, 7
    syscall
    mov.d $f4, $f0

#         change_elto(matTrabajo, indFil, indCol, valor);
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    mov.d $f12, $f4
    jal change_elto

#         break; // salimos del switch
    b main_switch_fin

#       // Opción 4 //////////////////////////////////////////////////////////
#       case 4:
case4:
#         std::tie(indFil, indCol) = pideFilaYColumna(matTrabajo);
    move $a0, $s0
    jal pideFilaYColumna

    move $s2, $v0
    move $s3, $v1

#         if (indFil < 0)
#           break; // salimos del switch
if_case4:
    blt $s2, 0, main_switch_fin
if_case4_fin:

#         intercambia(matTrabajo, indFil, indCol);
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    jal intercambia

#         break; // salimos del switch
    b main_switch_fin

#       // Opción 5 //////////////////////////////////////////////////////////
#       case 5:
case5:
#         std::cout << "\nPrimera columna a procesar: ";
    li $v0, 4
    la $a0, cadPrimCol
    syscall

#         int indC1;
#         indC1 = leeColumna(matTrabajo->nCol);
    lw $a0, nCol($s0)
    jal leeColumna
    move $s4, $v0

#         if (indC1 < 0) {
#           break; // salimos del switch
#         }
if_C1:
    blt $s4, 0, main_switch_fin
if_C1_fin:

#         std::cout << "Segunda columna a procesar: ";
    li $v0, 4
    la $a0, cadSegCol
    syscall

#         int indC2;
#         indC2 = leeColumna(matTrabajo->nCol);
    lw $a0, nCol($s0)
    jal leeColumna
    move $s5, $v0

#         if (indC2 < 0) {
#           break;  // salimos del switch
#         }
if_C2:
    blt $s5, 0, main_switch_fin
if_C2_fin:

#         procesa_cols(matTrabajo, indC1, indC2);
    move $a0, $s0
    move $a1, $s4
    move $a2, $s5
    jal procesa_cols

#         break;  // salimos del switch
    b main_switch_fin

#       // Opción 7 //////////////////////////////////////////////////////////
#       case 7:
case7:
#         double maximo;
#         maximo = find_max(matTrabajo);
    move $a0, $s0
    jal find_max
    mov.d $f20, $f0

#         std::cout << "\nEl valor maximo en la matriz es " << maximo;
    li $v0, 4
    la $a0, cadMax
    syscall

    li $v0, 3
    mov.d $f12, $f20
    syscall

#         break; // salimos del switch
    b main_switch_fin

#       default:
caso_default:
#         // Opción Incorrecta ////////////////////////////////////////////////
#         std::cout << "Error: opcion incorrecta\n";
    li $v0, 4
    la $a0, cadErrorOpcion
    syscall

#     }  // fin del switch
main_switch_fin:

#     std::cout << "\nTerminada la opción " << opcion;
    li $v0, 4
    la $a0, cadTerOpc
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

#   } while (opcion != 0);
    bne $s1, 0, main_doWhile

main_doWhile_fin:

#   std::cout << "\n\nTermina el programa\n";
    li $v0, 4
    la $a0, cadFin
    syscall

# }

    #POP
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    l.d $f20, 32($sp)
    addi $sp, $sp, 40 

    jr $ra

main__MARCAFIN: