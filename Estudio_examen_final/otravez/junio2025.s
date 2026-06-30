# Ricardo Jesús Rodríguez Pérez
# 26/06/2026

# #include <iostream>
# #include <iomanip>

# typedef struct {
#   int nFil;
#   int nCol;
#   double elementos[];
# } structMat;

# structMat mat0 {
#   6,
#   6,
#   {
#     11.0625, 12.0625, 13.125, 14.125, 1.125, 16.125,
#     21.1875, 22.1875, 23.1875, 24.1875, 25.25, 26.25,
#     31.25, 32.3125, 33.3125, 34.3125, 35.3125, 36.3125,
#     41.375, 42.375, 43.375, 44.4375, 45.4375, 46.4375,
#     1.125, 52.5, 53.5, 54.5, 55.5, 56.5,
#     61.5625, 62.5625, 63.625, 64.625, 65.625, 66.625,
#   }
# };

# structMat mat1 {
#   8,
#   5,
#   {
#     -80.875, -82.75, -3.5, 1.125, 33.75,
#     -24.0, -93.375, -21.125, 35.875, 33.50,
#     93.75, -15.0,-10.6875, -62.9375, 17.125,
#     -24.1875, -40.125, 68.9375, -68.8125, -5.5625,
#     -78.1875, -70.25, 1.28125, 30.375, -26.0,
#     -89.5, 80.6875, 1.125, 66.5, 76.4375,
#     87.25, -58.0, -52.25, 97.875, 84.0625,
#     59.875, 72.375, -93.0625, 98.5625, 43.3125,
#   }
# };

# structMat mat2 {
#   1,
#   6,
#   {
#     -76.75, -20.5625, 4.09375, 43.25, -20.3125, 1.125,
#   }
# };

# structMat mat3 {
#   14,
#   1,
#   { 8.84375, -84.4375, -86.25, 13.6875, -94.5, -15.1875, 47.9375,
#       -22.75, -6.53125, -79.5625, 1.125, 35.1875, 1.9375, -25.25,
#    }
# };

# structMat mat4 {
#   1,
#   1,
#   { 1.125, }
# };

# structMat mat5 {
#   0,
#   0,
#   { 0.0 }
# };

# #define NUM_MATRICES  6
# structMat* matrices[NUM_MATRICES] = {&mat0, &mat1, &mat2, &mat3, &mat4, &mat5};

# void print_matriz(structMat* mat) {
#   int numF = mat->nFil;
#   int numC = mat->nCol;
#   double* datos = mat->elementos;
#   std::cout << "\nLa matriz tiene dimension "
#       << numF << 'x' << numC << '\n';
#   for(int f = 0; f < numF; f++) {
#     for(int c = 0; c < numC; c++) {
#       double dato = datos[f*numC + c];
#       std::cout << dato << ' ';
#     }
#     std::cout << '\n';
#   }
#   std::cout << '\n';
# }


# int reparte_columna(structMat* mat, int indCol) {
#   int numCambios = 0;
#   int numF = mat->nFil;
#   int numC = mat->nCol;
#   double* datos = mat->elementos;
#   double delta = 0.25;
#   for(int f = 0; f < (numF -1); f++) {
#     // elem1 = datos[f][indCol]
#     double elem1 = datos[f * numC + indCol];
#     // elem1 = datos[f+1][indCol]
#     double elem2 = datos[(f + 1) * numC + indCol];
#     if (elem1 > (elem2 + delta)) {
#       // datos[f][indCol] = elem2
#       datos[f * numC + indCol] = elem2;
#       // datos[f+1][indCol] = elem1
#       datos[(f + 1) * numC + indCol] = elem1;
#       numCambios++;
#     } else {
#       // datos[f][indCol] = -elem1
#       datos[f * numC + indCol] = -elem1;
#     }
#     delta += 1.25;
#   }
#   return numCambios;
# }

