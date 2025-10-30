import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(CotacaoStateless());
}

class CotacaoStateless extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cotação Moeda",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cotação Moeda", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.amber,
          leading: Icon(Icons.currency_exchange, color: Colors.white,),
        ),
        body: _CotacaoStateful(),
        floatingActionButton: FloatingActionButton(onPressed: (){}),
      )
    );

  }

}

class _CotacaoStateful extends StatefulWidget {

  @override
  State<_CotacaoStateful> createState() => _CotacaoState();

}

class _CotacaoState extends State<_CotacaoStateful> {

  final TextEditingController _valorController = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      TextField(
        controller: _valorController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(labelText: 'Valor'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        DropdownButton<String>(
          value: 'USD',
          onChanged: (v) => print (v),
          items: const [
            DropdownMenuItem(value: 'USD', child: Text('USD')),
            DropdownMenuItem(value: 'EUR', child: Text('EUR')),
            DropdownMenuItem(value: 'BRL', child: Text('BRL')),
          ],
        ),
          SizedBox(width: 50,),
          DropdownButton<String>(
          value: 'USD',
          onChanged: (v) => print (v),
          items: const [
            DropdownMenuItem(value: 'USD', child: Text('USD')),
            DropdownMenuItem(value: 'EUR', child: Text('EUR')),
            DropdownMenuItem(value: 'BRL', child: Text('BRL')),
          ],
        ),

      ],),

      ElevatedButton(onPressed: () async {


        try {
          final url = Uri.parse('https://api.frankfurter.app/latest?amount=1&from=BRL&to=USD');
          final resposta = await http.get(url);
          if (resposta.statusCode == 200) {
            final dados = json.decode(resposta.body);
            final rates = dados['rates'] as Map<String,dynamic>;
            setState(() {
              print(dados);
            });
          }
        } catch (e) {
          setState(() {
          });
        } finally {
          setState(() {
          });
        }

      }, child: Text("Mudar Texto"))
    ],
    mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

}

