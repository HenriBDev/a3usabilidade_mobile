// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // Aqui instanciamos meu cronômetro
      home: TelaPrincipal(), //Cronometro(),
      initialRoute: '/',
      // routes: {
      //   '/cronometro': (context) => Cronometro(),
      // },
    );
  }
}

class DropdownFiltro extends StatefulWidget{
  const DropdownFiltro({super.key});

  @override
  State<DropdownFiltro> createState() => _DropdownFiltroState();
}

class _DropdownFiltroState extends State<DropdownFiltro> {
  String dropdownValue = "Logradouros";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: "Logradouros",
          child: Text("Logradouros"),
        ),
        DropdownMenuItem<String>(
          value: "Bairros",
          child: Text("Bairros"),
        )],
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  List<String> bairros = <String>['Teste', 'Teste'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imóveis em São Paulo'),
      ),
      body: Center(

        // colocar coisas da pagina central aqui

      ),
      drawer: Drawer(child: _criarMenuDrawer(context)),
    );
  }

  Widget _criarMenuDrawer(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: DropdownFiltro()
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: bairros.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.square),
              title: Text(bairros[index]),
            );
          },
        )
      ],
    );
  }
}

//onTap: ()=> widget.scaffoldKey.currentState.openDrawer(),