# double organiza_columnas_cota(structMat* mat, int inicial,
#     int final, double cota) {
#   int totIntercambios = 0;
#   double acumulado = 0.0;
#   int numC = mat->nCol;
#   double* datos = mat->elementos;
#   for(int c = inicial; c <= final; c++) {
#     // valPrimero = datos[0][c]
#     double valPrimero = datos[0 * numC + c];
#     acumulado += valPrimero;
#     if ((valPrimero > cota) || (valPrimero < -3.5)) {
#       int numCambio = reparte_columna(mat, c);
#       totIntercambios += numCambio;
#     }
#   }
#   return acumulado * totIntercambios;
# }

# int main() {
#   std::cout << std::setprecision(18);  // ignorar
#   std::cout << "\nComienza programa organiza filas\n";

#   structMat* matTrabajo = matrices[0];
#   int opcion;
#   do {

#     print_matriz(matTrabajo);

#     std::cout << "\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(4) Organizar columnas cota\n"
#     "(9) Terminar el programa\n"
#     "\nIntroduce opción elegida: ";

#     std::cin >> opcion;

#     switch (opcion) {
#       // Opción 1 ////////////////////////////////////////////////
#       case 1:
#         std::cout << "\nElije la matriz de trabajo: ";
#         int matT;
#         std::cin >> matT;
#         int elegida;
#         if ((matT < 0) || (matT >= NUM_MATRICES)) {
#           std::cout << "Numero de matriz de trabajo incorrecto\n";
#           elegida = 0;
#         } else {
#           elegida = matT;
#         }
#         matTrabajo = matrices[elegida];
#         break; // salimos del switch

#       // Opción 4 ///////////////////////////////////////////////
#       case 4:
#         std::cout << "\nIndice de columna inicial: ";
#         int indColIni;
#         std::cin >> indColIni;

#         std::cout << "Indice de columna final: ";
#         int indColFin;
#         std::cin >> indColFin;

#         std::cout << "Valor para la cota: ";
#         double cota;
#         std::cin >> cota;

#         double factor;
#         factor = organiza_columnas_cota(matTrabajo, indColIni,
#             indColFin, cota);

#         std::cout << "Factor organización = " << factor;
#         break; // salimos del switch

#       // Opción 9 ////////////////////////////////////////////////
#       case 9:
#         print_matriz(&mat0);
#         print_matriz(&mat1);
#         print_matriz(&mat2);
#         print_matriz(&mat3);
#         print_matriz(&mat4);
#         print_matriz(&mat5);
#         break; // salimos del switch

#         // Opción Incorrecta //////////////////////////////////////
#       default:
#         std::cout << "Error: opcion incorrecta\n";
#     }  // fin del switch
#     std::cout << "\nTerminada la opción " << opcion << '\n';
#   } while (opcion != 9);
#   std::cout << "\n\nTermina el programa\n";
# }

	.data

mat0:	.word 6, 6
	.double	11.0625, 12.0625, 13.125, 14.125, 1.125, 16.125,
	.double	21.1875, 22.1875, 23.1875, 24.1875, 25.25, 26.25,
	.double	31.25, 32.3125, 33.3125, 34.3125, 35.3125, 36.3125,
	.double	41.375, 42.375, 43.375, 44.4375, 45.4375, 46.4375,
	.double	1.125, 52.5, 53.5, 54.5, 55.5, 56.5,
	.double	61.5625, 62.5625, 63.625, 64.625, 65.625, 66.625,

mat1:	.word	8, 5
	.double	-80.875, -82.75, -3.5, 1.125, 33.75,
	.double	-24.0, -93.375, -21.125, 35.875, 33.50,
	.double	93.75, -15.0,-10.6875, -62.9375, 17.125,
	.double	-24.1875, -40.125, 68.9375, -68.8125, -5.5625,
	.double	-78.1875, -70.25, 1.28125, 30.375, -26.0,
	.double	-89.5, 80.6875, 1.125, 66.5, 76.4375,
	.double	87.25, -58.0, -52.25, 97.875, 84.0625,
	.double	59.875, 72.375, -93.0625, 98.5625, 43.3125,

mat2:	.word	1, 6
	.double	-76.75, -20.5625, 4.09375, 43.25, -20.3125, 1.125,

