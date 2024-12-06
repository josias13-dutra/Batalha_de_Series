import 'package:flutter/material.dart';
import '../controllers/batalha_controller.dart';
import '../models/serie.dart.dart';

class BatalhaPage extends StatefulWidget {
  @override
  _BatalhaPageState createState() => _BatalhaPageState();
}

class _BatalhaPageState extends State<BatalhaPage> {
  final BatalhaController _controller = BatalhaController();
  List<Serie> _series = [];
  Serie? _serie1;
  Serie? _serie2;

  @override
  void initState() {
    super.initState();
    _loadSeries();
  }

  Future<void> _loadSeries() async {
    final series = await _controller.getSeries();
    setState(() {
      _series = series;
      if (_series.length >= 2) {
        _serie1 = _series[0];
        _serie2 = _series[1];
      }
    });
  }

  Future<void> _registrarVitoria(Serie vencedora) async {
    await _controller.registrarVitoria(vencedora);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Vitória registrada para ${vencedora.nome}!'),
        backgroundColor: Colors.green,
      ),
    );
    _loadSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batalha de Séries'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: _series.length < 2
          ? const Center(
        child: Text(
          'Cadastre pelo menos duas séries para começar!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Escolha a sua série favorita!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _serieCard(context, _serie1!),
                const Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _serieCard(context, _serie2!),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _registrarVitoria(_serie1!),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Vencer: ${_serie1!.nome}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _registrarVitoria(_serie2!),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Vencer: ${_serie2!.nome}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serieCard(BuildContext context, Serie serie) {
    return Expanded(
      child: Card(
        color: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                serie.nome,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                serie.descricao,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Gênero: ${serie.genero}',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Text(
                'Pontuação: ${serie.pontuacao.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
