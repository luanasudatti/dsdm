import 'dart:io';

class Ponto {
  int linha;
  int coluna;

  Ponto(this.linha, this.coluna);
}

class Jogo {
  static const int tamanho = 16;

  List<List<String>> tabuleiro = List.generate(
    tamanho,
    (_) => List.generate(tamanho, (_) => "|"),
  );

  int placarTime1 = 0;
  int placarTime2 = 0;

  Ponto? navio1;
  Ponto? navio2;

  void mostrarTabuleiro() {
    print("\n   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16");

    for (int i = 0; i < tamanho; i++) {
      String letra = String.fromCharCode(65 + i);
      stdout.write("$letra ");

      for (int j = 0; j < tamanho; j++) {
        stdout.write(" ${tabuleiro[i][j]} ");
      }

      print("");
    }
  }

  Ponto lerCoordenada() {
    while (true) {
      stdout.write("Digite coordenada (ex: A5): ");
      String? entrada = stdin.readLineSync();

      if (entrada == null || entrada.length < 2) {
        print("Entrada inválida.");
        continue;
      }

      entrada = entrada.toUpperCase();

      String letra = entrada[0];
      int linha = letra.codeUnitAt(0) - 65;

      int coluna;
      try {
        coluna = int.parse(entrada.substring(1)) - 1;
      } catch (e) {
        print("Número inválido.");
        continue;
      }

      if (linha >= 0 && linha < tamanho && coluna >= 0 && coluna < tamanho) {
        return Ponto(linha, coluna);
      } else {
        print("Coordenada fora do tabuleiro.");
      }
    }
  }

  void posicionarNavios() {
    print("\nTime 1 - Posicione seu navio");
    navio1 = lerCoordenada();

    print("\nTime 2 - Posicione seu navio");
    navio2 = lerCoordenada();
  }

  bool atacar(int time) {
    print("\nTurno do Time $time");

    Ponto ataque = lerCoordenada();

    if (time == 1) {
      if (ataque.linha == navio2!.linha && ataque.coluna == navio2!.coluna) {
        print("💥 ACERTOU O NAVIO!");
        tabuleiro[ataque.linha][ataque.coluna] = "X";
        placarTime1++;
        return true;
      }
    } else {
      if (ataque.linha == navio1!.linha && ataque.coluna == navio1!.coluna) {
        print("💥 ACERTOU O NAVIO!");
        tabuleiro[ataque.linha][ataque.coluna] = "X";
        placarTime2++;
        return true;
      }
    }

    print("🌊 Água!");
    tabuleiro[ataque.linha][ataque.coluna] = "O";
    return false;
  }

  void iniciar() {
    print("===== BATALHA NAVAL =====");
    print("Tabuleiro 16x16");
    print("Coordenadas de A1 até P16");

    posicionarNavios();

    bool jogo = true;

    while (jogo) {
      mostrarTabuleiro();

      if (atacar(1)) break;

      mostrarTabuleiro();

      if (atacar(2)) break;
    }

    print("\n===== FIM DO JOGO =====");

    print("Placar:");
    print("Time 1: $placarTime1");
    print("Time 2: $placarTime2");
  }
}

void main() {
  Jogo jogo = Jogo();
  jogo.iniciar();
}
