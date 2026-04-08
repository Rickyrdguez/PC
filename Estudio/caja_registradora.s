# #include <iostream>
# 
# int main() {
#     std::cout << "\n--- Calculadora de Caja ---\n";
#     
#     float total = 0.0;
#     float precio;
#     int articulos = 0;
# 
#     do {
#         std::cout << "Introduzca el precio del articulo (0 para terminar): ";
#         std::cin >> precio;
# 
#         if (precio > 0.0) {
#             total = total + precio;
#             articulos = articulos + 1; // O articulos++
#         }
# 
#     } while (precio > 0.0);
# 
#     std::cout << "\nNumero de articulos: " << articulos << "\n";
# 
#     // Aplicar descuento si el total es 50 euros o mas
#     if (total >= 50.0) {
#         std::cout << "Aplica descuento del 10%\n";
#         total = total * 0.90;
#     } else {
#         std::cout << "No aplica descuento\n";
#     }
# 
#     std::cout << "Total a pagar: " << total << " euros\n";
#     std::cout << "\nFin del programa\n";
#     
#     return 0;
# }

.data
    # --- Strings para los std::cout ---
    strTitulo:       .asciiz "\n--- Calculadora de Caja ---\n"
    strIntroPrecio:  .asciiz "Introduzca el precio del articulo (0 para terminar): "
    strNumArticulos: .asciiz "\nNumero de articulos: "
    strSaltoLinea:   .asciiz "\n"
    strAplicaDesc:   .asciiz "Aplica descuento del 10%\n"
    strNoDesc:       .asciiz "No aplica descuento\n"
    strTotalPagar:   .asciiz "Total a pagar: "
    strEuros:        .asciiz " euros\n"
    strFin:          .asciiz "\nFin del programa\n"

    # --- Constantes flotantes necesarias ---
    Cero:            .float 0.0
    Cincuenta:       .float 50.0
    FactorDesc:      .float 0.90

.text
####################################################################################

# float total --> $f20
# float precios --> $f21
# int productos --> $s0
# float cincuenta --> $f22
# float FactorDesc --> $f23
# float Cero --> $f24

####################################################################################

# int main() {
#     std::cout << "\n--- Calculadora de Caja ---\n";

  li $v0, 4 # Funcion escribir string
  la $a0, strTitulo # Cargamos strTitulo en $a0
  syscall # Mostramos por pantalla

  # Declaramos las constantes antes de entrar en el bucle para que el programa sea más optimo

  l.s $f22, Cincuenta # $f22 es igual al contenido de Cincuenta
  l.s $f23, FactorDesc # $f23 es igual al contenido de FactorDesc
  l.s $f24, Cero # $f24 es igual al contenido de Cero

 # Seguimos con el programa:

#     do {
Dowhile:

#         std::cout << "Introduzca el precio del articulo (0 para terminar): ";
  
  li $v0, 4 # Funcion escribir string
  la $a0, strIntroPrecio # Cargamos strIntroPrecio en $a0
  syscall # Mostramos por pantalla

#         std::cin >> precio;
  li $v0, 6 # Funcion leer un tipo flotante
  syscall

  # Lo leido, al ser un número en punto flotante se almacena en $f0, lo movemos a $f21
  mov.s $f21, $f0 # $f22 = $f0


#         if (precio > 0.0) {

if_while:

 # Como la condicion > no existe, hacemos la inversa, es decir, si precio <= 0 entonces saltamos al else

  c.le.s $f21, $f24 # $f21 <= $f24
  bc1t while

#             total = total + precio;

  add.s $f20, $f20, $f21 # $f20 = $f20 + $f21

#             articulos = articulos + 1;

  addi $s0, $s0, 1 # $s0 = $s0 + 1

#     } while (precio > 0.0);

  # La condicion > no existe, luego, hacemos la contraria, es decir, <=

While:
  c.le.s $f21, $f24
  bc1f Dowhile


#     std::cout << "\nNumero de articulos: " 

  li $v0, 4 # Funcion escribir string
  la $a0, strNumArticulos # Cargamos strNumArticulos en $a0
  syscall # mostramos por pantalla

#     << articulos << "\n";

  li $v0, 1 # Funcion mostrar enteros
  move $a0, $s0 # $a0 = $s0
  syscall # Muestra por pantalla


#     // Aplicar descuento si el total es 50 euros o mas
#     if (total >= 50.0) {
if:

  # La condicion >= no se puede hacer en punto flotante así que hacemos la inversa <

  c.lt.s $f20, $f22 # $f20 < $f22
  bc1t else_if

#         std::cout << "Aplica descuento del 10%\n";

  li $v0, 4 # Funcion escribir string
  la $a0, strAplicaDesc # Cargamos strAplicaDesc en $a0
  syscall # Muestra por pantalla

#         total = total * 0.90;

  mul.s $f20, $f20, $f23

  b if_fin

#     } else {
else_if:

#         std::cout << "No aplica descuento\n";

  li $v0, 4 # Funcion escribir string
  la $a0, strNoDesc # Cargamos strNoDesc en $a0
  syscall # Mostramos por pantalla

#     std::cout << "Total a pagar: " 

  li $v0, 4 # Funcion escribir string
  la $a0, strTotalPagar # Cargamos strTotalPagar en $a0
  syscall # Mostramos por pantalla

#      << total

  # Para mostrar el total movemos el contenido de total en $f12

  mov.s $f12, $f20 # $12 = $f20

  li $v0, 2 # Funcion escribir flotantes
  syscall # Mostrar por pantalla

#      << " euros\n";

  li $v0, 4 # Funcion escribir string
  la $a0, strEuros # Cargamos strEuros en $a0
  syscall # Mostramos por pantalla

if_fin:

#     std::cout << "\nFin del programa\n";

  li $v0, 4 # Funcion escribir string
  la $a0, strFin # Cargamos strFin a $a0
  syscall # Mostrar por pantalla  

#     return 0;

   li $v0, 10 # Funcion terminar el programa
   syscall # Fin de programa