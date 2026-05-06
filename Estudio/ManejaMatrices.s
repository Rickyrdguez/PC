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

################################################################################
# void swap(double* e1, double* e2) {
# Parámetros de entrada:
#   double* e1 --> $a0
#   double* e2 --> $a1
# Parámetros de salida: NINGUNO
#
# No llama a otra función --> no se modifica $ra. NO NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   double temp1 --> $f18
#   double temp2 --> $f10
################################################################################
swap:
# double temp1 = *e1;
    l.d  $f18, 0($a0)
# double temp2 = *e2;
    l.d  $f10, 0($a1)
# *e1 = temp2;
    s.d  $f10, 0($a0)
# *e2 = temp1;
    s.d  $f18, 0($a1)

# }
    jr   $ra

swap__MARCAFIN:

################################################################################
# void print_mat(structMat* mat) {
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida: NINGUNO
#
# Llama a otras funciones (syscall) --> NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   structMat* mat --> $s0
#   int nFil       --> $s1
#   int nCol       --> $s2
#   double* datos  --> $s3
#   int f          --> $s4
#   int c          --> $s5
################################################################################
print_mat:
    # PUSH $ra, $s0, $s1, $s2, $s3, $s4, $s5
    # Reservamos 32 bytes (Múltiplo de 8) para no desalinear la memoria
    addi $sp, $sp, -32
    sw   $ra, 28($sp)
    sw   $s0, 24($sp)
    sw   $s1, 20($sp)
    sw   $s2, 16($sp)
    sw   $s3, 12($sp)
    sw   $s4, 8($sp)
    sw   $s5, 4($sp)

    move $s0, $a0

#   int nFil = mat->nFil;
    lw   $s1, 0($s0)        # nFil está en el offset 0 de la estructura

#   int nCol = mat->nCol;
    lw   $s2, 4($s0)        # nCol está en el offset 4

#   double* datos = mat->elementos;
    addi $s3, $s0, 8        # Los datos (doubles) empiezan en el offset 8

#   std::cout << "\n\nLa matriz tiene dimension "
    li   $v0, 4
    la   $a0, cadDim
    syscall

#   << nFil
    li   $v0, 1
    move $a0, $s1
    syscall

#   << 'x'
    li   $v0, 11
    li   $a0, 120           # 120 es el código ASCII de la letra 'x'
    syscall

#   << nCol
    li   $v0, 1
    move $a0, $s2
    syscall

#   << '\n'
    li   $v0, 11
    li   $a0, 10            # 10 es el código ASCII del salto de línea '\n'
    syscall

#   for(int f = 0; f < nFil; f++) {
    li   $s4, 0
print_mat_bucleF:
    bge  $s4, $s1, print_mat_bucleF_fin

#     for(int c = 0; c < nCol; c++) {
        li   $s5, 0
print_mat_bucleC:
        bge  $s5, $s2, print_mat_bucleC_fin

#       std::cout << datos[f*nCol + c] << ' ';  // datos[f][c]
        mul  $t0, $s4, $s2        # t0 = f * nCol
        add  $t0, $t0, $s5        # t0 = f * nCol + c
        sll  $t0, $t0, 3          # t0 *= 8 (porque cada double ocupa 8 bytes)
        add  $t0, $s3, $t0        # t0 = dirección base + offset calculada
        
        l.d  $f12, 0($t0)         # Cargamos el valor double a imprimir
        
        li   $v0, 3               # Función 3 imprime double
        syscall

        li   $v0, 11
        li   $a0, 32              # 32 es el código ASCII del espacio ' '
        syscall

#       c++
        addi $s5, $s5, 1
        b    print_mat_bucleC

print_mat_bucleC_fin:
#     std::cout << '\n';
        li   $v0, 11
        li   $a0, 10              # Salto de línea al terminar la columna
        syscall

#     f++
    addi $s4, $s4, 1
    b    print_mat_bucleF

print_mat_bucleF_fin:
#   std::cout << '\n';
    li   $v0, 11
    li   $a0, 10
    syscall

    # POP $ra, $s0, $s1, $s2, $s3, $s4, $s5
    lw   $ra, 28($sp)
    lw   $s0, 24($sp)
    lw   $s1, 20($sp)
    lw   $s2, 16($sp)
    lw   $s3, 12($sp)
    lw   $s4, 8($sp)
    lw   $s5, 4($sp)
    addi $sp, $sp, 32           # Devolvemos el mismo espacio a la pila

