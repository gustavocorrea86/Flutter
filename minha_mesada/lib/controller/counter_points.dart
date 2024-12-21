import 'package:estudamais/database/dao_user_resum.dart';

class CounterPoints {
  DaoUserResum databaseUser = DaoUserResum();
  String currentPoint = '';
  static int points = 0;

  void updatePoints() {
    currentPoint = DaoUserResum.totalPoints;
    int countPoint = int.parse(currentPoint) + 1;
    databaseUser.updatePoints(countPoint.toString(), currentPoint);
    currentPoint = countPoint.toString();
  }
  void countPoints() {
    points++;
  }
}
