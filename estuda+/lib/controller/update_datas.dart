import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/service/service.dart';


//utilizado para atualizar as questões respondidas após sair da tela das questões
class UpdateDatas {
  void updateDatas() {
    //limpa as questões obtidas por disciplina
    Service.questionsByDiscipline.clear();
    // limpa a list onde mostra as disciplinas selecionadas
    Service.listSelectedDisciplines.clear();
    // limpa as questões obtidas da busca por ano escolar
    Service.questionsBySchoolYear.clear();
    // limpa a list de disciplina, ano e assunto que foram obtidas da busca por ano selecionado
    Service.schoolYearAndSubjects.clear();
    // limpa list que onde mostra os anos selecionados
    Service.listSelectedSchoolYear.clear();
    // limpa a list da busca geral
    Service.resultQuestionsBySubjectsAndSchoolYear.clear();
    // atualiza a variavel dos ids respondidos
    DaoUserResum().findIdQuestions();
    // atualiza a variavel dos ids das incorretas
    DaoUserResum().findIdQuestionsIncorrect();
    // atualiza a variavel dos ids das incorretas
    DaoUserResum().findIdQuestionsCorrect();
    //faz a busca das questões respodidas corretamente atraves da atualização da variavel
    QuestionsCorrects().getQuestionsCorrects();
    //faz a busca das questões respodidas incorretamente atraves da atualização da variavel
    QuestionsIncorrects().getQuestionsIncorrects();
    // atualiza o dashbord na contagem das disciplinas respodidas corretamente
    QuestionsCorrects().counterDisciplineCorrects();
    // atualiza o dashbord na contagem das disciplinas respodidas incorretamente
    QuestionsIncorrects().counterDisciplineIncorrects();
  }
}