# }
    jr   $ra

print_mat__MARCAFIN:

################################################################################
# void change_elto(structMat* mat, int indF, int indC, double valor) {
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int indF       --> $a1
#   int indC       --> $a2
#   double valor   --> $f12
# Parámetros de salida: NINGUNO
#
# No llama a otra función --> no se modifica $ra. NO NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   int numCol    --> $t0
#   double* datos --> $t1
#   int offset    --> $t2
################################################################################
change_elto:
#   int numCol = mat->nCol;
    lw   $t0, nCol($a0)

#   double* datos = mat->elementos;
    addi $t1, $a0, elementos

#   datos[indF * numCol + indC] = valor;  // datos[indF][indC]
    mul  $t2, $a1, $t0        # t2 = indF * numCol
    add  $t2, $t2, $a2        # t2 = indF*numCol + indC
    sll  $t2, $t2, 3          # t2 *= 8 (tamaño double)
    add  $t2, $t1, $t2        # t2 = &datos[indF*numCol+indC]
    s.d  $f12, 0($t2)

# }
    jr   $ra

change_elto__MARCAFIN:

################################################################################
# void intercambia(structMat* mat, int indF, int indC) {
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int indF       --> $a1
#   int indC       --> $a2
# Parámetros de salida: NINGUNO
#
# Llama a swap --> NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   structMat* mat     --> $s0
#   int numCol         --> $s1
#   int numFil         --> $s2
#   double* datos      --> $s3
#   double* e1         --> $s4
#   int indFilaOpuesta --> $s5
#   int indColOpuesta  --> $s6
#   double* e2         --> $s7
#   int indF           --> guardado en pila via $a1 antes de usarse
################################################################################
intercambia:
    # PUSH $ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7 : 9 * 4 = 36
    addi $sp, $sp, -36
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)
    sw   $s3, 16($sp)
    sw   $s4, 20($sp)
    sw   $s5, 24($sp)
    sw   $s6, 28($sp)
    sw   $s7, 32($sp)

    move $s0, $a0             # mat --> $s0
    move $s5, $a1             # indF --> $s5 (temporal, luego pasa a ser indFilaOpuesta)
    move $s6, $a2             # indC --> $s6 (temporal, luego pasa a ser indColOpuesta)

#   int numCol = mat->nCol;
    lw   $s1, nCol($s0)

#   int numFil = mat->nFil;
    lw   $s2, nFil($s0)

#   double* datos = mat->elementos;
    addi $s3, $s0, elementos

#   // e1 = &(datos[indF][indC]);
#   double* e1 = datos + (indF * numCol + indC);
    mul  $t0, $s5, $s1        # t0 = indF * numCol
    add  $t0, $t0, $s6        # t0 = indF*numCol + indC
    sll  $t0, $t0, 3          # t0 *= 8
    add  $s4, $s3, $t0        # s4 = e1

#   int indFilaOpuesta = (numFil - indF - 1);
    sub  $t0, $s2, $s5
    addi $t0, $t0, -1
    move $s5, $t0             # s5 = indFilaOpuesta

#   int indColOpuesta = (numCol - indC - 1);
    sub  $t0, $s1, $s6
    addi $t0, $t0, -1
    move $s6, $t0             # s6 = indColOpuesta

#   // e2 = &(datos[indFilaOpuesta][indColOpuesta])
#   double* e2 = datos + (indFilaOpuesta * numCol + indColOpuesta);
    mul  $t0, $s5, $s1        # t0 = indFilaOpuesta * numCol
    add  $t0, $t0, $s6        # t0 += indColOpuesta
    sll  $t0, $t0, 3          # t0 *= 8
    add  $s7, $s3, $t0        # s7 = e2

#   swap(e1, e2);
    move $a0, $s4
    move $a1, $s7
    jal  swap

    # POP $ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7 : 9 * 4 = 36
    lw   $ra, 0($sp)
    lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    lw   $s2, 12($sp)
    lw   $s3, 16($sp)
    lw   $s4, 20($sp)
    lw   $s5, 24($sp)
    lw   $s6, 28($sp)
    lw   $s7, 32($sp)
    addi $sp, $sp, 36

# }
    jr   $ra

intercambia__MARCAFIN:

