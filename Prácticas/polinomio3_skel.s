#// Programa para evaluar polinomio tercer grado
#//Realiza un programa en ensamblador MIPS que evalúe un polinomio de tercer 
#//grado de la forma 
#//f(x) = a x^3 + b x^2 + c x + d
#//en un rango de valores enteros [r,s] y devuelva aquellos valores que 
#//son mayores de 2.5
#//El programa debe pedir por consola:
#//- cuatro números flotantes en simple precisión: a, b, c y d
#//- dos números enteros r y s comprobando que r <= s 

# Testear en
# https://codetest.iaas.ull.es/testeaPrinComp/testea/bbad44792ef4f0305d176

# #include <iostream>
# #include <iomanip>

# int main(void) {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   float a,b,c,d;
#   std::cout << "\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
#             << " en un intervalo [r,s]\n";
#   std::cout << "\nIntroduzca coeficiente a: ";
#   std::cin >> a;
#   std::cout << "Introduzca coeficiente b: ";
#   std::cin >> b;
#   std::cout << "Introduzca coeficiente c: ";
#   std::cin >> c;
#   std::cout << "Introduzca coeficiente d: ";
#   std::cin >> d;
#   int r,s;
#   do {
#     std::cout << "\nLímite inferior r: ";
#     std::cin >> r;
#     std::cout << "Límite superior s: ";
#     std::cin >> s;
#   } while (r > s);

#   for (int x = r ; x <= s ; x++) {
#     // float f = x*x*x*a + x*x*b + x*c + d;
#     float f = d;
#     f += x*c;
#     f += x*x*b;
#     f += x*x*x*a;
#    if (f >= 2.5) {
#      std::cout << "f(" << x << ") = " << f;
#    } else {
#      std::cout << x << " no supera";
#    }
#    std::cout << '\n';
#   }
#   std::cout << "\n\nTermina el programa\n";
# }

	.data
strTitulo:	.ascii	"\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
		.asciiz	" en un intervalo [r,s]\n"
strIntroA:	.asciiz	"\nIntroduzca coeficiente a: "
strIntroB:	.asciiz	"Introduzca coeficiente b: "
strIntroC:	.asciiz	"Introduzca coeficiente c: "
strIntroD:	.asciiz	"Introduzca coeficiente d: "

strIntroR:	.asciiz	"\nLímite inferior r: "
strIntroS:	.asciiz	"Límite superior s: "

strF:		.asciiz	"f("
strIgual:	.asciiz	") = "
strNoSupera:	.asciiz	" no supera"
strTermina:	.asciiz	"\n\nTermina el programa\n"

	.text

################################################################################
#tabla de variables a registros
# float a -> $f20
# float b -> $f22
# float c-> $f24
# float d> $f26
# float a -> $f20
# int r -> $s0
# int s-> $s1
# int x-> $s2 	 en el copro en $f16
# float f -> $f28

# int main(void) {
main:

#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   float a,b,c,d;

#   std::cout << "\nEvaluacion polinomio f(x) = a x^3 + b x^2 + c x + d"
#             << " en un intervalo [r,s]\n";

	li	$v0, 4 # Funcion escribir
	la	 $a0, strTitulo # Escribe el título
	syscall

#   std::cout << "\nIntroduzca coeficiente a: ";

	li	$v0, 4 # Funcion escribir
	la	 $a0, strIntroA # Escribe el introduzca A
	syscall

#   std::cin >> a;
	li $v0,6 # Funcion guardar
	syscall
	mov.s	$f20, $f0 # Guarda lo leído en $f20

#   std::cout << "Introduzca coeficiente b: ";

	li	$v0, 4
	la	 $a0, strIntrob
	syscall

#   std::cin >> b;

	li $v0,6
	syscall
	mov.s	$f22, $f0

#   std::cout << "Introduzca coeficiente c: ";

	li	$v0, 4
	la	 $a0, strIntroB
	syscall

#   std::cin >> c;

	li $v0,6
	syscall
	mov.s	$f24, $f0

#   std::cout << "Introduzca coeficiente d: ";

	li	$v0, 4
	la	 $a0, strIntroD
	syscall

#   std::cin >> d;

	li $v0,6
	syscall
	mov.s	$f26, $f0


#   int r,s;



#   do {
do_while_rs:

#     std::cout << "\nLímite inferior r: ";

	li	$v0,4 # Funcion escribir
	la	$a0, strIntroR # Escribe introduce r
	syscall

#     std::cin >> r;

	li $v0,5 # Funcion guardar
	syscall
	move $s0, $v0 # Mueve de $v0 a $s0

#     std::cout << "Límite superior s: ";
	li	$v0,4 # Funcion escribir
	la	$a0, strIntroS # Escribe introduce s
	syscall

#     std::cin >> s;
	li $v0,5 # Funcion guardar
	syscall
	move $s1, $v0 # Guarda lo introducido en $s1

#   } while (r > s);
	bgt	$s0, $s1, do_while_rs # si se cumple $s0 > $s1 salta a do_while_rs
do_while_rs_fin:


#   for (int x = r ; x <= s ; x++) {
#     // float f = x*x*x*a + x*x*b + x*c + d;

#     float f = d;
	mov.s	$f28,$f26

	# Pasar x a un registro de copro $f16
	mtc1	$s2, $f18
	cvt.s.w	$f16.$f18

#     f += x*c;	f = f + x*c
	mul.s	$f4, $f16, $f24 # x*c va a $f4
	add.s 	$f18, $f28, $f4 # f + (x*c) va a $f18

#     f += x*x*b;	f = f + (x*x*b)
	mul.s	$f6, $f16, $f16 # x*x va a $f6
	mul.s	$f8, $f6, $f22 # el resultado de $f6 * $f22 se guarda en $f8
	add.s	$f28, $f28, $f8 # el reultado de f + (x*x*b) se guarda en $f18

#     f += x*x*x*a;
	mul.s	$f4, $f16, $f16 # Guardamos x*x en $f4
	mul.s	$f6, $f4, $f16 # Guardamos $f4 * x en $f16
	mul.s	$f8

#    if (f >= 2.5) {
if_f_25:

	li.s	$f4, 2.5
	c.lt.s $f28, $f4
	bc1t	if_f_25_else


if_f_25_then:

#      std::cout << "f(" << x << ") = " << f;
	# std::cout << "f(
	li	$v0,4
	la	$a0, strF
	syscall

	# std::cout << "
	li	$v0,4
	move 	$a0, $s2
	syscall

	# std::cout << " =
	li	$v0,4
	move $a0, strIgual
	syscall

	# std::cout << " f
	li	$v0,4
	move $a0, strIgual
	syscall

#    } else {

	b	if_f_25_fin
if_f_25_else:

#      std::cout << x << " no supera";
	li	$v0,4
	la	$a0, strNoSupera
	syscall

#    }
#    std::cout << '\n';

#   }
#   std::cout << "\n\nTermina el programa\n";
	li	$v0,4
	la	$a0, strTermina
	syscall

# }

	li 	 $v0, 10
	syscall

