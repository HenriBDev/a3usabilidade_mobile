import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

List<Venda> baseDados = [];
String? host_ip = '';

void main() async{
  await dotenv.load(fileName: ".env");
  host_ip = dotenv.env['HOST_IP'];
  baseDados = await HttpHelper().lerDados();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
    home: TelaPrincipal()
  ));
}

class Venda {
  String logradouro;
  String bairro;
  int preco;
  int numero;
  int area;
  int quartos;
  int banheiros;
  int vagas;

  Venda(this.logradouro, this.bairro, this.preco, this.numero, this.area, this.quartos, this.banheiros, this.vagas);
  Venda.fromJson(Map<String, dynamic> json) :
        logradouro = json["Logradouro"],
        bairro = json["Bairro"],
        preco = json["Preço (R\$)"],
        numero = json["Número"],
        area = json["Máximo Área (m²)"],
        quartos = json["Máximo Quartos"],
        banheiros = json["Máximo Banheiros"],
        vagas = json["Máximo Vagas"];

  String getFiltro(String filtro){
    if(filtro == 'logradouro'){
      return logradouro;
    }
    else if(filtro == 'bairro'){
      return bairro;
    }
    return '';
  }
}

class HttpHelper{
  final String dominio = (host_ip as String) + ':8080';
  final String caminho = 'lerDados';

  Future<List<Venda>> lerDados() async {
    final List<Venda> vendas = [];

    Uri url = Uri.http(dominio, caminho);
    http.Response result = await http.post(url);

    // Se o acesso ao web service for bem-sucedido.
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      for (var response in jsonResponse) {
        vendas.add(Venda.fromJson(response));
      }
      return vendas;
    } else {
      return vendas;
    }
  }
}

class CheckboxFiltro extends StatefulWidget{
  const CheckboxFiltro({super.key});

  @override
  State<CheckboxFiltro> createState() => _CheckboxFiltroState();
}

class _CheckboxFiltroState extends State<CheckboxFiltro> {
  String checkboxValue = '';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal>{
  String dropdownValue = 'logradouro';
  List<ListTile> listaFiltro = baseDados.map((venda) => ListTile(leading: CheckboxFiltro(), title: Text(venda.logradouro))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imóveis em São Paulo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Créditos'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaSecundaria()));
          },
        )
      ),
      drawer: Drawer(child: _criarMenuDrawer(context)),
    );
  }

  Widget _criarMenuDrawer(BuildContext context) {
    return ListView(
        children: [
          ListTile(
              title: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                    listaFiltro = baseDados.map((venda) => ListTile(leading: CheckboxFiltro(), title: Text(venda.getFiltro(value!)))).toList();
                  });
                },
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: "logradouro",
                    child: Text("Logradouros"),
                  ),
                  DropdownMenuItem<String>(
                    value: "bairro",
                    child: Text("Bairros"),
                  )
                ],
              )
          ),
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: listaFiltro,
          ),
        ]
      );
  }
}

class TelaSecundaria extends StatelessWidget {
  const TelaSecundaria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          child: Icon(Icons.arrow_left),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: Text('Créditos'),
      ),
      body: Center(
        child: Text(
          'Trabalho desenvolvido por:\nGilberto de Melo Junior\nHenrique Barbosa\nMarcus Gustavo Sigrist Romão',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
      )
    );
  }
}