################################################################################
# void procesa_cols(structMat* mat, int indC1, int indC2) {
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int indC1      --> $a1
#   int indC2      --> $a2
# Parámetros de salida: NINGUNO
#
# Llama a swap --> NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   int numCol    --> $s1
#   int numFil    --> $s2
#   double* datos --> $s3
#   int indC1     --> $s4
#   int indC2     --> $s5
#   int fa        --> $s6
#   double* e1    --> $s7
#   double* e2    --> $s0  
#   double val1   --> $f20  
#   double val2   --> $f22
################################################################################
procesa_cols:
    # PUSH $ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7, $f20, $f22, $f24
    # Reservamos 64 bytes (múltiplo de 8) para alinear la memoria
    addi $sp, $sp, -64
    sw   $ra, 60($sp)
    sw   $s0, 56($sp)
    sw   $s1, 52($sp)
    sw   $s2, 48($sp)
    sw   $s3, 44($sp)
    sw   $s4, 40($sp)
    sw   $s5, 36($sp)
    sw   $s6, 32($sp)
    sw   $s7, 28($sp)
    # Por convenio, guardamos los f20-f31 que usemos
    s.d  $f20, 16($sp)
    s.d  $f22, 8($sp)
    s.d  $f24, 0($sp)

#   int numCol = mat->nCol;
    lw   $s1, 4($a0)

#   int numFil = mat->nFil;
    lw   $s2, 0($a0)

#   double* datos = mat->elementos;
    addi $s3, $a0, 8

#   int indC1 --> $s4,  int indC2 --> $s5
    move $s4, $a1
    move $s5, $a2

#   for(int fa = 0; fa < numFil; fa++) {
    li   $s6, 0
procesa_cols_bucleFa:
    bge  $s6, $s2, procesa_cols_bucleFa_fin

#     // e1 = &(datos[fa][indC1]);
#     double* e1 = datos + (fa * numCol + indC1);
        mul  $t0, $s6, $s1        # t0 = fa * numCol
        add  $t0, $t0, $s4        # t0 = fa*numCol + indC1
        sll  $t0, $t0, 3          # t0 *= 8
        add  $s7, $s3, $t0        # s7 = e1

#     // e2 = &(datos[fa][indC2]);
#     double* e2 = datos + (fa * numCol + indC2);
        mul  $t1, $s6, $s1        # t1 = fa * numCol
        add  $t1, $t1, $s5        # t1 = fa*numCol + indC2
        sll  $t1, $t1, 3          # t1 *= 8
        add  $s0, $s3, $t1        # s0 = e2  

#     double val1 = *e1;
        l.d  $f20, 0($s7)

#     double val2 = *e2;
        l.d  $f22, 0($s0)

#     if(val1 > val2) {
        c.le.d $f20, $f22         # val1 <= val2?
        bc1t procesa_cols_else

#       *e1 = val1 / 2.0;
        li.d $f4, 2.0
        div.d $f20, $f20, $f4
        s.d  $f20, 0($s7)
        b    procesa_cols_if_fin

#     } else {
procesa_cols_else:
#       swap(e1, e2);
        move $a0, $s7
        move $a1, $s0
        jal  swap

procesa_cols_if_fin:
#     *e2 = *e2 + 0.5625;
        l.d  $f24, 0($s0)
        li.d $f4, 0.5625
        add.d $f24, $f24, $f4
        s.d  $f24, 0($s0)

#     fa++
        addi $s6, $s6, 1
        b    procesa_cols_bucleFa

procesa_cols_bucleFa_fin:

    # POP - Restauramos todos los registros al valor original
    lw   $ra, 60($sp)
    lw   $s0, 56($sp)
    lw   $s1, 52($sp)
    lw   $s2, 48($sp)
    lw   $s3, 44($sp)
    lw   $s4, 40($sp)
    lw   $s5, 36($sp)
    lw   $s6, 32($sp)
    lw   $s7, 28($sp)
    l.d  $f20, 16($sp)
    l.d  $f22, 8($sp)
    l.d  $f24, 0($sp)
    addi $sp, $sp, 64

# }
    jr   $ra

procesa_cols__MARCAFIN:

