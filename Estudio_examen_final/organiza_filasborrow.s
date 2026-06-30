# // Organiza filas
# Ricardo Jesús Rodríguez Pérez
# 23/06/2026
# alu0101797557

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
#     -80.875, -82.75, -79.8125, 1.125, 33.75,
#     -24.0, -93.375, -21.125, 35.875, -23.5,
#     93.75, -15.0,-10.6875, -62.9375, 17.125,
#     -24.1875, -40.125, 68.9375, -68.8125, -5.5625,
#     -78.1875, -70.25, 1.28125, 30.375, -26.0,
#     -89.5, 80.6875, 1.125, 66.5, 76.4375,
#     94.75, -58.0, -52.25, 97.875, 84.0625,
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
#   { -79.5625, -84.4375, -86.25, 13.6875, -94.5, -15.1875, 47.9375,
#       -22.75, -6.53125, 8.84375, 1.125, -21.25, 1.9375, -25.25,
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


# int reparte_vectores(double* v1, double* v2,
#     int numElem, double cota) {
#   int numCambios = 0;
#   for(int ind1 = (numElem - 1); ind1 >= 0; ind1--) {
#     double elem1 = v1[ind1];
#     int ind2 = numElem - ind1 - 1;
#     if ((elem1 > cota) || (elem1 < -1.5)) {
#       double elem2 = v2[ind2];
#       v1[ind1] = elem2;
#       v2[ind2] = elem1;
#       numCambios++;
#     } else {
#       v1[ind2] = -elem1;
#     }
#     cota += 0.25;
#   }
#   return numCambios;
# }


# double organiza_filas(structMat* mat, int inicial,
#     int final, double cota) {
#   int totIntercambios = 0;
#   double acumulado = 0.0;
#   int numC = mat->nCol;
#   double* datos = mat->elementos;
#   //double* f1 = &(datos[inicial][0])
#   double* f1 = &(datos[inicial * numC + 0]);
#   for(int f = (inicial+1); f <= final; f++) {


#     // acumulado += datos[f][0];
#     acumulado += datos[f * numC + 0];


#     // double* f2 = &(datos[f][0]);
#     double* f2 = &(datos[f * numC + 0]);


#     int numc = reparte_vectores(f1, f2, numC, cota);
#     totIntercambios += numc;
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
#     "(3) Organizar filas\n"
#     "(7) Terminar el programa\n"
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


#       // Opción 3 ///////////////////////////////////////////////
#       case 3:
#         std::cout << "\nIndice de fila inicial: ";
#         int indFilIni;
#         std::cin >> indFilIni;


#         std::cout << "Indice de fila final: ";
#         int indFilFin;
#         std::cin >> indFilFin;


#         std::cout << "Valor para la cota: ";
#         double cota;
#         std::cin >> cota;


#         double factor;
#         factor = organiza_filas(matTrabajo, indFilIni,
#             indFilFin, cota);


#         std::cout << "Factor organización = " << factor;
#         break; // salimos del switch


#       // Opción 7 ////////////////////////////////////////////////
#       case 7:
#         // std::cout << "\nElegida opción de salir";
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
#   } while (opcion != 7);
#   std::cout << "\n\nTermina el programa\n";
# }


  .data
mat0: .word 6, 6
      .double 11.0625, 12.0625, 13.125, 14.125, 1.125, 16.125,
      .double 21.1875, 22.1875, 23.1875, 24.1875, 25.25, 26.25,
      .double 31.25, 32.3125, 33.3125, 34.3125, 35.3125, 36.3125,
      .double 41.375, 42.375, 43.375, 44.4375, 45.4375, 46.4375,
      .double 1.125, 52.5, 53.5, 54.5, 55.5, 56.5,
      .double 61.5625, 62.5625, 63.625, 64.625, 65.625, 66.625
mat1: .word 8, 5
      .double -80.875, -82.75, -79.8125, 1.125, 33.75,
      .double -24.0, -93.375, -21.125, 35.875, -23.5,
      .double 93.75, -15.0,-10.6875, -62.9375, 17.125,
      .double -24.1875, -40.125, 68.9375, -68.8125, -5.5625,
      .double -78.1875, -70.25, 1.28125, 30.375, -26.0,
      .double -89.5, 80.6875, 1.125, 66.5, 76.4375,
      .double 94.75, -58.0, -52.25, 97.875, 84.0625,
      .double 59.875, 72.375, -93.0625, 98.5625, 43.3125
mat2: .word 1, 6
      .double -76.75, -20.5625, 4.09375, 43.25, -20.3125, 1.125
mat3: .word 14, 1
      .double -79.5625, -84.4375, -86.25, 13.6875, -94.5, -15.1875, 47.9375,
      .double -22.75, -6.53125, 8.84375, 1.125, -21.25, 1.9375, -25.25,
