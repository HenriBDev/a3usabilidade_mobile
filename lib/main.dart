// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      bairros: List<String>.generate(10000, (i) => 'Item $i'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> bairros;
  const MyApp({super.key, required this.bairros});

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

class TelaPrincipal extends StatelessWidget {
  TelaPrincipal({Key? key}): super(key: key);

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
    final List<String> bairros;
    return ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ListTile(
          leading: Icon(Icons.house),
          title: Text("Bairros", style: TextStyle(fontSize: 25)),
        ),
        ListView.builder(
          itemCount: bairros.length,
          prototypeItem: ListTile(
            title: Text(bairros.first),
          ),
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


//onTap: ()=> widget.scaffoldKey.currentState.openDrawer(),