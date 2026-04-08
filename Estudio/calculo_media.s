#include <iostream>

# int main() {
#     std::cout << "\n--- Clasificador de Numeros ---\n";
#     
#     int numero;
#     int pares = 0;
#     int impares = 0;
#     int sumaTotal = 0;
# 
#     std::cout << "Introduzca un numero (negativo para salir): ";
#     std::cin >> numero;
# 
#     while (numero >= 0) {
#         sumaTotal = sumaTotal + numero;
# 
#         // Comprobar si es par o impar usando el resto de la division por 2
#         if (numero % 2 == 0) {
#             std::cout << "Es par\n";
#             pares = pares + 1;
#         } else {
#             std::cout << "Es impar\n";
#             impares = impares + 1;
#         }
# 
#         std::cout << "Siguiente numero: ";
#         std::cin >> numero;
#     }
# 
#     std::cout << "\nResultados finales:\n";
#     std::cout << "Total pares: " << pares << "\n";
#     std::cout << "Total impares: " << impares << "\n";
#     std::cout << "Suma acumulada: " << sumaTotal << "\n";
#     std::cout << "\nFin del programa\n";
#     
#     return 0;
# }

.data
    strTitulo:      .asciiz "\n--- Clasificador de Numeros ---\n"
    strInput:       .asciiz "Introduzca un numero (negativo para salir): "
    strSiguiente:   .asciiz "Siguiente numero: "
    strEsPar:       .asciiz "Es par\n"
    strEsImpar:     .asciiz "Es impar\n"
    strResFinal:    .asciiz "\nResultados finales:\n"
    strPares:       .asciiz "Total pares: "
    strImpares:     .asciiz "Total impares: "
    strSuma:        .asciiz "Suma acumulada: "
    strSalto:       .asciiz "\n"
    strFin:         .asciiz "\nFin del programa\n"

.text
#################################################################################################

# int numero -->
# int pares --> 
# int impares -->
# int SumaTotal --> 
# double resto -->