mat3:	.word 14, 1
	.double	8.84375, -84.4375, -86.25, 13.6875, -94.5, -15.1875, 47.9375,
	.double	-22.75, -6.53125, -79.5625, 1.125, 35.1875, 1.9375, -25.25,

mat4:	.word	1, 1
	.double	1.125

mat5:	.word	0, 0
	.double	0.0

tamD=8	# tamaño de un double en bytes
tamP=4	# tamaño de una palabra (dirección) en bytes
nFil=0	# desplazamiento para acceder a nFil en la estructura
nCol=4	# desplazamiento para acceder a nCol en la estructura
elementos=8	# desplazamiento para acceder a elementos en la estructura

NUM_MATRICES = 6
matrices:	.word mat0, mat1, mat2, mat3, mat4, mat5

strComienza:	.asciiz	"\nComienza programa organiza filas\n"
strMenu:	.ascii	"\n"
		.ascii	"(1) Cambiar la matriz de trabajo\n"
		.ascii	"(4) Organizar columnas cota\n"
		.ascii	"(9) Terminar el programa\n"
		.asciiz	"\nIntroduce opción elegida: "
strEligeMat:	.asciiz	"\nElije la matriz de trabajo: "
strNumeroMat:	.asciiz	"Numero de matriz de trabajo incorrecto\n"
strIndColIni:	.asciiz	"\nIndice de columna inicial: "
strIndColFin:	.asciiz	"Indice de columna final: "
strValorCota:	.asciiz	"Valor para la cota: "
strFactorOrga:	.asciiz	"Factor organización = "
strErrorOpcion:	.asciiz	"Error: opcion incorrecta\n"
strTerminadaOp:	.asciiz	"\nTerminada la opción "
strTerminaProg:	.asciiz	"\n\nTermina el programa\n"

	.text

# ########################################################
# void print_matriz(structMat* mat) {
print_matriz:
# Parámetro de entra
# structMat* mat → $a0
# Parámetros de salida ninguno

	.word	0x23bdffe4, 0xafbf0000, 0xafb00004, 0xafb10008
	.word	0xafb2000c, 0xafb30010, 0xafb40014, 0xafb50018
	.word	0x8c900000, 0x8c910004, 0x20920008, 0x04110008
	.word	0x20614c0a, 0x7274616d, 0x74207a69, 0x656e6569
	.word	0x6d696420, 0x69736e65, 0x00206e6f, 0x001fa821
	.word	0x82a40000, 0x10800005, 0x3402000b, 0x0000000c
	.word	0x22b50001, 0x0401fffb, 0x34020001, 0x00102021
	.word	0x0000000c, 0x3402000b, 0x34040078, 0x0000000c
	.word	0x34020001, 0x00112021, 0x0000000c, 0x3402000b
	.word	0x3404000a, 0x0000000c, 0x00009821, 0x0270082a
	.word	0x10200016, 0x0000a021, 0x0291082a, 0x1020000e
	.word	0x72714002, 0x01144020, 0x34010008, 0x71014002
	.word	0x01124020, 0x34020003, 0xd50c0000, 0x0000000c
	.word	0x3402000b, 0x34040020, 0x0000000c, 0x22940001
	.word	0x0401fff2, 0x3402000b, 0x3404000a, 0x0000000c
	.word	0x22730001, 0x0401ffea, 0x3402000b, 0x3404000a
	.word	0x0000000c, 0x8fbf0000, 0x8fb00004, 0x8fb10008
	.word	0x8fb2000c, 0x8fb30010, 0x8fb40014, 0x8fb50018
	.word	0x23bd001c, 0x03e00008,
print_matriz__MARCAFIN:

# ↓↓↓↓ Debes codificar a partir de aquí ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

