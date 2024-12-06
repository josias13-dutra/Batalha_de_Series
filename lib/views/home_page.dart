import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Batalha de Séries',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha uma opção para começar:',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            _menuButton(
              context: context,
              icon: Icons.add_circle_outline,
              label: 'Cadastrar Série',
              onTap: () => Navigator.pushNamed(context, '/cadastro'),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context: context,
              icon: Icons.sports_esports,
              label: 'Iniciar Batalha',
              onTap: () => Navigator.pushNamed(context, '/batalha'),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context: context,
              icon: Icons.leaderboard,
              label: 'Ver Ranking',
              onTap: () => Navigator.pushNamed(context, '/ranking'),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context: context,
              icon: Icons.picture_as_pdf,
              label: 'Gerar Relatório',
              onTap: () => Navigator.pushNamed(context, '/relatorio'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple.shade600,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
