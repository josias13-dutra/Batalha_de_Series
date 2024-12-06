class Serie {
  int? id;
  String nome;
  String genero;
  String descricao;
  String capa; // Caminho para a imagem local
  double pontuacao;
  int vitorias;

  Serie({
    this.id,
    required this.nome,
    required this.genero,
    required this.descricao,
    required this.capa,
    required this.pontuacao,
    this.vitorias = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'genero': genero,
      'descricao': descricao,
      'capa': capa,
      'pontuacao': pontuacao,
      'vitorias': vitorias,
    };
  }

  static Serie fromMap(Map<String, dynamic> map) {
    return Serie(
      id: map['id'],
      nome: map['nome'],
      genero: map['genero'],
      descricao: map['descricao'],
      capa: map['capa'],
      pontuacao: map['pontuacao'],
      vitorias: map['vitorias'],
    );
  }
}
