## Flutter / Dart

- [Flutter Download Mac Silicon](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.24.3-stable.zip)
- [Flutter Download Mac Intel](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.24.3-stable.zip)
- [Flutter Download Windows](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.3-stable.zip)
### Linguagem Dart
- Primeiro programa em **Dart**

    ```c++
    void main() {
        print( '### Black Jack ###');
    }
    ```

***
### Variáveis
- Não precisa declarar explicitamente o tipo de dados desde que já seja atribuído um valor inicial
- Tipos de dados primitivos: `int`, `double`, `String` e `bool`
- Não é possíve utilizar uma variável antes que tenha um valor atribuído (*null safety*)!
    ```c
    void main() {
    
      int pontos_jogador;
      pontos_jogador = 0;
    
      var pontos_computador = 0;
      var nome_jogador = '';
    
      print('### Black Jack ###');
    
      print('Pontos computador $pontos_computador');
      print('Pontos computador $pontos_jogador');
    }
    ```
- Para obter dados de entrada, utilizar
    ```c
    import 'dart:io';
    String? nome_jogador = stdin.readLineSync();
    ```
***
### Constantes
- Criar constantes para representar os naipes do baralho
- - Definição de constantes
    ```c
    const COPAS = '\u2665';
    const ESPADAS = '\u2660';
    const OURO = '\u2666';
    const PAUS = '\u2663';
    ```
***
### Classes
- Criar uma classe para reprentar os jogadores do **Black Jack**
    ```c
    class Jogador {
      var nome = '';
      var aposta = 0;
      var pontos = 100;
    
      @override
      String toString() {
        return "$nome - pontos: $pontos";
      }
    }
    ```
- Instanciar e imprimir os valores padrão
    ```c
    var jogador = Jogador();
    print(jogador);
    ```
- Atribuir valores (não precisa de `get` e `set`)
    ```c
    var jogador = Jogador();
    jogador.nome = "Edson";
    print(jogador);
    ```
- Atributos e métodos `private` devem ser precedidos por "_"
    ```c
    class Jogador {
      var nome = '';
      var aposta = 0;
      var _pontos = 100;
    
      @override
      String toString() {
        return "$nome - pontos: $_pontos";
      }
    }
    ```
- Caso um atributo seja somente de leitura, criar o `get` correspondente
    ```c
    class Jogador {
      var nome = '';
      var aposta = 0;
      var _pontos = 100;
      get pontos => _pontos;
    
      @override
      String toString() {
        return "$nome - pontos: $pontos";
      }
    }
    ```
- Uma aposta deve ser limitada à quantidae de pontos que o jogador possui
    ```c
    var _aposta = 0;
    get aposta => _aposta;
    set aposta (nova_aposta) {
      if (nova_aposta < pontos) {
        this._aposta = nova_aposta;
      } else {
        print ('Valor invalido! Assumindo: $pontos');
        this._aposta = pontos;
      }
    }
    ```
- Criar um construtor para receber opcionalmente o nome do jogador - caso não informado, assume **Mesa**
    ```c
    class Jogador {
      var nome;
      var _pontos = 100;
      get pontos => _pontos;
    
      Jogador({this.nome = 'Mesa'});
    
    }
    ```
- Criar uma classe para representar uma carta
    ```c
    class Carta {
    
      var nome = '';
      var valor = 0;
    
      Carta (this.nome, this.valor);
    
      @override
      String toString() {
        return '$nome - $valor';
      }
    
    }
    ```
