# // Desarrollar un programa para calcular el Indice de Masa Corporal (IMC)
# // a partir del peso y la altura.
# // Se entrará en un bucle donde se pedirá el peso en kilogramos
# // y la altura en centímetros.
# // A continuación se calculará el IMC y se dirá a que categoría
# // corresponde: Sobrepeso, Normopeso o Bajo peso.
# // Se saldrá del bucle si se ha introducido una altura superior a 220 cm,
# // terminando el programa.

# #include <iostream>
# #include <iomanip>

# int main() {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   std::cout << "\nCalculo IMC\n";

#   int alturaCm;
#   do {
#     float peso;
#     std::cout << "\nIntroduzca peso en kilogramos: ";
#     std::cin >> peso;

#     std::cout << "Introduzca altura en centimetros (entero): ";
#     std::cin >> alturaCm;

#     // Convertir altura a metros
#     float alturaEnMetros = (float)alturaCm / 100.0;

#     // Cálculo del IMC
#     float imc = peso / (alturaEnMetros * alturaEnMetros);

#     std::cout << "\nEl IMC para " << alturaCm << "cm es: " << imc;

#     // Clasificacion del IMC
#     std::cout << "\nCategoria: ";
#     if (imc >= 25.0) {
#         std::cout << "Sobre";
#     } else {
#       if (imc >= 18.5) {
#           std::cout << "Normo";
#       } else {
#           std::cout << "Bajo ";
#       }
#     }
#     std::cout << "peso\n";
#   } while (alturaCm <= 220);
#   std::cout << "\nTermina el programa\n";
# }
	.data
strTitulo:	.asciiz	"\nCalculo IMC\n"
strIntroPeso:	.asciiz	"\nIntroduzca peso en kilogramos: "
strIntroAltura:	.asciiz	"Introduzca altura en centimetros (entero): "
strElIMC:	.asciiz	"El IMC para "
strCmEs:	.asciiz	"cm es: "
strCategoria:	.asciiz	"\nCategoria: "
strSobre:	.asciiz	"Sobre"
strNormo:	.asciiz	"Normo"
strBajo:	.asciiz	"Bajo "
strPeso:	.asciiz	"peso\n"
strTermina:	.asciiz	"\nTermina el programa\n"
# Declaramos el 25.0, 18.5, 100 y 220 en memoria
Cien : .float 100.0
Maximo: .float 25.0
Intermedio: .float 18.5
Final: .word 220

.text
################################################################################
# Tabla  de variables
# int peso --> $f22
# int alturaCM --> $s1 --> $f24
# float alturaMetros --> $f16
# float AlturaMetros^2 --> $17
# Cien --> $f6
# float IMC --> $f26
# int Condicion --> $s0


#################################################################################
# int main() {
#   std::cout << "\nCalculo IMC\n";

  li $v0, 4 # Escribir string
  la $a0, strTitulo # Cargamos strTitulo a $a0
  syscall # Mostramos por pantalla

#   int alturaCm;
#   do {
doWhile:
#     float peso;
#     std::cout << "\nIntroduzca peso en kilogramos: ";

  li $v0, 4 # Escribir string
  la $a0, strIntroPeso # Movemos el strIntroPeso a $a0
  syscall # Mostramos string por pantalla

#     std::cin >> peso;

  li $v0, 6 # funcion leer flotantes
  syscall # la ejecutamos
  mov.s $f22, $f0 # movemos lo introducido al registro $f22

#     std::cout << "Introduzca altura en centimetros (entero): ";

  li $v0, 4 # Funcion escribir string
  la $a0, strIntroAltura # Movemos strIntroAltura a $a0
  syscall # Imprimimos por pantalla

#     std::cin >> alturaCm;

  li $v0, 5 # Funcion leer tipo entero
  syscall # Lo ejecuta
  move $s1, $v0 # Movemos a $s1 lo leido $s1 = $v0

  # pasamos alturaCM a tipo flotante
  mtc1 $s1, $f0  # Copia cruda de lo que hay en $s1, en $f0 tipo flotante
  cvt.s.w $f24, $f0 # Guarda en $f22 una copia en simple precision de $f0 

#     // Convertir altura a metros
#     float alturaEnMetros = (float)alturaCm / 100.0;
  l.s $f6, Cien # $f6 = Cien

  div.s $f16, $f24, $f6 # $f16 = $f24 / $f6

#     // Cálculo del IMC
#     float imc = peso / (alturaEnMetros * alturaEnMetros);
  mul.s $f17, $f16, $f16 # $f17 = $f16^2
  div.s $f26, $f22, $f17 # $f26 = $f22 / $f17

#     std::cout << "\nEl IMC para 
  
  li $v0, 4 # Funcion escribir string
  la $a0, strElIMC # carga el strElIMC en $a0
  syscall # muestra por pantalla

#     << alturaCm <<
  li $v0, 1 # Imprimir numero entero
  move $a0, $s1 # Movemos a $a0 el valor de $s1
  syscall # mostramos el int por pantalla

  # "cm es: " <<

  li $v0, 4 # Imprimir numero entero
  la $a0, strCmEs # Movemos a $a0 el strCmEs
  syscall # mostramos el string por pantalla  

  # << imc

  mov.s $f12, $f26

  li $v0, 2 # Imprimir numero float
  syscall # mostramos el float por pantalla

#     // Clasificacion del IMC
#     std::cout << "\nCategoria: ";

  li $v0, 4 # Funcion escribir string
  la $a0, strCategoria # Movemos a $a0 el strCategoria
  syscall # Mostramos por pantalla

  # Iniciamos la variable de condicion para que sea igual a 220
  lw $s0, Final

#     if (imc >= 25.0) {
if:
  # Condicion imc >= 25.0

  # Como esta condicion no existe, hacemos la inversa imc < 25
  
  # Cargamos en el temporal $f4, la direccion de memoria Maximo
  l.s $f4, Maximo

  c.lt.s $f4, $f26 # f26 < $f4
  bc1t if_else

#         std::cout << "Sobre";

  li $v0, 4 # Funcion escribir string
  la $a0, strSobre # movemos a $a0 strSobre
  syscall # Ejecutamos

  b if_fin

#     } else {
if_else:
#       if (imc >= 18.5) {
  
  # Como la condicion <= no existe, hacemos la inversa

  # Cargamos en el temporal $f2, la direccion de la memoria Medio
  l.s $f2, Intermedio

  c.lt.s $f2, $f26 # $f26 < $f2
  bc1t else 
 
#           std::cout << "Normo";

  li $v0, 4 # Funcion escribir string
  la $a0, strNormo # Cargamos el strNormo a $a0
  syscall # Mostramos por pantalla

  b if_fin

#       } else {
else:
#           std::cout << "Bajo ";
  li $v0, 4 # Funcion escribir string
  la $a0, strBajo # Cargamos el strBajo a $a0
  syscall # Mostramos por pantalla

  b if_fin

if_fin:
#     std::cout << "peso\n";
  li $v0, 4 # Funcion escribir string
  la $a0, strPeso # Cargamos el strPeso a $a0
  syscall # Mostramos por pantalla

#   } while (alturaCm <= 220);

  ble $s1, $s0, doWhile

doWhileFin:

#   std::cout << "\nTermina el programa\n";

  li $v0, 4 # Funcion escribir string
  la $a0, strTermina # cargar strTermina en $a0
  syscall # Muestra por pantalla

  # }

  li $v0, 10
  syscall # Fin de programa