###############################################################################
# int reparte_columna(structMat* mat, int indCol) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int indCol --> $a1
# Parámetros de salida:
#   int numCambios --> $v0
#
# Función leaf --> NO modifca $ra --> NO hace uso de pila
#
# Tabla de parámetros
#   structMat* mat --> $a0
#   int indCol --> $a1 --> $t0
#   int numCambios --> $t1 --> $v0
#   int numF --> $t2
#   int numC --> $t3
#   double* datos --> $t4
#   int f --> $t5
#   condicion numF -1 --> $t6
#   cálculos momentáneos de elem1 --> $t7
#   Cálculos momentáneos de elem2 --> $t8
#   
#   double delta --> $f4
#   double elem1 --> $f6
#   double elem2 --> $f8
#   Guardar 1.25 --> $f10
#   Condicion elem2 + delta --> $f16
###############################################################################
reparte_columna:
  
  move $t0, $a1

#   int numCambios = 0;
  li $t1, 0

#   int numF = mat->nFil;
  lw $t2, nFil($a0)

#   int numC = mat->nCol;
  lw $t3, nCol($a0)

#   double* datos = mat->elementos;
  addi $t4, $a0, elementos

#   double delta = 0.25;
  li.d $f4, 0.25

  # Declaramos f = 0 antes de entrar en el bucle
  li $t5, 0

  # Declaramos numF - 1
  addi $t6, $t2, -1

#   for(int f = 0; f < (numF -1); f++) {
for_f_reparte_columna:
  bge $t5, $t6, for_f_reparte_columna_fin

#     // elem1 = datos[f][indCol]
#     double elem1 = datos[f * numC + indCol];
  mul $t7, $t5, $t3
  add $t7, $t7, $t0
  mul $t7, $t7, tamD
  add $t7, $t7, $t4
  l.d $f6, 0($t7)

#     // elem1 = datos[f+1][indCol]
#     double elem2 = datos[(f + 1) * numC + indCol];
  add $t8, $t5, 1
  mul $t8, $t8, $t3
  add $t8, $t8, $t0
  mul $t8, $t8, tamD
  add $t8, $t8, $t4
  l.d $f8, 0($t8)

  # Condicion elem2 + delta
  add.d $f16, $f8, $f4

#     if (elem1 > (elem2 + delta)) {
if_reparte_columna:
  c.le.d $f6, $f16
  bc1t if_reparte_columna_fin

#       // datos[f][indCol] = elem2
#       datos[f * numC + indCol] = elem2;
  s.d $f8, 0($t7)

#       // datos[f+1][indCol] = elem1
#       datos[(f + 1) * numC + indCol] = elem1;
  s.d $f6, 0($t8)

#       numCambios++;
  addi $t1, $t1, 1

  b else_reparte_columna_fin

#     } else {
if_reparte_columna_fin:

else_reparte_columna:
#       // datos[f][indCol] = -elem1
#       datos[f * numC + indCol] = -elem1;
  neg.d $f6, $f6
  s.d $f6, 0($t7)

#     }
else_reparte_columna_fin:

  # Asignamos a $f10 1.25
  li.d $f10, 1.25

#     delta += 1.25;
  add.d $f4, $f4, $f10

  addi $t5, $t5, 1
  b for_f_reparte_columna

#   }
for_f_reparte_columna_fin:

#   return numCambios;
  move $v0, $t1

# }
  jr $ra
reparte_columna__MARCAFIN:

###############################################################################
# double organiza_columnas_cota(structMat* mat, int inicial,
#     int final, double cota) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
#   int inicial --> $a1
#   int final --> $a2
#   double cota --> $f12
#
# Parámetros de salida: 
#   double acumulado * totIntercambios --> $f0
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0 --> $s6
#   int inicial --> $a1 --> $s0
#   int final --> $a2 --> $s1
#   int totIntercambios --> $s2
#   int numC --> $s3
#   double* datos --> $s4
#   int c --> $s5
#   
#   double cota --> $f12 --> $f20
#   double acumulado --> $f22
#   double valPrimero --> $f24
#
#   int numCambio --> $t0
#   cargar -3.5 --> $f4
#   double totIntercambios --> $f6
# 
#   Cálculos momentáneos --> $t2
###############################################################################
organiza_columnas_cota:

  # PUSH --> $ra, $s0-$s6, $f20-$f23 -> 8 * 4 + 8 * 3 = 52 -> 56
  addi $sp, $sp, -56
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)
  sw $s4, 20($sp)
  sw $s5, 24($sp)
  sw $s6, 28($sp)
  s.d $f20, 32($sp)
  s.d $f22, 40($sp)
  s.d $f24, 48($sp)

  move $s6, $a0
  move $s0, $a1
  move $s1, $a2
  mov.d $f20, $f12