################################################################################
# double find_max(structMat* mat) {
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida:
#   double max     --> $f0
#
# Llama a syscall de impresión (que modifica $a0) --> NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   int numCol    --> $s1
#   int numFil    --> $s2
#   double* datos --> $s3
#   double max    --> $f20    (Evitamos $f2x para no romper el convenio)
#   int f         --> $s4
#   int c         --> $s5
#   double valor  --> $f22
################################################################################
find_max:
    # PUSH $ra, $s1, $s2, $s3, $s4, $s5, $f20, $f22
    # Reservamos 40 bytes en la pila (múltiplo de 8)
    addi $sp, $sp, -40
    sw   $ra, 36($sp)
    sw   $s1, 32($sp)
    sw   $s2, 28($sp)
    sw   $s3, 24($sp)
    sw   $s4, 20($sp)
    sw   $s5, 16($sp)
    s.d  $f20, 8($sp)
    s.d  $f22, 0($sp)

#   int numCol = mat->nCol;
    lw   $s1, 4($a0)

#   int numFil = mat->nFil;
    lw   $s2, 0($a0)

#   double* datos = mat->elementos;
    addi $s3, $a0, 8

#   double max = datos[0];
    l.d  $f20, 0($s3)

#   for(int f = 0; f < numFil; f++) {
    li   $s4, 0
find_max_bucleF:
    bge  $s4, $s2, find_max_bucleF_fin

#     for(int c = 0; c < numCol; c++) {
        li   $s5, 0
find_max_bucleC:
        bge  $s5, $s1, find_max_bucleC_fin

#       double valor = datos[f * numCol + c];  // datos[f][c]
        mul  $t0, $s4, $s1        # t0 = f * numCol
        add  $t0, $t0, $s5        # t0 = f*numCol + c
        sll  $t0, $t0, 3          # t0 *= 8
        add  $t0, $s3, $t0        # t0 = &datos[f*numCol+c]
        l.d  $f22, 0($t0)

#       if (valor > max) {
        c.le.d $f22, $f20         # ¿valor <= max?
        bc1t find_max_if_fin      # Si es menor o igual, saltamos al final del if

#         max = valor;
        mov.d $f20, $f22

#         std::cout << "\nNuevo maximo " << max;
        li   $v0, 4
        la   $a0, cadNuevoMax
        syscall

        mov.d $f12, $f20
        li   $v0, 3               # 3 es para imprimir double
        syscall

find_max_if_fin:
#       c++
        addi $s5, $s5, 1
        b    find_max_bucleC

find_max_bucleC_fin:
#     f++
    addi $s4, $s4, 1
    b    find_max_bucleF

find_max_bucleF_fin:
#   return max;
    mov.d $f0, $f20

    # POP $ra, $s1, $s2, $s3, $s4, $s5, $f20, $f22
    lw   $ra, 36($sp)
    lw   $s1, 32($sp)
    lw   $s2, 28($sp)
    lw   $s3, 24($sp)
    lw   $s4, 20($sp)
    lw   $s5, 16($sp)
    l.d  $f20, 8($sp)
    l.d  $f22, 0($sp)
    addi $sp, $sp, 40

# }
    jr   $ra

find_max__MARCAFIN:

################################################################################
# int leeFila(int numFilas) {
# Parámetros de entrada:
#   int numFilas --> $a0
# Parámetros de salida:
#   int indFil   --> $v0  (-1 si error)
#
# syscall 5 destruye $a0 y $t* --> guardamos numFilas en pila
# NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   int numFilas --> pila (offset 0)
#   int indFil   --> $v0
################################################################################
leeFila:
    # PUSH $ra, numFilas : 2 * 4 = 8
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)          # guardamos numFilas en la pila

#   std::cin >> indFil;
    li   $v0, 5
    syscall                   # $v0 = indFil leído

#   recuperamos numFilas de la pila (syscall destruyó $a0 y $t*)
    lw   $a0, 0($sp)

#   if (indFil < 0) --> error
    blt  $v0, $zero, leeFila__error

#   if (indFil >= numFilas) --> error
    bge  $v0, $a0, leeFila__error

#   return indFil;  ($v0 ya tiene el valor correcto)
    b    leeFila__retorno

leeFila__error:
#     std::cout << "Error: Numero de fila incorrecto\n";
    li   $v0, 4
    la   $a0, cadErrorFila
    syscall

#     return -1;
    li   $v0, -1

leeFila__retorno:
    # POP $ra, numFilas
    lw   $ra, 4($sp)
    addi $sp, $sp, 8

# }
    jr   $ra

leeFila__MARCAFIN:

################################################################################
# int leeColumna(int numColumnas) {
# Parámetros de entrada:
#   int numColumnas --> $a0
# Parámetros de salida:
#   int indCol      --> $v0  (-1 si error)
#
# syscall 5 destruye $a0 y $t* --> guardamos numColumnas en pila
# NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   int numColumnas --> pila (offset 0)
#   int indCol      --> $v0
################################################################################
leeColumna:
    # PUSH $ra, numColumnas : 2 * 4 = 8
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)          # guardamos numColumnas en la pila

#   std::cin >> indCol;
    li   $v0, 5
    syscall                   # $v0 = indCol leído

#   recuperamos numColumnas de la pila (syscall destruyó $a0 y $t*)
    lw   $a0, 0($sp)

#   if (indCol < 0) --> error
    blt  $v0, $zero, leeColumna__error

#   if (indCol >= numColumnas) --> error
    bge  $v0, $a0, leeColumna__error

#   return indCol;  ($v0 ya tiene el valor correcto)
    b    leeColumna__retorno

leeColumna__error:
#     std::cout << "Error: Numero de columna incorrecto\n";
    li   $v0, 4
    la   $a0, cadErrorCol
    syscall

#     return -1;
    li   $v0, -1

leeColumna__retorno:
    # POP $ra, numColumnas
    lw   $ra, 4($sp)
    addi $sp, $sp, 8

# }
    jr   $ra

leeColumna__MARCAFIN:

################################################################################
# std::tuple<int,int> pideFilaYColumna(structMat* mat) {
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida:
#   int indFil     --> $v0  (-1 si error)
#   int indCol     --> $v1  (-1 si error)
#
# Llama a leeFila y leeColumna --> NECESITA USAR LA PILA
#
# Tabla de variables a registros:
#   structMat* mat --> $s0
#   int indFil     --> $s1
################################################################################
pideFilaYColumna:
    # PUSH $ra, $s0, $s1 : 3 * 4 = 12
    addi $sp, $sp, -12
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)

    move $s0, $a0

#   std::cout << "\nIndice de fila: ";
    li   $v0, 4
    la   $a0, pideFila
    syscall

#   int indFil = leeFila(mat->nFil);
    lw   $a0, nFil($s0)
    jal  leeFila
    move $s1, $v0

#   if (indFil < 0) {
    bge  $s1, $zero, pideFilaYColumna__filaOk

#     return {-1, -1};
    li   $v0, -1
    li   $v1, -1
    b    pideFilaYColumna__fin

pideFilaYColumna__filaOk:
#   std::cout << "Indice de columna: ";
    li   $v0, 4
    la   $a0, pideCol
    syscall

#   int indCol = leeColumna(mat->nCol);
    lw   $a0, nCol($s0)
    jal  leeColumna

#   if (indCol < 0) {
    bge  $v0, $zero, pideFilaYColumna__colOk

#     return {-1, -1};
    li   $v0, -1
    li   $v1, -1
    b    pideFilaYColumna__fin

pideFilaYColumna__colOk:
#   return {indFil, indCol};
    move $v1, $v0             # indCol --> $v1
    move $v0, $s1             # indFil --> $v0

pideFilaYColumna__fin:
    # POP $ra, $s0, $s1 : 3 * 4 = 12
    lw   $ra, 0($sp)
    lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    addi $sp, $sp, 12

# }
    jr   $ra

pideFilaYColumna__MARCAFIN:



################################################################################
# double suma_diagonal(structMat* mat) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0   
# 
# Parámetros de salida: salida
#
# No llama a otra función --> no modifica el $ra --> NO USA LA PILA
#
# Tabla de variables de registros:
#   int nFil --> $t0
#   int nCol --> $t1
#   double* datos --> $t2
#   float suma --> $f0
#   float valor --> $f2
#   int i --> $t3
#   double valor --> $t4
################################################################################
suma_diagonal:
#   int nFil = mat->nFil;
    lw $t0, 0($a0)

#   int nCol = mat->nCol;
    lw $t1, 4($a0)

#    double* datos = mat->elementos;
    addi $t2, $a0, 8

#    double suma = 0.0;
    mtc1.d $zero, $f0
    move $f0, $f0

#    // En una matriz cuadrada, el número de elementos en la diagonal 
#    // es igual al número de filas (o columnas).
#    for (int i = 0; i < nFil; i++) {
    move $t3, $zero