***
### Enums
- Criar um enumerado com as possíveis ações do jogador: *esperar*, *comprar* e *apostar*
```c
enum Acao {
  esperar, comprar, apostar, fim;
  static String opcoes() {
    return '${esperar.name}, ${comprar.name}, ${apostar.name}, ${fim.name}';
  }
}
```
***
### Funções Gerais
- Função para iniciar o jogo com as boas vindas
```c
void inicio() {
  print('### Black Jack ###');
  print('Informe o seu nome:');
  String? nome_jogador = stdin.readLineSync();
  jogador_pessoa = Jogador(nome: nome_jogador);
  print('Bem vindo: $jogador_pessoa');

}
```
- Registrar uma aposta para um jogador
```c
void aposta(Jogador jogador) {

  print('${jogador.nome} quantidade apostada:');
  String? aposta = stdin.readLineSync();
  while (aposta == '') {
    print('${jogador.nome} quantidade apostada:');
    aposta = stdin.readLineSync();
  }
 jogador.aposta = int.parse(aposta!);
}
```
- Definir uma variável do tipo lista que conterá todas as representações de cartas do baralho (incluir na classe `Jogador` também)
```c
var cartas = <Carta>[];
```
- Criar uma função para iniciar a lista de cartas
  ```c
  void criarCartas() {
    for (var i = 2; i < 11; i++) {
      cartas.add(Carta('$i$COPAS', i));
      cartas.add(Carta('$i$ESPADAS', i));
      cartas.add(Carta('$i$OURO', i));
      cartas.add(Carta('$i$PAUS', i));
    }
    cartas.add(Carta('J$COPAS', 10));
    cartas.add(Carta('J$ESPADAS', 10));
    cartas.add(Carta('J$OURO', 10));
    cartas.add(Carta('J$PAUS', 10));
  
    cartas.add(Carta('Q$COPAS', 10));
    cartas.add(Carta('Q$ESPADAS', 10));
    cartas.add(Carta('Q$OURO', 10));
    cartas.add(Carta('Q$PAUS', 10));
  
    cartas.add(Carta('K$COPAS', 10));
    cartas.add(Carta('K$ESPADAS', 10));
    cartas.add(Carta('K$OURO', 10));
    cartas.add(Carta('K$PAUS', 10));
  
    cartas.add(Carta('A$COPAS', 1));
    cartas.add(Carta('A$ESPADAS', 1));
    cartas.add(Carta('A$OURO', 1));
    cartas.add(Carta('A$PAUS', 1));
  
  }
  ```
- O sorteio de uma carta deve prever que ela seja sorteada apenas uma única vez
  ```c
  import 'dart:math'; // incluir o import no inicio do arquivo por conta do Random

  Carta sorteiaCarta() {
    int idCarta = Random().nextInt(cartas.length - 1);
    return cartas.removeAt(idCarta);
  }
  ```
- Escrever uma função para retornar o valor total das cartas na mão do jogador (utilizar o `forEach`)
```c
int valorCartas() {

  var total = 0;
  cartas.forEach((carta) {
    total += carta.valor;
  });

  return total;

}
```
- Definir uma função que retorna as opções para o usuário selecionar durante a sua jogada
```c
Acao opcoes() {
  print('O que você deseja? ${Acao.opcoes()}');
  var acao = stdin.readLineSync();
  switch (acao) {
    case "apostar":
      return Acao.apostar;
    case "comprar":
      return Acao.comprar;
    case "fim":
      return Acao.fim;
    default:
      return Acao.esperar;
  }
}
```    
***
### Conversor de Moedas
- Incluir a dependência `http`
```yaml
dependencies:
  flutter:
    sdk: flutter
  http:
```
- O *endpoint* a ser acessado é este: `https://api.frankfurter.app/latest?amount=$valor&from=$_moedaDe&to=$_moedaPara`
- O resultado tem o formato *json*
```json
{
  "amount": 1,
  "base": "BRL",
  "date": "2025-10-22",
  "rates": {
    "USD": 0.18566
  }
}
```
- Implementação
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const ConversorMoedasApp());
}

class ConversorMoedasApp extends StatelessWidget {
  const ConversorMoedasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const TelaConversor(),
    );
  }
}

class TelaConversor extends StatefulWidget {
  const TelaConversor({super.key});

  @override
  State<TelaConversor> createState() => _TelaConversorState();
}