#   int totIntercambios = 0;
  li $s2, 0

#   double acumulado = 0.0;
  li.d $f22, 0.0

#   int numC = mat->nCol;
  lw $s3, nCol($s6)

#   double* datos = mat->elementos;
  addi $s4, $s6, elementos

  # Inicializamos c = inicial antes del bucle
  move $s5, $s0

#   for(int c = inicial; c <= final; c++) {

for_organiza_columnas_cota:
  bgt $s5, $s1 for_organiza_columnas_cota_fin

#     // valPrimero = datos[0][c]
#     double valPrimero = datos[0 * numC + c];
  move $t0, $s5
  mul $t0, $t0, tamD
  add $t0, $t0, $s4
  l.d $f24, 0($t0)

#     acumulado += valPrimero;
  add.d $f22, $f22, $f24

#     if ((valPrimero > cota) || (valPrimero < -3.5)) {
  # Cargamos -3.5 en $f4
  li.d $f4, -3.5

if_organiza_columnas_cota:
  c.lt.d $f20, $f24   
  bc1t if_organiza_columnas_cota_cuerpo

  c.lt.d $f24, $f4
  bc1t if_organiza_columnas_cota_cuerpo

  b if_organiza_columnas_cota_fin

if_organiza_columnas_cota_cuerpo:

#       int numCambio = reparte_columna(mat, c);
  move $a0, $s6
  move $a1, $s5
  jal reparte_columna

#       totIntercambios += numCambio;
  add $s2, $s2, $v0

#     } 
if_organiza_columnas_cota_fin:

  addi $s5, $s5, 1
  b for_organiza_columnas_cota
  
#   }
for_organiza_columnas_cota_fin:

#   return acumulado * totIntercambios;
  mtc1 $s2, $f6
  cvt.d.w $f6, $f6

  mul.d $f0, $f22, $f6 

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
  l.d $f20, 32($sp)
  l.d $f22, 40($sp)
  l.d $f24, 48($sp)
  addi $sp, $sp, 56
  
  jr $ra

organiza_columnas_cota__MARCAFIN:


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
#   int elegida --> $s2
#   int indColIni --> $s3
#   int indColFin --> $s4
#
#   double cota --> $f20
#   double factor --> $f22
#
#   int matT --> $t0
#
#   Cálculos momentáneos --> $t1
###############################################################################
main:
  # PUSH, $ra, $s0-$s4, $f20, $f22 -> 6 * 4 + 8 * 2 = 40 --> múltiplo de 8
  addi $sp, $sp, -40
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)
  sw $s4, 20($sp)
  s.d $f20, 24($sp)
  s.d $f22, 32($sp)

#   std::cout << std::setprecision(18);  // ignorar
#   std::cout << "\nComienza programa organiza filas\n";
  li $v0, 4
  la $a0, strComienza
  syscall

#   structMat* matTrabajo = matrices[0];
  lw $s0, matrices

#   int opcion;
#   do {
main_doWhile:

#     print_matriz(matTrabajo);
  move $a0, $s0
  jal print_matriz

#     std::cout << "\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(4) Organizar columnas cota\n"
#     "(9) Terminar el programa\n"
#     "\nIntroduce opción elegida: ";
  li $v0, 4
  la $a0, strMenu
  syscall

#     std::cin >> opcion;
  li $v0, 5
  syscall
  move $s1, $v0

#     switch (opcion) {
main_switch:
  beq $s1, 1, caso1
  beq $s1, 4, caso4
  beq $s1, 9, caso9
  b caso_default

#       // Opción 1 ////////////////////////////////////////////////
#       case 1:
caso1:
#         std::cout << "\nElije la matriz de trabajo: ";
  li $v0, 4
  la $a0, strEligeMat
  syscall