for_Suma_Diagonal:
    bge $t3, $t0, for_fin_Suma_Diagonal
#        // El elemento de la diagonal principal está en fila i, columna i
#        // La fórmula de acceso es: datos[i * nCol + i]
#        double valor = datos[i * nCol + i];
    mul $t4, $t3, $t1
    add $t4, $t4, $t3
    sll $t4, $t4, 3
    add $t4, $t2, $t4
    l.d $f2, 0($t4)
#        suma = suma + valor;
    add.d $f0, $f0, $f2

    addi $t3, $t3, 1
    j for_Suma_Diagonal
#    }
for_fin_Suma_Diagonal:
#
#    return suma;
    jr $ra
# }
suma_diagonal__MARCAFIN:


################################################################################
# void intercambia_con_diagonal(structMat* mat, int colDestino) {
#
# Parámetros de entrada:
# structMat* mat --> $a0
# int colDestino --> $a1
# Parámetros de salida: NINGUNO
#
# SÍ llama a otra función --> SÍ modifica el $ra --> SÍ hace uso de la pila
#
# Tabla de variables:
# int nFIl --> $s0
# int nCol --> $s1
# double* datos --> $s2
# int colDestino --> $s3
# int i --> $s4
# double* e1 --> $s5
# double* e2 --> $s6
################################################################################

intercambia_con_diagonal:
  # PUSH: reservamos memoria: $ra, $s0- $s6 --> 8 * 4 = 64. A su vez, 64 es multiplo de 8
  addi $sp, $sp, -64
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)
  sw $s4, 20($sp)
  sw $s5, 24($sp)
  sw $s6, 28($sp)
  sw $s7, 32($sp)

#    int nFil = mat->nFil;
    lw $s0, 0($a0)

#    int nCol = mat->nCol;
    lw $s1, 4($a0)

#    double* datos = mat->elementos;
    addi $s2, $a0, 8

    # Inicializamos el bucle for con i = 0
    move $s4, $zero

#    for (int i = 0; i < nFil; i++) {
for_intercambia_con_diagonal:
    bge $s4, $s0, for_fin_intercambia_con_diagonal
#        // e1 es el elemento de la diagonal principal: datos[i][i]
#        double* e1 = &datos[i * nCol + i];
    mul $t0, $s4, $s1
    add $t0, $t0, $s4
    sll $t0, $t0, 3
    add $s5, $s2, $t0

    # Ahora que guardamos el resultado en $s5, podemos sobreescribir el valor de $t0

#        double* e2 = &datos[i * nCol + colDestino];
    mul $t0, $s4, $s1
    add $t0, $t0, $s4
    sll $t0, $t0, 3
    add $s6, $s2, $t0
#
#        // LLAMADA A LA FUNCIÓN DE TU CÓDIGO
#        swap(e1, e2);
    move $a0, $s5
    move $a1, $s6
    jal swap

    addi $s4, $s4, 1
    j for_intercambia_con_diagonal

#    }
for_fin_intercambia_con_diagonal:

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
  addi $sp, $sp, 64

  jr $ra

# }
intercambia_con_diagonal__MARCAFIN:


################################################################################
# int contar_mayores(structMat* mat) {
#
# Parámetros de entrada:
# structMat* mat --> $a0
# Parámetros de salida: 
# int contador --> $v0
#
# SÍ llama a otras funciones --> modifica el $ra --> SÍ hace uso de la pila
#
# Tabla de parámetros:
#   int nFil --> $s0
#   int nCol --> $s1
#   double* datos --> $s2
#   int contador --> $s3
#   int i --> $s4
#   int j --> $s5
#   structMat* mat --> $s6
#   double max_diag --> $f20
#   double valor --> $f22
################################################################################

    # PUSH: $ra, $s0-$s5, $f20 --> 8 * 4 + 16 = 48
    # Necesitamos que la memoria sea multiplo de 8 --> 48
    addi $sp, $sp, -48
    sw $ra, 0($sp) 
    sw $s0, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $s6, 24($sp)
    s.d $f20, 32($sp)
    s.d $f22, 40($sp)
    
    move $s6, $a0

#    int nFil = mat->nFil;
    lw $s0, nFil($s6)

#    int nCol = mat->nCol;
    lw $s1, nCol($s6)

#    double* datos = mat->elementos;
    add $s2, $s6, elementos

