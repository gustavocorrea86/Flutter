
import 'dart:typed_data';



class ModelQuestions {
  String id;
  String elementarySchool;
  String schoolYear;
  String displice;
  String subject;
  String question;
  Uint8List image;
  String answer;
  String alternativeA;
  String alternativeB;
  String alternativeC;
  String alternativeD;

  ModelQuestions({
    required this.id,
    required this.elementarySchool,
    required this.schoolYear,
    required this.displice,
    required this.subject,
    required this.question,
    required this.image, // Assuming image is an object or null
    required this.answer,
    required this.alternativeA,
    required this.alternativeB,
    required this.alternativeC,
    required this.alternativeD,
  });

  ModelQuestions.toMap(Map<String, dynamic> ask,)
  
      : id = ask['id'].toString(),
        elementarySchool = ask['elementarySchool'],
        schoolYear = ask['schoolYear'],
        displice = ask['displice'],
        subject = ask['subject'],
        question = ask['question'],
        image = ask['image'],
        answer = ask['answer'],
        alternativeA = ask['alternativeA'],
        alternativeB = ask['alternativeB'],
        alternativeC = ask['alternativeC'],
        alternativeD = ask['alternativeD'];

  // Map<String, dynamic> toMap2(Map<String, dynamic> ask) {
  //   return {
  //     id: ask['id'].toString(),
  //       elementaryschool : ask['elementaryschool'],
  //       schoolyear : ask['schoolyear'],
  //       displice : ask['displice'],
  //       subject : ask['subject'],
  //       question : ask['question'],
  //       answer : ask['answer'],
  //       alternativeA : ask['alternativea'],
  //       alternativeB : ask['alternativeb'],
  //       alternativeC : ask['alternativec'],
  //       alternativeD : ask['alternatived']
  //   };
  // }
}
