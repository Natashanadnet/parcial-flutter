//Ejercicio 1
void ejercicio1() {
  print('Ejercicio 1: Hola Mundo');
}

//Ejercicio 2
int suma(int a, int b) {
  return a + b;
}

void ejercicio2() {
  int num1 = 5;
  int num2 = 3;
  int resultado = suma(num1, num2);
  print('Ejercicio 2: La suma de los números $num1 y $num2 es: $resultado');
}

//Ejercicio 3
class Persona {
  String nombre;
  int edad;

  Persona(this.nombre, this.edad);

  void descripcion() {
    print('Ejercicio 3: Nombre: $nombre, Edad: $edad años');
  }
}

void ejercicio3() {
  Persona persona = Persona('Alejandro', 37);
  persona.descripcion();
}

//Ejercicio 4
int sumaLista(List<int> numeros) {
  int suma = 0;
  for (int numero in numeros) {
    suma += numero;
  }
  return suma;
}

void ejercicio4() {
  List<int> numeros = [1, 2, 3, 4, 5];
  int resultado = sumaLista(numeros);
  print('Ejercicio 4: La suma de los números en la lista es: $resultado');
}

//Ejercicio 5
String parOImpar(int numero) {
  if (numero % 2 == 0) {
    return 'Par';
  } else {
    return 'Impar';
  }
}

void ejercicio5() {
  int numero = 35;
  String resultado = parOImpar(numero);
  print('Ejercicio 5: El número $numero es $resultado');
}

//Ejercicio 6
int factorial(int n) {
  if (n == 0) {
    return 1;
  }
  return n * factorial(n - 1);
}

void ejercicio6() {
  int numero = 10;
  int resultado = factorial(numero);
  print('Ejercicio 6: El factorial de $numero es: $resultado');
}

//Ejercicio 7
double celsiusToFahrenheit(double celsius) {
  return (celsius * 9 / 5) + 32;
}

void ejercicio7() {
  double celsius = 10;
  double fahrenheit = celsiusToFahrenheit(celsius);
  print('Ejercicio 7: $celsius Celcius son $fahrenheit Farenheit');
}

//Ejercicio 8
String invertirCadena(String cadena) {
  return cadena.split('').reversed.join();
}

void ejercicio8() {
  String texto = 'Natasha';
  String textoInvertido = invertirCadena(texto);
  print('Ejercicio 8: Palabra: $texto');
  print('Palabra invertida: $textoInvertido');
}

//Ejercicio 9
//Se usa la clase Persona creada en el ejercicio 3
void ejercicio9() {
  List<Persona> targaryens = [
    Persona('Rhaenyra', 37),
    Persona('Aegon', 25),
    Persona('Aemond', 20),
  ];

  targaryens.sort((a, b) => a.edad.compareTo(b.edad));

  print('Ejercicio 9: Lista ordenada por edad de los Targaryens');
  for (Persona persona in targaryens) {
    print('Nombre: ${persona.nombre}, Edad: ${persona.edad}');
  }
}

//Ejercicio 10
List<String> convertidorMayus(List<String> palabras) {
  List<String> resultado = [];
  for (String palabra in palabras) {
    resultado.add(palabra.toUpperCase());
  }
  return resultado;
}

void ejercicio10() {
  List<String> muchasPalabras = ['hola', 'mundo', 'en', 'dart'];
  List<String> resultado = convertidorMayus(muchasPalabras);
  print('Ejercicio 10:');
  print('Lista de palabras: $muchasPalabras');
  print('Lista en mayúsculas: $resultado');
}

void main() {
  ejercicio1();
  ejercicio2();
  ejercicio3();
  ejercicio4();
  ejercicio5();
  ejercicio6();
  ejercicio7();
  ejercicio8();
  ejercicio9();
  ejercicio10();
}
