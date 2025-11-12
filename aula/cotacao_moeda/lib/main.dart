import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const CotacaoApp());
}

class CotacaoApp extends StatelessWidget {

  const CotacaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotação Moeda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const CotacaoSateful(title: 'Cotação Moeda'),
    );
  }
}

class CotacaoSateful extends StatefulWidget {

  const CotacaoSateful({super.key, required this.title});

  final String title;

  @override
  State<CotacaoSateful> createState() => _CotacaoState();
}

class _CotacaoState extends State<CotacaoSateful> {

  final TextEditingController _valorController = TextEditingController(text: "1");
  var _cotacaoDe = 'BRL';
  var _cotacaoPara = 'USD';
  var _resultado = "Resultado";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange, color: Colors.white,),
        title: Text(widget.title, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _valorController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Valor', border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // define o arredondamento
                  ),
                  ),
                ),
              ),
            Padding(padding: const EdgeInsets.all(16),
            child:         Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child:                 DropdownButton<String>(
                  value: _cotacaoDe,
                  onChanged: (v) {
                    print(v);
                    setState(() {
                      _cotacaoDe = v!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 'CAD', child: Text('CAD')),
                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    DropdownMenuItem(value: 'BRL', child: Text('BRL')),
                  ],
                ),),
                const SizedBox(width: 24),
                Expanded(child: DropdownButton<String>(
                  value: _cotacaoPara,
                  onChanged: (v) {
                    setState(() {
                      _cotacaoPara = v!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    DropdownMenuItem(value: 'BRL', child: Text('BRL')),
                  ],
                ),
                ),
              ],
            ),
            ),
              const SizedBox(height: 26,),
            Text(_resultado),
            const SizedBox(height: 26,),
            ElevatedButton(onPressed: () async {

              var url = Uri.parse("https://api.frankfurter.app/latest?amount=${_valorController.text}&from=$_cotacaoDe&to=$_cotacaoPara");
              var resposta = await http.get(url);
              final dado = json.decode(resposta.body);
              setState(() {
                if (dado["message"] == null) {
                  _resultado = "${dado['rates'][_cotacaoPara]}";
                } else {
                  _resultado = "${dado['message']}";
                }
              });

            }, child: const Text("Obter Cotação"))
          ]
        ),
      ),
    );


  }
}