#    int contador = 0;
    li $s3, 0

#    // 1. Llamada a otra función
#    double max_diag = suma_diagonal(mat); 
    move $a0, $s6
    jal suma_diagonal

    mov.d $f20, $f0


    # Inicializamos i fuera del bucle
    li $s4, 0

#    for (int i = 0; i < nFil; i++) {
for_i_contar_mayores:
    bge $s4, $s0, for_i_fin_contar_mayores:

    # Inicializamos j = 0 antes del bucle
    li $s5, 0
#        for (int j = 0; j < nCol; j++) {
for_j_contar_mayores:
    bge $s5, $s1, for_j_fin_contar_mayores

#            // 3. Cálculo de índice
#            double valor = datos[i * nCol + j];
    mul $t0, $s4, $s1
    add $t0, $t0, $s5
    mul $t0, $t0, tamD
    add $t0, $t0, $s2
    l.d $f22, 0($t0)

#
#            // 4. Comparación flotante
#            if (valor > max_diag) {
if_contar_mayores:
    c.le.d $f22, $f20
    bc1t if_fin_contar_mayores

#                contador++;
    addi $s3, $s3, 1

#            }
if_fin_contar_mayores:


    addi $s5, $s5, 1
    j for_j_contar_mayores

#        }
for_j_fin_contar_mayores:

    addi $s4, $s4, 1
    j for_i_contar_mayores

#    }
for_i_fin_contar_mayores:
#    return contador; // 5. Parámetro de salida entero

# }

    # POP
    lw $ra, 0($sp) 
    lw $s0, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $s5, 20($sp)
    lw $s6, 24($sp)
    l.d $f20, 32($sp)
    l.d $f22, 40($sp)
    addi $sp, $sp, 48

    jr $ra

contar_mayores__MARCAFIN:



################################################################################
# int main() {
# Tabla de variables a registros:
#   structMat* matTrabajo --> $s0
#   int opcion            --> $s1
#   int indFil            --> $s2
#   int indCol            --> $s3
#   int indC1             --> $s4
#   int indC2             --> $s5
#   double maximo         --> $f20
################################################################################
main:
    # PUSH $ra, $s0, $s1, $s2, $s3, $s4, $s5 : 7 * 4 = 28
    addi $sp, $sp, -28
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)
    sw   $s3, 16($sp)
    sw   $s4, 20($sp)
    sw   $s5, 24($sp)

#   std::cout << std::setprecision(18); // Ignorar
#   std::cout << "\nComienza programa manejo matrices con funciones";
    li   $v0, 4
    la   $a0, cadTitulo
    syscall

#   structMat* matTrabajo = matrices[0];
    la   $t0, matrices
    lw   $s0, 0($t0)          # matTrabajo = matrices[0]

#   do {
main__doWhile:
#     print_mat(matTrabajo);
    move $a0, $s0
    jal  print_mat

#     std::cout << "(0) Terminar el programa\n"..."introduce opción elegida: ";
    li   $v0, 4
    la   $a0, cadMenu
    syscall

#     std::cin >> opcion;
    li   $v0, 5
    syscall
    move $s1, $v0

#     switch (opcion) {
    beq  $s1, 0, main__caso0
    beq  $s1, 1, main__caso1
    beq  $s1, 3, main__caso3
    beq  $s1, 4, main__caso4
    beq  $s1, 5, main__caso5
    beq  $s1, 7, main__caso7
    b    main__default

    # // Opción 0 //////////////////////////////////////////////////////////
    # case 0:
main__caso0:
#       std::cout << "\nEligida opción de salir";
    li   $v0, 4
    la   $a0, cadSalir
    syscall
    b    main__switch_fin

    # // Opción 1 //////////////////////////////////////////////////////////
    # case 1:
main__caso1:
#       std::cout << "\nElije la matriz de trabajo: ";
    li   $v0, 4
    la   $a0, cadEligeMat
    syscall

#       std::cin >> matT;
    li   $v0, 5
    syscall
    move $t0, $v0

#       if ((matT < 0) || (matT >= NUM_MATRICES)) {
    blt  $t0, $zero, main__caso1_error
    li   $t1, NUM_MATRICES
    bge  $t0, $t1, main__caso1_error

