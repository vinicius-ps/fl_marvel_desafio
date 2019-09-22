import 'dart:math';

final _random = new Random();

List<int> pegarNumerosAleatorios(int minimo, int maximo,int quantos) {

  int next(int min, int max) => min + _random.nextInt(max - min);

  List<int> numeros = new List();
  int num;
  for (var i = 0; i < quantos; i++) {
    bool verif = false;
    do {
      num = next(minimo, maximo);
      verif = verificar(num, numeros);
    } while (verif);
    numeros.add(num);
  }

  return numeros;
}

bool verificar(int num, List<int> lista) {
  bool teste = false;

  lista.forEach((valor) {
    if (valor == num) {
      teste = true;
    }
  });
  return teste;
}


