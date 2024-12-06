import 'package:flutter/material.dart';
import '../controllers/serie_controller.dart';
import '../models/serie.dart.dart';

class CadastroPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final generoController = TextEditingController();
  final descricaoController = TextEditingController();
  final capaController = TextEditingController();
  final pontuacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Série'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preencha os detalhes da série:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: nomeController,
                label: 'Nome',
                icon: Icons.title,
                validator: (value) =>
                value!.isEmpty ? 'O nome da série é obrigatório.' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: generoController,
                label: 'Gênero',
                icon: Icons.category,
                validator: (value) =>
                value!.isEmpty ? 'O gênero da série é obrigatório.' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: descricaoController,
                label: 'Descrição',
                icon: Icons.description,
                validator: (value) => value!.isEmpty
                    ? 'Por favor, adicione uma breve descrição da série.'
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: capaController,
                label: 'URL da Capa',
                icon: Icons.image,
                validator: (value) =>
                value!.isEmpty ? 'O URL da capa é obrigatório.' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: pontuacaoController,
                label: 'Pontuação',
                icon: Icons.star,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'A pontuação é obrigatória.';
                  }
                  final score = double.tryParse(value);
                  if (score == null || score < 0 || score > 10) {
                    return 'Pontuação deve ser um número entre 0 e 10.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final controller = SerieController();
                      final serie = Serie(
                        nome: nomeController.text,
                        genero: generoController.text,
                        descricao: descricaoController.text,
                        capa: capaController.text,
                        pontuacao: double.parse(pontuacaoController.text),
                      );
                      await controller.addSerie(serie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Série cadastrada com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
