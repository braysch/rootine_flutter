/*
class GoalEssen {
  String userId;
  String identification;
  String name;
  String units;
  double goal;
  String endDateString;
  String startDateString;
  double initialProgress;
  double progress;
  double weeklyStartingPoint;
  int state;
  bool time;
  bool private;
  List<String>? motivators;

  GoalEssen({
    required this.userId,
    required this.identification,
    required this.name,
    required this.units,
    required this.goal,
    required this.endDateString,
    required this.startDateString,
    required this.initialProgress,
    required this.progress,
    required this.weeklyStartingPoint,
    required this.state,
    required this.time,
    required this.private,
    this.motivators,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'identification': identification,
      'name': name,
      'units': units,
      'goal': goal,
      'endDateString': endDateString,
      'startDateString': startDateString,
      'initialProgress': initialProgress,
      'progress': progress,
      'weeklyStartingPoint': weeklyStartingPoint,
      'state': state,
      'time': time,
      'private': private,
      'motivators': motivators,
    };
  }

  factory GoalEssen.fromMap(Map<String, dynamic> map) {
    return GoalEssen(
      userId: map['userId'] ?? "",
      identification: map['identification'] ?? "",
      name: map['name'] ?? "",
      units: map['units'] ?? "",
      goal: (map['goal'] ?? 0.0).toDouble(),
      endDateString: map['endDateString'] ?? "",
      startDateString: map['startDateString'] ?? "",
      initialProgress: (map['initialProgress'] ?? 0.0).toDouble(),
      progress: (map['progress'] ?? 0.0).toDouble(),
      weeklyStartingPoint: (map['weeklyStartingPoint'] ?? 0.0).toDouble(),
      state: map['state'] ?? 1,
      time: map['time'] ?? false,
      private: map['private'] ?? false,
      motivators: map['motivators'] != null ? List<String>.from(map['motivators']) : null,
    );
  }
}

*/
/*class DataRepository {
  static Future<void> updateGoal(Rootine goal) async {
    var goalEssen = getGoalEssenFromGoal(goal);
    await FirebaseFirestore.instance.collection("goals").doc(goalEssen.identification).set(goalEssen.toMap());
  }*//*


*/
/*  static Future<void> deleteGoal(String id) async {
    await FirebaseFirestore.instance.collection("goals").doc(id).delete();
  }*//*


  */
/*static Future<void> loadGoals() async {
    var milestone = UserRepository.getMilestone();
    var snapshot = await FirebaseFirestore.instance.collection("goals").where("userId", isEqualTo: UserRepository.getCurrentUserId()).get();
    var goalsEssen = snapshot.docs.map((doc) => GoalEssen.fromMap(doc.data() as Map<String, dynamic>)).toList();
    RootinesRepository.clearGoals();
    var numMotivators = 0;
    for (var x in goalsEssen) {
      var rootine = Rootine(Uuid().parse(x.identification));
      rootine.name = x.name;
      rootine.initialProgress = x.initialProgress;
      rootine.goal = x.goal;
      rootine.units = x.units;
      rootine.startDate = DateTime.parse(x.startDateString).toLocal();
      rootine.endDate = DateTime.parse(x.endDateString).toLocal();
      rootine.weeklyStartingPoint = x.weeklyStartingPoint;
      rootine.progress = x.progress;
      rootine.state = x.state;
      rootine.time = x.time;
      rootine.private = x.private;
      rootine.motivators = x.motivators;
      rootine.calculateValues();
      RootinesRepository.addGoal(rootine);
      //numMotivators += x.motivators?.length ?? 0; // add to total number of motivators
    }
    // update milestone information

    // UserRepository.setNumMotivators(numMotivators); // set the number of motivators
  }*//*


  */
/*static Future<void> loadOtherUserInProgressGoals(User user) async {
    var snapshot = await FirebaseFirestore.instance.collection("goals").where("userId", isEqualTo: user.userId).get();
    var goalsEssen = snapshot.docs.map((doc) => GoalEssen.fromMap(doc.data() as Map<String, dynamic>)).toList();
    RootinesRepository.clearOtherUserGoals();
    for (var x in goalsEssen) {
      if (x.state == GoalStates.INPROGRESS && !x.private) {
        // only get active, public goals
        var rootine = Rootine(Uuid().parse(x.identification));
        rootine.userId = x.userId;
        rootine.name = x.name;
        rootine.initialProgress = x.initialProgress;
        rootine.goal = x.goal;
        rootine.units = x.units;
        rootine.startDate = DateTime.parse(x.startDateString).toLocal();
        rootine.endDate = DateTime.parse(x.endDateString).toLocal();
        rootine.weeklyStartingPoint = x.weeklyStartingPoint;
        rootine.progress = x.progress;
        rootine.state = x.state;
        rootine.calculateValues();
        if (rootine.progress < rootine.weeklyGoal) {
          RootinesRepository.otherUserAddGoal(rootine);
        }
      }
    }
  }*//*


  static Future<GoalEssen> createGoal({
    required String identification,
    required String name,
    required String units,
    required double goal,
    required String endDateString,
    required double initialProgress,
    required String startDateString,
    required double weeklyStartingPoint,
    required double progress,
    required int state,
    required bool time,
    required bool private,
    String? userId,
  }) async {
    var doc = FirebaseFirestore.instance.collection("goals").doc(identification);
    var goalEssen = GoalEssen(
      userId: UserRepository.getCurrentUserId() ?? "",
      identification: identification,
      name: name,
      units: units,
      goal: goal,
      endDateString: endDateString,
      initialProgress: initialProgress,
      startDateString: startDateString,
      weeklyStartingPoint: weeklyStartingPoint,
      progress: progress,
      state: state,
      time: time,
      private: private,
    );
    await doc.set(goalEssen.toMap());
    return goalEssen;
  }

  static Future<void> uploadMotivator(Motivator motivator) async {
    await FirebaseFirestore.instance.collection("motivators").doc(motivator.id.toString()).set(motivator.toMap());
  }

  static GoalEssen getGoalEssenFromGoal(Rootine goal) {
    return GoalEssen(
      userId: UserRepository.getCurrentUserId() ?? "",
      identification: goal.identification.toString(),
      name: goal.name,
      units: goal.units,
      goal: goal.goal,
      endDateString: goal.endDate.toString(),
      initialProgress: goal.initialProgress,
      startDateString: goal.startDate.toString(),
      weeklyStartingPoint: goal.weeklyStartingPoint,
      progress: goal.progress,
      state: goal.state,
      time: goal.time,
      private: goal.private,
      motivators: goal.motivators,
    );
  }
}*/
