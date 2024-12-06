import 'package:batalha2/views/home_page.dart';
import 'package:batalha2/views/view_batalha.dart';
import 'package:batalha2/views/view_de_cadastro.dart';
import 'package:batalha2/views/view_ranking.dart';
import 'package:batalha2/views/view_relatorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha de Séries',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cadastro': (context) => CadastroPage(),
        '/batalha': (context) => BatalhaPage(),
        '/ranking': (context) => RankingPage(),
        '/relatorio': (context) => RelatorioPage(),
      },
    );
  }
}
