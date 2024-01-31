
import 'package:rootine_flutter_real/repositories/UsersRepository.dart';

import '../models/User.dart';
import '../models/friend.dart';
import '../models/goal.dart';
import '../util/GoalStates.dart';
import 'DataRepository.dart';

class GoalsManager {

  static final GoalsManager goalsManager = GoalsManager();

  DateTime endOfWeek = DateTime.now();
  int daysUntilEndOfWeek = 0;
  List<Goal> allGoals = [];
  List<Goal> shelved = [];
  List<Goal> completed = [];
  List<Goal> inProgress = [Goal("34")];

  Future<List<Goal>> getInProgress() async {
    inProgress.clear();
    for (var goal in allGoals) {
      if (goal.state == GoalStates.INPROGRESS) {
        inProgress.add(goal);
      }
    }
    return inProgress;
  }

  Future<List<Goal>> getCompleted() async {
    completed.clear();
    for (var goal in allGoals) {
      if (goal.state == GoalStates.COMPLETE) {
        completed.add(goal);
      }
    }
    return completed;
  }

  Future<List<Goal>> getShelved() async {
    shelved.clear();
    for (var goal in allGoals) {
      if (goal.state == GoalStates.SHELVED) {
        shelved.add(goal);
      }
    }
    return shelved;
  }

  /*static Future<void> updateRootine(Goal rootine) async {
    var doc = FirebaseFirestore.instance.collection("goals").doc(rootine.identification);
    var goalEssen = GoalEssen(
      identification: rootine.identification,
      name: rootine.name,
      units: rootine.units,
      goal: rootine.goal,
      endDateString: rootine.endDateString,
      initialProgress: rootine.initialProgress,
      startDateString: rootine.startDateString,
      userId: UserRepository.getCurrentUserId(),
      weeklyStartingPoint: rootine.weeklyStartingPoint,
      progress: rootine.progress,
      state: rootine.state,
      time: rootine.time,
      private: rootine.private,
    );
    await doc.set(goalEssen.toMap());
  }*/

  void calculateEndOfWeek() async {
    final prevEndOfWeek = endOfWeek;
    endOfWeek = getEndOfWeek(DateTime.now());
    if (prevEndOfWeek != endOfWeek) {
      print("Milestone Reached!");
      await updateRootines();
    }
  }

  Future<void> updateRootines() async {
    for (final r in allGoals) {
      r.milestoneUpdate();
    }
  }

  Future<void> updateGoal(Goal goal) async {
    //await DataRepository.updateGoal(goal);
  }

  void calculateDaysUntilEndOfWeek() {
    daysUntilEndOfWeek = (DateTime.now()).difference(endOfWeek).inDays;
  }

  DateTime getEndOfWeek(DateTime date) {
    return date.add(Duration(days: (DateTime.sunday - date.weekday).toInt()));
  }

  Future<void> checkForMilestone() async {
    //final savedWeek = (await UserRepository.loadUserInfo()).weekOfYear;
    final savedWeek = 1;
    final thisWeek = 1;
    print("Saved/This Week: $savedWeek --- $thisWeek");
    print("Number of Goals: ${inProgress.length}");
    if (thisWeek > savedWeek) {
      print("WEEKS DO NOT MATCH!");
      for (final g in inProgress) {
        print("Milestone update...");
        g.milestoneUpdate();
      }

      //final userCopy = (await UserRepository.getUser())
      //    .copy(weekOfYear: DateTime.now().weekOfYear);
      //await UserRepository.updateUser(userCopy);
    } else {
      print("WEEKS MATCH (No Update)");
    }
  }

}
