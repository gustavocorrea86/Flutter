class ModelQuestions {
  String id;
  String elementarySchool;
  String series;
  String displice;
  String subject;
  String question;
  String response;
  String alternativeA;
  String alternativeB;
  String alternativeC;
  String alternativeD;

  ModelQuestions({
    required this.id,
    required this.elementarySchool,
    required this.series,
    required this.displice,
    required this.subject,
    required this.question,
    required this.response,
    required this.alternativeA,
    required this.alternativeB,
    required this.alternativeC,
    required this.alternativeD,
  });

  ModelQuestions.toMap(Map<String, dynamic> question)
      : id = question['id'],
        elementarySchool = question['ensino'],
        series = question['serie'],
        displice = question['materia'],
        subject = question['assunto'],
        question = question['pergunta'],
        response = question['resposta'],
        alternativeA = question['alternativas'][0],
        alternativeB = question['alternativas'][1],
        alternativeC = question['alternativas'][2],
        alternativeD = question['alternativas'][3];

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'ensino': elementarySchool,
  //     'serie': series,
  //     'materia': displice,
  //     'assunto': subject,
  //     'pergunta': question,
  //     'resposta': response,
  //     'alternativas': [alternativeA, alternativeB, alternativeC, alternativeD],
  //   };
  // }
}