class _TelaConversorState extends State<TelaConversor> {
  final TextEditingController _valorController = TextEditingController(text: "1");
  String _moedaDe = 'USD';
  String _moedaPara = 'EUR';
  String _resultado = '';
  bool _estaCarregando = false;

  Future<void> _converter() async {
    final valor = double.tryParse(_valorController.text);
    if (valor == null) {
      setState(() {
        _resultado = 'Valor inválido';
      });
      return;
    }

    setState(() {
      _estaCarregando = true;
    });

    try {
      final url = Uri.parse('https://api.frankfurter.app/latest?amount=$valor&from=$_moedaDe&to=$_moedaPara');
      final resposta = await http.get(url);
      if (resposta.statusCode == 200) {
        final dados = json.decode(resposta.body);
        final rates = dados['rates'] as Map<String,dynamic>;
        final convertido = rates[_moedaPara];
        setState(() {
          _resultado = '$valor $_moedaDe = $convertido $_moedaPara';
        });
      } else {
        setState(() {
          _resultado = 'Erro na conversão: ${resposta.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _resultado = 'Erro: $e';
      });
    } finally {
      setState(() {
        _estaCarregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Moedas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _moedaDe,
                    onChanged: (v) => setState(() => _moedaDe = v!),
                    items: const [
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      DropdownMenuItem(value: 'BRL', child: Text('BRL')),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: _moedaPara,
                    onChanged: (v) => setState(() => _moedaPara = v!),
                    items: const [
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      DropdownMenuItem(value: 'BRL', child: Text('BRL')),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _estaCarregando ? null : _converter,
              child: _estaCarregando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Converter'),
            ),
            const SizedBox(height: 24),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
```
- Dica: para acrescentar uma borda arredondata no `TextField` com margens internas (`Padding`):
```dart
Padding(padding: const EdgeInsets.all(16),
child: TextField(
  controller: _valorController,
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(labelText: 'Valor',     border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0), // define o arredondamento
  ),),
),
),
```
***
### Pedidos Pizza
- Criar uma nova verão do app para o pedido de pizzas utilizando *cards* e *pageview*
#### PageViewer
- O *pageviewer* tem os principais parâmetros:
    - **itemCount**: número total de páginas a serem exibidas
    - **controller**: controla qual página está visível e a rolagem
    - **itemBuilder**: cria cada página (**card**) do **PageView** (recebe o **BuildContext** e o índice da página)
    - **onPageChanged**: *callback* chamado quando o usuário desliza para uma nova página (recebe o índice da nova página)
#### Cards
- O **Card** é um *widget* que serve para exibir conteúdo agrupado dentro de um “cartão” com elevação e cantos arredondados
- Algumas propriedades
    - **elevation**: define a sombra do card, dando um efeito 3D
    - **shape**: permite arredondar os cantos ou adicionar bordas. Exemplo:
    ```dart
    RoundedRectangleBorder(side: BorderSide(color: Colors.green, width: 3), 
                           borderRadius: BorderRadius.circular(20))
    ```
    - **child**: recebe qualquer *widget* (geralmente **Column**, **Row** ou **ListTile**), isto é, o conteúdo do **Card**.
#### Expanded
- Permite definir como o espaço dentro de uma linha ou coluna é distribuído
```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```
- Dentro de uma coluna, utilizado para preencher todo o espaço restante
```dart
Column(
  children: [
    Text("Título"),
    Expanded(
      child: ListView(...), // ocupa o restante da tela
    ),
  ],
)
```
#### ClipRRect
- Usado para recortar seu filho em um retângulo com cantos arredondados
- Útil para dar efeito de borda arredondada em imagens, cards ou containers
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(20), // raio dos cantos
  child: Image.network(
    "https://example.com/pizza.jpg",
    width: 200,
    height: 150,
    fit: BoxFit.cover,
  ),
)
```
#### SnackBar
- Utilizado para exibir mensagens temporárias na parte inferior da tela
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Pizza adicionada ao pedido!"),
    duration: Duration(seconds: 2), // duração da mensagem
    action: SnackBarAction(
      label: "Desfazer",
      onPressed: () {
        // ação ao clicar
      },
    ),
  ),
);
```
#### Implementação
- Segue abaixo a implementação completa do app de pedido de pizza
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const PizzariaApp());
}

class PizzariaApp extends StatelessWidget {
  const PizzariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escolha sua Pizza',
      home: const TelaPizzas(),
    );
  }
}

class TelaPizzas extends StatefulWidget {
  const TelaPizzas({super.key});

  @override
  State<TelaPizzas> createState() => _TelaPizzasState();
}

class _TelaPizzasState extends State<TelaPizzas> {
  final List<Map<String, dynamic>> _pizzas = [
    {
      "nome": "Calabresa",
      "descricao": "Mussarela, calabresa fatiada e cebola roxa",
      "preco": 42.50,
      "imagem": "https://images.unsplash.com/photo-1594007654729-407eedc4be65?w=800"
    },
    {
      "nome": "Quatro Queijos",
      "descricao": "Mussarela, provolone, parmesão e gorgonzola",
      "preco": 44.90,
      "imagem": "https://images.unsplash.com/photo-1601924579644-c85c6f99b9a3?w=800"
    },
    {
      "nome": "Portuguesa",
      "descricao": "Presunto, ovos, cebola, ervilha e azeitona",
      "preco": 45.90,
      "imagem": "https://images.unsplash.com/photo-1618213837799-96b4492f88a6?w=800"
    },
  ];

  final List<int> _selecionadas = [];

  void _alternarSelecao(int index) {
    setState(() {
      if (_selecionadas.contains(index)) {
        _selecionadas.remove(index);
      } else {
        _selecionadas.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha sua Pizza 🍕'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _pizzas.length,
              controller: PageController(viewportFraction: 0.85),
              itemBuilder: (context, index) {
                final pizza = _pizzas[index];
                final selecionada = _selecionadas.contains(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: selecionada
                          ? const BorderSide(color: Colors.green, width: 3)
                          : BorderSide.none,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              pizza["imagem"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pizza["nome"],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pizza["descricao"],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "R\$ ${pizza["preco"].toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () => _alternarSelecao(index),
                                icon: Icon(
                                  selecionada ? Icons.check_circle : Icons.add_circle_outline,
                                ),
                                label: Text(selecionada ? "Selecionada" : "Adicionar"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selecionada ? Colors.green : Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 45),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _selecionadas.isEmpty
                  ? null
                  : () {
                final qtd = _selecionadas.length;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Você selecionou $qtd pizza(s)!")),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: Text(
                _selecionadas.isEmpty
                    ? "Nenhuma pizza selecionada"
                    : "Finalizar pedido (${_selecionadas.length})",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```
#### Refatoração
- O código acima pode ser melhorado criando componentes separados
- Criar uma classe de dados para encapsular os atributos da pizza (nome, descrição, preço e imagem)
- Utilizar a abordagem de métodos *callback* com o **VoidCallback**
```dart
class PizzaCard extends StatelessWidget {
  final bool selecionada;
  final VoidCallback onSelecionar; // callback recebido do pai

  const PizzaCard({
    super.key,
    required this.selecionada,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelecionar, // chama o callback quando clicado
      child: Text(selecionada ? "Selecionada" : "Adicionar"),
    );
  }
}
```
- Passando o *callback* como parâmetro para o *widget* **PizzaCard** via método construtor
```dart
class TelaPizzas extends StatefulWidget {
  @override
  State<TelaPizzas> createState() => _TelaPizzasState();
}

class _TelaPizzasState extends State<TelaPizzas> {
  bool selecionada = false;

  void alternarSelecao() {
    setState(() {
      selecionada = !selecionada; // atualiza estado do pai
    });
  }

  @override
  Widget build(BuildContext context) {
    return PizzaCard(
      selecionada: selecionada,
      onSelecionar: alternarSelecao, // passa função como callback
    );
  }
}
```
***
### Simple Black jack
- Criar uma pasta `assets` dentro da raiz do projeto
- Copiar o arquivo `card-deck.png` para dentro da pasta `assets`
- Incluir a referência dentro do arquivo `pubspec.yaml`
```yml
flutter:
  assets:
    - assets/
```
- As imagens podem ser obtidas aqui: [blackjack-logo.png](https://github.com/esensato/mobile-2024-02/blob/main/img/blackjack-logo.png) e [card-deck.png](https://github.com/esensato/mobile-2024-02/blob/main/img/card-deck.png) e [verso-carta.png](https://github.com/esensato/mobile-2024-02/blob/main/img/verso-carta.png)
- Incluir também as dependências
```yml
dependencies:
  image: ^4.2.0
  flutter:
    sdk: flutter
```
- Uma referência dos principais *widgets* do **flutter** podem ser vistos aqui [api.flutter.dev - material](https://api.flutter.dev/flutter/material/material-library.html)
- Dentro do arquivo `main.dart` definir a primeira tela do jogo
```dart
import 'package:flutter/material.dart';
void main() async {

  runApp(const BlackJackApp());

}

class BlackJackApp extends StatelessWidget {

  const BlackJackApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Simple Black Jack',
      home: Center(child: Text('Simple Black Jack'))
    );
  }
}
```
- Implementar a tela principal do jogo em um arquivo `tela_principal.dart` que servirá apenas para controlar a exibição das demais telas a serem criadas
```dart
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();

}

class _TelaPrincipalState extends State<TelaPrincipal> {
  
  @override
  Widget build(BuildContext context) {
      return const Scaffold(body: Center(child: Text('Simple Black Jack')));
  }

}
```
- Alterar a `main.dart` para que a propriedade `home` aponte para a `TelaPrincipal`
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack_local/tela_principal.dart';

void main() async {

  runApp(const BlackJackApp());

}

class BlackJackApp extends StatelessWidget {

  const BlackJackApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Simple Black Jack',
      home: TelaPrincipal()
    );

  }

}
```
- Criar uma *splash screen* para iniciar o jogo em um arquivo `splash_screen.dart`
```dart
import 'package:flutter/material.dart';

class BlackJackSplash extends StatelessWidget {

  const BlackJackSplash({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/blackjack-logo.png")
            ],
          ),
        )
    );
  }

}
```
- Cria inicialmente a tela de cadastro do jogador em um arquivo `tela_cadastro.dart`
```dart
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {

   const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();

}