mat4: .word 1, 1
      .double 1.125
mat5: .word 0, 0
      .double 0.0


tamD=8  # tamaño de un double en bytes
tamP=4  # tamaño de una palabra (dirección) en bytes
nFil=0  # desplazamiento para acceder a nFil en la estructura
nCol=4  # desplazamiento para acceder a nCol en la estructura
elementos=8  # desplazamiento para acceder a elementos en la estructura


# #define NUM_MATRICES  6
NUM_MATRICES = 6
# structMat* matrices[NUM_MATRICES] = {&mat0, &mat1, &mat2, &mat3, &mat4, &mat5};
matrices:   .word mat0, mat1, mat2, mat3, mat4, mat5


cadFin:     .asciiz "\n\nTermina el programa\n"
cadTitulo:  .asciiz "\nComienza programa organiza filas\n"
cadMenu:    .ascii  "\n(1) Cambiar la matriz de trabajo"
            .ascii  "\n(3) Organizar filas"
            .ascii  "\n(7) Terminar el programa"
            .asciiz "\n\nIntroduce opción elegida: "
cadTopcion: .asciiz "\nTerminada la opción "
cadOIncor:  .asciiz "Error: opcion incorrecta\n"
cadElijeM:  .asciiz "\nElije la matriz de trabajo: "
cadMIncor:  .asciiz "Numero de matriz de trabajo incorrecto\n"
cadIndI:    .asciiz "\nIndice de fila inicial: "
cadIndF:    .asciiz "Indice de fila final: "
cadCota:    .asciiz "Valor para la cota: "
cadFactor:  .asciiz "Factor organización = "


  .text


# ########################################################
# void print_matriz(structMat* mat) {
print_matriz:
# Parámetro de entra
# structMat* mat → $a0
# Parámetros de salida ninguno


    .word    0x23bdffe4, 0xafbf0000, 0xafb00004, 0xafb10008
    .word    0xafb2000c, 0xafb30010, 0xafb40014, 0xafb50018
    .word    0x8c900000, 0x8c910004, 0x20920008, 0x04110008
    .word    0x20614c0a, 0x7274616d, 0x74207a69, 0x656e6569
    .word    0x6d696420, 0x69736e65, 0x00206e6f, 0x001fa821
    .word    0x82a40000, 0x10800005, 0x3402000b, 0x0000000c
    .word    0x22b50001, 0x0401fffb, 0x34020001, 0x00102021
    .word    0x0000000c, 0x3402000b, 0x34040078, 0x0000000c
    .word    0x34020001, 0x00112021, 0x0000000c, 0x3402000b
    .word    0x3404000a, 0x0000000c, 0x00009821, 0x0270082a
    .word    0x10200016, 0x0000a021, 0x0291082a, 0x1020000e
    .word    0x72714002, 0x01144020, 0x34010008, 0x71014002
    .word    0x01124020, 0x34020003, 0xd50c0000, 0x0000000c
    .word    0x3402000b, 0x34040020, 0x0000000c, 0x22940001
    .word    0x0401fff2, 0x3402000b, 0x3404000a, 0x0000000c
    .word    0x22730001, 0x0401ffea, 0x3402000b, 0x3404000a
    .word    0x0000000c, 0x8fbf0000, 0x8fb00004, 0x8fb10008
    .word    0x8fb2000c, 0x8fb30010, 0x8fb40014, 0x8fb50018
    .word    0x23bd001c, 0x03e00008,
print_matriz__MARCAFIN:


.text

#######################################################################
# void print_matriz(structMat* mat) {
#
# Parámetros de entrada:
#   structMat* mat --> $a0
# Parámetros de salida: NINGUNO
#
# SÍ llama a otras funciones --> SÍ modifica $ra --> SÍ hace uso de pila
#
# Tabla de parámetros:
#   structMat* mat --> $a0 --> $s0
#   int numF --> $s1
#   int numC --> $s2
#   int f --> $s3
#   int c --> $s4
#   double* datos --> $s5
#   double dato --> $f20
#######################################################################
print_matriz:
    # PUSH -> $ra, $s0, $s5, $f20 -> 7 * 4 + 8 = 36 -> 40 multiplo de 8
    addi $sp, $sp, -40
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    s.d $f20, 32($sp)

    move $s0, $a0

#   int numF = mat->nFil;
    lw $s1, nFil($s0)

#   int numC = mat->nCol;
    lw $s2, nCol($s0)

#   double* datos = mat->elementos;
    addi $s5, $s0, elementos

#   std::cout << "\nLa matriz tiene dimension "
    li $v0, 4
    la $a0, 
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