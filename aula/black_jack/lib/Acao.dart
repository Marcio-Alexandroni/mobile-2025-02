enum Acao {
  comprar, apostar, fim;
  static String opcoes() {
    return '${comprar.name}, ${apostar.name}, ${fim.name}';
  }
}