class _TelaCadastroState extends State<TelaCadastro> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: const Center(child: Text('Tela de Cadastro'))
      ),
    );

  }

}
```
- Criar inicialmente a tela da mesa do jogo em um arquivo `tela_mesa_jogo.dart`
```dart
import 'package:flutter/material.dart';

class TelaMesaJogo extends StatefulWidget {

  final nome;

  const TelaMesaJogo({super.key, this.nome});

  @override
  State<TelaMesaJogo> createState() => _TelaMesaJogoState();
}

class _TelaMesaJogoState extends State<TelaMesaJogo> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: const Center(child: Text('Mesa do Jogo'))
      ),
    );
  }

}
```
- Atualizar a `tela_principal.dart` com o código para fechamento automático da tela e direcionamento para a tela de cadastro
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack_local/splash_screen.dart';
import 'package:simple_black_jack_local/tela_cadastro.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();

}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Widget telaAtual = const BlackJackSplash();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        telaAtual = TelaCadastro();
      });
    });

      return telaAtual;
  }

}
```
- Editar a tela de cadastro `tela_cadastro.dart` para que o jogador informe o seu nome utilizando um [TextField](https://api.flutter.dev/flutter/material/TextField-class.html) e um [ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)
- Para incluir espaços em branco entre os *widgets* pode-se utilizar o [SizedBox](https://api.flutter.dev/flutter/widgets/SizedBox-class.html)
```dart
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();

}

class _TelaCadastroState extends State<TelaCadastro> {

  var txtNome = TextEditingController();

  Widget getTxtNome() {
    return Container(margin: const EdgeInsets.all(12),
        child:  TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Informe o seu nome',
      ),
      controller: txtNome,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [
          Image.asset("assets/blackjack-logo.png", width: 128, height: 128),
          const SizedBox(height: 10.0),
          getTxtNome(),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Iniciar o jogo'),
          ),
        ],)
        ,
      ),
    );
  }

}
```
- Quando o *widget* `TelaCadastro` for instanciado ele deve receber um método de *callback* como parâmetro para que seja acionado quando o usuário clicar no botão **Iniciar Jogo**
```dart
class TelaCadastro extends StatefulWidget {

  Function? iniciarJogoOnClick;

   TelaCadastro({super.key,  this.iniciarJogoOnClick});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}
```
- Alterar também a função `build` para incluir no `onPressed` a chamada para o *callback* passando o nome do jogador como parâmetro
```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [
          Image.asset("assets/blackjack-logo.png", width: 128, height: 128),
          const SizedBox(height: 10.0),
          getTxtNome(),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {

              widget.iniciarJogoOnClick!(txtNome.text);

            },
            child: const Text('Iniciar o jogo'),
          ),
        ],)
        ,
      ),
    );
  }
```
- A mesma coisa deve ocorrer com a `BlackJackSplash`
```dart
import 'package:flutter/material.dart';

class BlackJackSplash extends StatelessWidget {

  final Function? onTimeout;

  const BlackJackSplash({super.key, this.onTimeout});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 5), () {
      onTimeout!();
    });

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/blackjack-logo.png")
            ],
          ),
        )
    );
  }
}
```
- Refatorar a `TelaPrincipal` para acionar as demais passando os métodos de *callback*
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack_local/splash_screen.dart';
import 'package:simple_black_jack_local/tela_cadastro.dart';
import 'package:simple_black_jack_local/tela_mesa_jogo.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();

}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Widget? telaAtual;

  _TelaPrincipalState() {

    telaAtual = BlackJackSplash(onTimeout: () => exibirTelaCadastro());

  }

  void exibirTelaCadastro() {

    setState(() {
      telaAtual = TelaCadastro(iniciarJogoOnClick: (nome){
        exibirTelaMesa(nome: nome);
      });
    });

  }

  void exibirTelaMesa({String nome = ''}) {

    setState(() {
      telaAtual = TelaMesaJogo();
    });

  }

  @override
  Widget build(BuildContext context) {

      return telaAtual!;

  }

}
```
- Editar a tela `tela_mesa_jogo.dart` que exibe a mesa do jogo
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack/jogador.dart';

class TelaMesaJogo extends StatefulWidget {

  var jogador_humano;

  TelaMesaJogo({jogador = ''}) {
    jogador_humano = Jogador(nome: jogador);
  }

  @override
  State<TelaMesaJogo> createState() => _TelaMesaJogoState();
}

class _TelaMesaJogoState extends State<TelaMesaJogo> {

  Widget getPlacar() {
    return Row(children: [
      Expanded(flex: 2, child: Text('Jogador: ${widget.jogador_humano.nome}')),
      Expanded(flex: 1,child: Text('Pontos: ${widget.jogador_humano.pontos}'))
    ]);
  }

  Widget getCartas() {
    return Row(children: [Expanded(child: Image.asset("assets/verso-carta.png")),
      Expanded(child: Image.asset("assets/verso-carta.png")),
      Expanded(child: Image.asset("assets/verso-carta.png")),
      Expanded(child: Image.asset("assets/verso-carta.png"))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [getPlacar(),
        getCartas(),
          getCartas()
        ]),
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            widget.jogador_humano.pontos++;
          });
        }),
      ),
    );
  }

}
```
- Para facilitar a manutenção, criar uma classe para armazenar as *decorations* e aplicar, por exemplo, no `Container` que contém as cartas da mesa
```dart
import 'package:flutter/material.dart';

class Decorations {

  static Decoration getBoxDecoration() {

    return BoxDecoration(
      color: Colors.green,
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
    );

  }

  static ButtonStyle getButtonStyle() {

    return ElevatedButton.styleFrom(
    backgroundColor: Colors.green[700],
    shadowColor: Colors.green,
    elevation: 3,
    );

  }

  static TextStyle getButtonTextStyle() {

    return const TextStyle(color: Colors.white);

  }

}
```
- Por exemplo, para as cartas
```dart
Widget getCartas() {
  return Container(decoration: Decorations.getBoxDecoration(),
  child:Row(children: [Expanded(child: Image.asset("assets/verso-carta.png")),
    Expanded(child: Image.asset("assets/verso-carta.png")),
    Expanded(child: Image.asset("assets/verso-carta.png")),
    Expanded(child: Image.asset("assets/verso-carta.png"))
  ]));

}
```
- Código de inicialização para carregar a imagem das cartas dentro de `_TelaMesaJogoState`
```dart

  // variaveis
  var imagemCarta;
  var versoCarta;
  var _esperar = true;
  var cartas;

  // método acionado na inicialização (somente uma vez)
  @override
  void initState() {
    super.initState();

    loadImagem(nome: 'verso-carta.png').then((img){
      versoCarta = img;
      // carrega as cartas com a imagem do verso
      cartas = [versoCarta, versoCarta, versoCarta, versoCarta];

    });

    loadImagem(nome: 'card-deck.png').then((img){
      imagemCarta = img;
      setState(() {
        _esperar = false;
        cartas[0] = getCarta(0, imagemCarta);
      });
    });
  }
```
- Incluir um [CircularProgressIndicator](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html) para exibir a tela somente quando a imagem das cartas for carregada
- Criar uma caixa de texto para que o jogador possa realizar a aposta
```dart
  Widget getAposta() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: (){
            // implementar: diminuir aposta
            },
          ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
            // implementar: aumentar aposta
            },
          )
        ]);
  }
```
#### Trabalhando com JSON
- Utilizar o pacote convert (`dart:convert`) para interpretar a sintaxe JSON com a função `json.decode`
- Objeto simples
```dart
import 'dart:convert';

var jsonMap = '{"id":"123"}'; //Objeto JSON simples
Map<String, dynamic> mapa = json.decode(jsonMap);
print(json.decode(mapa['id']));
```
- Objeto do tipo `array`
```dart
var jsonList = '[{"id":"123"}, {"id":"456"}]'; //Objeto JSON Array
List<dynamic> lista = json.decode(jsonList);
lista.forEach((element) {
  print(element['id']);
});
```
- Objeto complexo
```dart
// Array com Array
var jsonComplexo = '[{"id":"123", "itens":["A","B"]}, '{"id":"456", "itens":["C","D"]}]';
List<dynamic> listaComplexo = json.decode(jsonComplexo);
listaComplexo.forEach((element) {
  print(element['itens'][0]);
});
```
#### Requisições HTTP
- O pacote http (`package:http/http.dart`) oferece uma grande facilidade na execução de requisições *HTTP* (*GET*, *POST*, etc...)
- Tais requisições podem ser utilizadas para interagir com serviços publicados na Internet (nuvem) utilizando o padrão *RESTFul*
- A classe [Uri](https://api.flutter.dev/flutter/dart-core/Uri-class.html) possui uma série de funções interessantes para criar *URLs* padronizadas e faz parte do pacote *core* do **Flutter**
- Exemplo de uma requisição *GET*
```dart
import 'package:http/http.dart' as http;

final url = Uri.https('simple-black-jack.glitch.me', 'pontos');
http.get(uri,
    headers: <String, String> {'Content-Type' : 'application/json', 'Accept' : 'application/json'})
    .then((resposta) => {
      if (resposta.statusCode == 200) {
        print(jsonDecode(resposta.body));
      }
});
```
- Exemplo de uma requisição *POST*
```dart
final url = Uri.https('simple-black-jack.glitch.me', 'novo');
final Map<String, String> header = {'Content-Type' : 'application/json',
                                    'Accept' : 'application/json'};
final body = '{"username":"${username.text}"}';
// requisição http é assíncrona
http.post(url, headers: header, body: body).then((resp) {

    print(resp);

});
```
- Funções úteis para manipulação de imagens
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

const larguraImagem = 99;
const alturaImagem = 153;
const totalCartaLinha = 4;
const totalCartaColuna = 13;

Future<Uint8List> loadImagem({String nome = ''}) async {

  WidgetsFlutterBinding.ensureInitialized();
  final ByteData data = await rootBundle.load("assets/$nome");
  return data.buffer.asUint8List();

}

Uint8List getCarta(int nro, Uint8List imagem) {

  var originalImage = img.decodeImage(imagem);
  var copyedImage = img.copyCrop(originalImage!, getImgX(nro), getImgY(nro), larguraImagem, alturaImagem);
  return Uint8List.fromList(img.encodePng(copyedImage));

}

int getImgX(int pos) {

  final int x = pos - ((pos ~/ totalCartaColuna) * totalCartaColuna);
  print('x = $x, ${x * larguraImagem}');
  return x * larguraImagem - (x * 0.5).toInt();

}

int getImgY(int pos) {

  final int y = (pos ~/ totalCartaColuna);
  print('y = $y, ${y * alturaImagem}');
  return y * alturaImagem;

}
```
***
### Persistência com SQLite
- Adicionar as dependências no `pubspec.yaml`
```yml
sqflite:
path:
```
- Criar uma classe para representar os dados que serão persistidos
```dart
class JogadorDB {

    String username;
    
    JogadorDB({this.username = ''});
    
    Map<String, dynamic> toMap() {
    
      return {'username': username};
    
    }
}
```
- Criar uma classe para encapsular as operações de banco de dados
```dart
import 'package:sqflite/sqflite.dart';
class DB {

}
```
- Função para iniciar o banco de dados
```dart
static Future<Database> abrir() async {

  Database db =  await openDatabase("SimpleBlackJackDB", onCreate: (db, version){
        db.execute("CREATE TABLE TAB_JOGADOR (ID INTEGER PRIMARY KEY, USERNAME TEXT)");
      }, version: 1);

  return db;

}
```
- Função para inserir um jogador
```dart
static Future<int> inserir(Database db, JogadorDB jogador) async {

  var id = await db.insert('TAB_JOGADOR', jogador.toMap());
  return id;

}
```
- Função para listar
```dart
static Future<List<Map>> listar(Database db, String username) async {

  return db.query('TAB_JOGADOR', where: "USERNAME = ?", whereArgs: [username]);

}
```
- Alterar a classe `TelaPrincipal` cadastrar o jogador
```dart
DB.abrir().then((db){
    DB.listar(db, nome).then((resultado){
      if (resultado.isEmpty) {
        DB.inserir(db, JogadorDB(username: nome)).then((id){
          print('Jogador inserido: $id');
        });
      } else {
        nome = resultado.single['USERNAME'];
        print('Jogador banco de dados: $nome');
      }
      exibirTelaMesa(nome: nome);
    });
});
```
- Alterar a classe `TelaPrincipal` para verificar após o *splash* se o jogador ja existe
```dart
DB.abrir().then((db){
    DB.listar(db, nome).then((resultado){
      if (resultado.isEmpty) {
        exibirTelaCadastro();
      } else {
        nome = resultado.single['USERNAME'];
        print('Jogador banco de dados: $nome');
        exibirTelaMesa(nome: nome);
      }

    });
});
```