#       matTrabajo = matrices[matT];
    la   $t1, matrices
    sll  $t0, $t0, 2          # t0 *= 4 (tamaño puntero)
    add  $t1, $t1, $t0
    lw   $s0, 0($t1)
    b    main__switch_fin

main__caso1_error:
#         std::cout << "Numero de matriz de trabajo incorrecto\n";
    li   $v0, 4
    la   $a0, cadErrorMat
    syscall
    b    main__switch_fin

    # // Opción 3 //////////////////////////////////////////////////////////
    # case 3:
main__caso3:
#       std::tie(indFil, indCol) = pideFilaYColumna(matTrabajo);
    move $a0, $s0
    jal  pideFilaYColumna
    move $s2, $v0             # indFil
    move $s3, $v1             # indCol

#       if (indFil < 0) break;
    blt  $s2, $zero, main__switch_fin

#       std::cout << "Nuevo valor para el elemento: ";
    li   $v0, 4
    la   $a0, cadNuevoValor
    syscall

#       std::cin >> valor;
    li   $v0, 7
    syscall                   # valor leído en $f0 (double)
    mov.d $f12, $f0

#       change_elto(matTrabajo, indFil, indCol, valor);
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    jal  change_elto
    b    main__switch_fin

    # // Opción 4 //////////////////////////////////////////////////////////
    # case 4:
main__caso4:
#       std::tie(indFil, indCol) = pideFilaYColumna(matTrabajo);
    move $a0, $s0
    jal  pideFilaYColumna
    move $s2, $v0             # indFil
    move $s3, $v1             # indCol

#       if (indFil < 0) break;
    blt  $s2, $zero, main__switch_fin

#       intercambia(matTrabajo, indFil, indCol);
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    jal  intercambia
    b    main__switch_fin

    # // Opción 5 //////////////////////////////////////////////////////////
    # case 5:
main__caso5:
#       std::cout << "\nPrimera columna a procesar: ";
    li   $v0, 4
    la   $a0, cadPrimCol
    syscall

#       int indC1 = leeColumna(matTrabajo->nCol);
    lw   $a0, nCol($s0)
    jal  leeColumna
    move $s4, $v0

#       if (indC1 < 0) break;
    blt  $s4, $zero, main__switch_fin

#       std::cout << "Segunda columna a procesar: ";
    li   $v0, 4
    la   $a0, cadSegCol
    syscall

#       int indC2 = leeColumna(matTrabajo->nCol);
    lw   $a0, nCol($s0)
    jal  leeColumna
    move $s5, $v0

#       if (indC2 < 0) break;
    blt  $s5, $zero, main__switch_fin

#       procesa_cols(matTrabajo, indC1, indC2);
    move $a0, $s0
    move $a1, $s4
    move $a2, $s5
    jal  procesa_cols
    b    main__switch_fin

    # // Opción 7 //////////////////////////////////////////////////////////
    # case 7:
# // Opción 7 //////////////////////////////////////////////////////////
    # case 7:
main__caso7:
#       maximo = find_max(matTrabajo);
    move $a0, $s0
    jal  find_max
    mov.d $f20, $f0

#       std::cout << "\nEl valor maximo en la matriz es " << maximo;
    li   $v0, 4
    la   $a0, cadMax
    syscall

    mov.d $f12, $f20
    li   $v0, 3               # syscall 3 imprime un double
    syscall
    b    main__switch_fin
    
    # // Opción Incorrecta //////////////////////////////////////////////////
main__default:
#       std::cout << "Error: opcion incorrecta\n";
    li   $v0, 4
    la   $a0, cadErrorOpcion
    syscall

main__switch_fin:
#     std::cout << "\nTerminada la opción " << opcion;
    li   $v0, 4
    la   $a0, cadTerOpc
    syscall

    li   $v0, 1
    move $a0, $s1
    syscall

#   } while (opcion != 0);
    bne  $s1, $zero, main__doWhile

main__doWhile_fin:
#   std::cout << "\n\nTermina el programa\n";
    li   $v0, 4
    la   $a0, cadFin
    syscall

    # POP $ra, $s0, $s1, $s2, $s3, $s4, $s5 : 7 * 4 = 28
    lw   $ra, 0($sp)
    lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    lw   $s2, 12($sp)
    lw   $s3, 16($sp)
    lw   $s4, 20($sp)
    lw   $s5, 24($sp)
    addi $sp, $sp, 28

# }
    li   $v0, 10
    syscall

main__MARCAFIN: