import 'package:flutter/material.dart';
import '../controllers/serie_controller.dart';
import '../models/serie.dart.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final SerieController _controller = SerieController();
  List<Serie> _series = [];

  @override
  void initState() {
    super.initState();
    _loadRanking();
  }

  Future<void> _loadRanking() async {
    final series = await _controller.getAllSeries();
    setState(() {
      _series = series;
      _series.sort((a, b) {
        final vitoriasA = a.vitorias ?? 0;
        final vitoriasB = b.vitorias ?? 0;
        return vitoriasB.compareTo(vitoriasA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking de Séries'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _series.isEmpty
            ? const Center(
          child: Text(
            'Nenhuma série cadastrada ainda!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : ListView.builder(
          itemCount: _series.length,
          itemBuilder: (context, index) {
            final serie = _series[index];
            return _rankingCard(serie, index + 1);
          },
        ),
      ),
    );
  }

  Widget _rankingCard(Serie serie, int rank) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(
            '$rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: Text(
          serie.nome,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gênero: ${serie.genero}'),
            Text('Vitórias: ${serie.vitorias ?? 0}'),
          ],
        ),
        trailing: Text(
          'Pontuação: ${serie.pontuacao.toStringAsFixed(1)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
