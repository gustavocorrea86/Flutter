import 'package:estudamais/database/dao_user_resum.dart';

class CounterErrors {
  DaoUserResum databaseUser = DaoUserResum();
  String currentErrors = '';
  static int errors = 0;

  void updateErrors() {
    currentErrors = DaoUserResum.totalErrors;
    int countError = int.parse(currentErrors) + 1;
    databaseUser.updateErrors(countError.toString(), currentErrors);
    currentErrors = countError.toString();
  }
  void countErrors() {
    errors++;
  }
}

