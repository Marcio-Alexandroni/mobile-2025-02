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
      "imagem": "https://www.receitasnestle.com.br/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/494feec171f5683665eba434d22e52f5.webp?itok=n3xpYgtR"
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