import 'dart:io';
import 'dart:math';
import 'package:black_jack/Acao.dart';
import 'package:black_jack/Carta.dart';
import 'package:black_jack/Jogador.dart';

const copas = '\u2665';
const espadas = '\u2660';
const ouro = '\u2666';
const paus = '\u2663';

var jogadorPessoa = Jogador();

var cartas = <Carta>[];

var cartasMesa = <Carta>[];

void inicio() {

  print('### Black Jack ###');
  print('Informe o seu nome:');
  String? nomeJogador = stdin.readLineSync();
  jogadorPessoa = Jogador(nome: nomeJogador ?? "");
  print('Bem vindo: $jogadorPessoa');

}

void aposta(Jogador jogador) {

  print('${jogador.nome} quantidade apostada:');
  String? aposta = stdin.readLineSync();
  while (aposta == '') {
    print('${jogador.nome} quantidade apostada:');
    aposta = stdin.readLineSync();
  }
  jogador.aposta = int.parse(aposta!);
}

void criarCartas() {
  for (var i = 2; i < 11; i++) {
    cartas.add(Carta('$i$copas', i));
    cartas.add(Carta('$i$espadas', i));
    cartas.add(Carta('$i$ouro', i));
    cartas.add(Carta('$i$paus', i));
  }
    cartas.add(Carta('J$copas', 10));
    cartas.add(Carta('J$espadas', 10));
    cartas.add(Carta('J$ouro', 10));
    cartas.add(Carta('J$paus', 10));

    cartas.add(Carta('Q$copas', 12));
    cartas.add(Carta('Q$espadas', 12));
    cartas.add(Carta('Q$ouro', 12));
    cartas.add(Carta('Q$paus', 12));

    cartas.add(Carta('K$copas', 15));
    cartas.add(Carta('K$espadas', 15));
    cartas.add(Carta('K$ouro', 15));
    cartas.add(Carta('K$paus', 15));

    cartas.add(Carta('A$copas', 1));
    cartas.add(Carta('A$espadas', 1));
    cartas.add(Carta('A$ouro', 1));
    cartas.add(Carta('A$paus', 1));

}

void abreMesa() {

  for (var i = 0; i < 2; i++) {
    comprar();
  }

}

void comprar() {

  int idCarta = Random().nextInt(cartas.length - 1);
  cartasMesa.add(cartas.elementAt(idCarta));
  cartas.removeAt(idCarta);

}

void imprimeMesa() {
  print("-- Cartas Mesa --");
  var total = 0;
  for (var carta in cartasMesa) {
    print(carta);
    total += carta.valor;
  }
  print("-- Total pontos $total");

}

int valorCartas() {

  var total = 0;
  for (var carta in cartas) {
    total += carta.valor;
  }

  return total;

}
void main() {

  inicio();
  criarCartas();
  abreMesa();
  imprimeMesa();
  print ('Qual a sua ação? ${Acao.opcoes()}');
  String? acao = stdin.readLineSync();

  do {

    if (Acao.values.byName(acao!) == Acao.comprar) {
      comprar();
      imprimeMesa();
    } else if (Acao.values.byName(acao) == Acao.apostar) {
      aposta(jogadorPessoa);
    }

    if (Acao.values.byName(acao) != Acao.fim) {
      print ('Qual a sua ação? ${Acao.opcoes()}');
      acao = stdin.readLineSync();
    }

  } while (Acao.values.byName(acao!) != Acao.fim);

}