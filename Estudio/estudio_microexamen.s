# #include <iostream>
# 
# // Funcion 1: Funcion hoja que comprueba si un caracter es la letra 'a' o 'A'
# // Devuelve 1 si es cierto, 0 si es falso
# int es_letra_a(char c) {
#     if (c == 'a') return 1;
#     if (c == 'A') return 1;
#     return 0;
# }
# 
# // Funcion 2: Calcula la longitud de una cadena (hasta encontrar el \0)
# int longitud_cadena(char* str) {
#     int i = 0;
#     while (str[i] != '\0') {
#         i++;
#     }
#     return i;
# }
# 
# // Funcion 3: Recorre la cadena y llama a es_letra_a.
# // Si encuentra una 'a' o 'A', la cambia por un asterisco '*'.
# // Devuelve el numero total de cambios realizados.
# int censurar_cadena(char* str) {
#     int i = 0;
#     int cambios = 0;
#     
#     while (str[i] != '\0') {
#         // Ojo: al llamar a es_letra_a, machacaremos registros temporales
#         if (es_letra_a(str[i]) == 1) {
#             str[i] = '*';
#             cambios++;
#         }
#         i++;
#     }
#     return cambios;
# }
# 
# // Main
# int main() {
#     std::cout << "\n--- Analizador de Textos ---\n";
#     
#     // "texto" es un array de caracteres modificable en memoria
#     std::cout << "Texto original: " << texto << "\n";
#     
#     int len = longitud_cadena(texto);
#     std::cout << "Longitud: " << len << " caracteres\n";
#     
#     int num_cambios = censurar_cadena(texto);
#     
#     std::cout << "Texto censurado: " << texto << "\n";
#     std::cout << "Letras censuradas: " << num_cambios << "\n";
#     
#     std::cout << "\nFin del examen\n";
#     return 0;
# }

.data
    # --- Strings de la interfaz ---
    strTitulo:   .asciiz "\n--- Analizador de Textos ---\n"
    strOrig:     .asciiz "Texto original: "
    strLong:     .asciiz "Longitud: "
    strChars:    .asciiz " caracteres\n"
    strCens:     .asciiz "Texto censurado: "
    strCambios:  .asciiz "Letras censuradas: "
    strSalto:    .asciiz "\n"
    strFin:      .asciiz "\nFin del examen\n"

    # --- Variables en memoria ---
    # Usamos .asciiz en lugar de .ascii para que incluya automáticamente el \0 al final
    # Fíjate que al estar en .data, SÍ podemos sobreescribir sus letras después
    texto:       .asciiz "Arquitectura de Computadores MIPS"

.text

# // Funcion 1: Funcion hoja que comprueba si un caracter es la letra 'a' o 'A'
# // Devuelve 1 si es cierto, 0 si es falso
################################################################################
# int es_letra_a(char c) {
# Parámetros de entrada:
#   char c --> $a0
# Parámetros de salida: 
#   int --> $v0
#
# Función LEAF: no hace uso de pila --> no modifica $ra
#
# Tabla de registros:
# char 'a' --> $t0 --> luego pasa a 'A'
################################################################################

es_letra_a:
#     if (c == 'a') return 1;
if_a:
    li $t0, 'a'
    beq $a0, $t0, es_cierto

#     if (c == 'A') return 1;
if_A:
    li $t0, 'A'
    beq $a0, $t0, es_cierto

#     return 0;
    li $v0, 0
    jr $ra


es_cierto:
    li $v0, 1
    jr $ra

#     return 0;
    li $v0, 0
    jr $ra
# }
es_letra_a__MARCAFIN:

# // Funcion 2: Calcula la longitud de una cadena (hasta encontrar el \0)
################################################################################
# int longitud_cadena(char* str) {
# Parámetros de entrada:
#   char* str --> $a0
# Parámetros de salida
#   int i --> $v0
#
# NO LLAMA A OTRA FUNCION --> NO HACE USO DE LA PILA --> FUNCION LEAF
#
# Tabla de registros:
# int i --> $t0 --> $v0
################################################################################
longitud_cadena:
#     int i = 0;
    move $t0, $zero

#     while (str[i] != '\0') {
while:
    add $t1, $a0, $t0
    lb $t2, 0($t1)

    beq $t2, $zero, while_fin

#         i++;
    addi $t0, $t0, 1 
    j while
#     }
while_fin:

#     return i;
    lw $v0, $t0
    jr $ra
# }
longitud_cadena__MARCAFIN:

# // Funcion 3: Recorre la cadena y llama a es_letra_a.
# // Si encuentra una 'a' o 'A', la cambia por un asterisco '*'.
# // Devuelve el numero total de cambios realizados.
################################################################################
# int censurar_cadena(char* str) {
# Parámetros de entrada:
#   char* str --> $a0
# Parámetros de salida:
#   int cambios --> $v0
#
# SÍ llama a otras funciones --> SÍ hace uso de la pila --> SÍ modifica el $ra
#
# Tabla de variables:
#   int i --> $s0
#   char* str[i] --> $s1
#   int k --> $s3 variable para guardar el valor 1
#   int cambios --> $s4

################################################################################

    # PUSH. $ra, $s0-$s4 = 6 * 4 = 24 que es multiplo de 8
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)

    move $s1, $a0

#     int i = 0;
    lw $s0, $zero

#     int cambios = 0;
    lw $s4, $zero

    # Inicializamos fuera del while k = 1 para poder hacer la comprobacion del if
    li $s3, 1

#     while (str[i] != '\0') {
while: 

#         // Ojo: al llamar a es_letra_a, machacaremos registros temporales
#         if (es_letra_a(str[i]) == 1) {
#             str[i] = '*';
#             cambios++;
#         }
#         i++;
#     }
#     return cambios;
# }