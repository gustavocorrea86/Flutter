class Filme {
  String nome;
  String imagem;

  Filme({
    required this.nome,
    required this.imagem,
  });

  Filme.fromJson(Map<String, dynamic> json)
      : nome = json['nome'].toString(),
        imagem = json['imagem'].toString();
}