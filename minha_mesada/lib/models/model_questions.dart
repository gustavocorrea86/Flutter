class ModelQuestions {
  String id;
  String elementaryschool;
  String schoolyear;
  String displice;
  String subject;
  String question;
  String answer;
  String alternativeA;
  String alternativeB;
  String alternativeC;
  String alternativeD;

  ModelQuestions({
    required this.id,
    required this.elementaryschool,
    required this.schoolyear,
    required this.displice,
    required this.subject,
    required this.question,
    required this.answer,
    required this.alternativeA,
    required this.alternativeB,
    required this.alternativeC,
    required this.alternativeD,
  });

  ModelQuestions.toMap(Map<String, dynamic> ask)
      : id = ask['id'].toString(),
        elementaryschool = ask['elementaryschool'],
        schoolyear = ask['schoolyear'],
        displice = ask['displice'],
        subject = ask['subject'],
        question = ask['question'],
        answer = ask['answer'],
        alternativeA = ask['alternativea'],
        alternativeB = ask['alternativeb'],
        alternativeC = ask['alternativec'],
        alternativeD = ask['alternatived'];

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
