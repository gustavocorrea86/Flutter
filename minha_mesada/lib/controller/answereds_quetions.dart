import 'package:minha_mesada/database/dao_user_resum.dart';

class AnsweredsQuestions{
  DaoUserResum database = DaoUserResum();
  String currentAnswered = '';
  //String countAnswered = '';
  
  String answereds() {
    currentAnswered = DaoUserResum.answeredQuestions;
    int answeredQuestions = int.parse(currentAnswered) + 1;
    database.updateAnswereds(answeredQuestions.toString(), currentAnswered);
    currentAnswered = answeredQuestions.toString();
    return currentAnswered;
  }
  
}