#         int matT;
#         std::cin >> matT;
  li $v0, 5 
  syscall
  move $t0, $v0

#         int elegida;
#         if ((matT < 0) || (matT >= NUM_MATRICES)) {
if_caso1:
  blt $t0, 0, if_caso1_cuerpo
  bge $t0, NUM_MATRICES, if_caso1_cuerpo
  b if_caso1_fin

if_caso1_cuerpo:

#           std::cout << "Numero de matriz de trabajo incorrecto\n";
  li $v0, 4
  la $a0, strNumeroMat
  syscall

#           elegida = 0;
  li $s2, 0
  b else_caso1_fin

#         } else {
if_caso1_fin:

else_caso1:

#           elegida = matT;
  move $s2, $t0

#         }
else_caso1_fin:

#         matTrabajo = matrices[elegida];
  la $t0, matrices
  mul $t1, $s2, tamP
  add $t1, $t0, $t1
  lw $s0, 0($t1)

#         break; // salimos del switch
  b main_switch_fin

#       // Opción 4 ///////////////////////////////////////////////
#       case 4:
caso4:
#         std::cout << "\nIndice de columna inicial: ";
  li $v0, 4 
  la $a0, strIndColIni
  syscall

#         int indColIni;
#         std::cin >> indColIni;
  li $v0, 5
  syscall
  move $s3, $v0

#         std::cout << "Indice de columna final: ";
  li $v0, 4 
  la $a0, strIndColFin
  syscall

#         int indColFin;
#         std::cin >> indColFin;
  li $v0, 5
  syscall
  move $s4, $v0

#         std::cout << "Valor para la cota: ";
  li $v0, 4
  la $a0, strValorCota
  syscall

#         double cota;
#         std::cin >> cota;
  li $v0, 7
  syscall
  mov.d $f20, $f0

#         double factor;
#         factor = organiza_columnas_cota(matTrabajo, indColIni,
#             indColFin, cota);
  move $a0, $s0
  move $a1, $s3
  move $a2, $s4
  mov.d $f12, $f20
  jal organiza_columnas_cota

  mov.d $f22, $f0

#         std::cout << "Factor organización = " << factor;
  li $v0, 4
  la $a0, strFactorOrga
  syscall

  li $v0, 3
  mov.d $f12, $f22
  syscall

#         break; // salimos del switch
  b main_switch_fin

#       // Opción 9 ////////////////////////////////////////////////
#       case 9:
caso9:
#         print_matriz(&mat0);
  la $a0, mat0
  jal print_matriz

#         print_matriz(&mat1);
  la $a0, mat1
  jal print_matriz
  
#         print_matriz(&mat2);
  la $a0, mat2
  jal print_matriz
 
#         print_matriz(&mat3);
  la $a0, mat3
  jal print_matriz
 
#         print_matriz(&mat4);
  la $a0, mat4
  jal print_matriz
 
#         print_matriz(&mat5);
  la $a0, mat5
  jal print_matriz
 
#         break; // salimos del switch
  b main_switch_fin

#         // Opción Incorrecta //////////////////////////////////////
#       default:
caso_default:
#         std::cout << "Error: opcion incorrecta\n";
  li $v0, 4
  la $a0, strErrorOpcion
  syscall

#     }  // fin del switch
main_switch_fin:

#     std::cout << "\nTerminada la opción " << opcion << '\n';
  li $v0, 4
  la $a0, strTerminadaOp
  syscall

  li $v0, 1
  move $a0, $s1
  syscall

  li $v0, 11
  li $a0, 10
  syscall

#   } while (opcion != 9);
  bne $s1, 9, main_doWhile

main_doWhile_fin:

#   std::cout << "\n\nTermina el programa\n";
  li $v0, 4 
  la $a0, strTerminaProg
  syscall

# }

  # POP
  lw $ra, 0($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  lw $s2, 12($sp)
  lw $s3, 16($sp)
  lw $s4, 20($sp)
  l.d $f20, 24($sp)
  l.d $f22, 32($sp)
  addi $sp, $sp, 40

  jr $ra
main__MARCAFIN: