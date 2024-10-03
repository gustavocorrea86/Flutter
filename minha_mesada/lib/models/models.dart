class ModelQuiz {
  final String pergunta;
  final String resposta;
  final List<String> alternativas;

  ModelQuiz(
    this.pergunta,
    this.resposta,
    this.alternativas,
  );

  Map<String, dynamic> toMap() {
    return {
      'pergunta': pergunta,
      'resposta': resposta,
      'alternativas': alternativas,
    };
  }
}
 