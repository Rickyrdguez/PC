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

.text
###############################################################################
#Tabla de resgistros
#int altura 	$s0
#float peso 	$f22 	$s1
#float altura 	$f24 	$t0
#float alturaEnMetros	$f16
#float Cien	$f17
#float IMC	$f26

###############################################################################

#   std::cout << "\nCalculo IMC\n";

	li $v0, 4 # Fucion escribir
	la $a0, strTitulo # Carga en $a0 strTitulo
	syscall # Llamada al sistema, imprime el strTitulo

#   int alturaCm;

	li $s8, $zero # Inicializamos altura a 0
	
#   do {

doWhile:

#     float peso;

	li $s1, $zero # Inicializamos peso a 0
	mtc1 $s1, $f20 # Llama al copro pasa a punto flotante
	cvt.s.w $f22, $f20 # $f22 = $f20
	
#     std::cout << "\nIntroduzca peso en kilogramos: ";

	li $v0, 4 # Funcion escribir
	la $a0, strIntroPeso 
	syscall

#     std::cin >> peso;

	li $v0, 6
	syscall
	mov.s $f22, $f20   # LA FUNCION 6 GUARDA EN f0 NO EN f20

#     std::cout << "Introduzca altura en centimetros (entero): ";

	li $v0, 4
	la $a0, strIntroAltura
	syscall

#     std::cin >> alturaCm;

	li $v0, 5
	syscall
	move $v0, $t0 # AL REVES GILIPOLLAS 

#Convertimos altura a punto flotante

	mtc1 $t0, $f20
	cvt.s.w $f24, $f20

#     // Convertir altura a metros
#     float alturaEnMetros = (float)alturaCm / 100.0;

	li.s $f17, 100.0

	div.s $f16, $f24, $f17  # $f16 = $f24 / $f17


#     // Cálculo del IMC
#     float imc = peso / (alturaEnMetros * alturaEnMetros);

	mul.s $f18, $f17, $f17 # $f18 = $f17 * $f17
	div.s $f26, $f22, $f18 # $f26 = $f22 / $f18

#     std::cout << "\nEl IMC para " << alturaCm << "cm es: " << imc;

	li $v0, 4
	la $a0, strElIMC 
	syscall 
	
	mov.s $f12, $f26 # $f12 = $f26
	
	li $v0, 2 # Funcion imprimir flotante
	syscall # $f12 ya estaba cargado

#     // Clasificacion del IMC
#     std::cout << "\nCategoria: ";

	li $v0, 4 # Funcion imprimir string
	la $a0, strCategoria
	syscall


#     if (imc >= 25.0) {

	li.s $f16, 25.0
	li.s $f18, 18.5
	li $s2, 220
# ESTO VA DENTRO DEL IF
# SI FUERA UN FOR SI QUE IRIRA FUERA

if_mayor_25:

	c.lt.s $f26, $f16, # else_mayor_18_5 ESO NO # si $f26 < $f16 salta a if_mayor_18_5 
	#bc1t else_mayor_25

#         std::cout << "Sobre";

	li $v0, 4 
	la $a0, strSobre
	syscall
	b if_fin

#     } else {

else_if_18_5:

#       if (imc >= 18.5) {

	c.lt.s $f26, $f18, else_if # si $f26 < $f18 salta a if_mayor_18_5


#           std::cout << "Normo";

	li $v0, 4 
	la $a0, strNormo
	syscall
	b if_fin

#       } else {

else_if:

#           std::cout << "Bajo ";

	li $v0, 4
	la $a0, strBajo
	syscall
	b if_fin
#       }
#     }

if_fin:

#     std::cout << "peso\n";

	li $v0, 4 
	la $a0, strPeso
	syscall

#   } while (alturaCm <= 220);

while:

	c.le.s $f24, 

while_fin:

#   std::cout << "\nTermina el programa\n";

	li $v0, 4
	la $a0, strTermina
	syscall

	li $v0, 10
	syscall


# }
