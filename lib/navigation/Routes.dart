class Screen {
  final String route;

  Screen(this.route);
}

class Routes {
  static final root = Screen("root");
  static final main = Screen("main");
  static final mainNavigation = Screen("mainNavigation");
  static final launch = Screen("launch");
  static final rootinesModificationNavigation = Screen("rootinesmodificationnavigation");
  static final launchNavigation = Screen("launchnavigation");
  static final launchGoals = Screen("launchgoals");
  static final splashScreen = Screen("spashscreen");
  static final goalsNavigation = Screen("goalsnavigation");
  static final goalsInProgress = Screen("goalsinprogress");
  static final goalsShelved = Screen("goalsshelved");
  static final goalsCompleted = Screen("goalscompleted");
  static final profile = Screen("profile");
  static final goals = Screen("goals");
  static final editGoal = Screen("editGoal");
  static final userSetupNavigation = Screen("userSetupNavigation");
  static final userSetup = Screen("userSetup");
  static final profileNavigation = Screen("profileNavigation");
  static final friends = Screen("friends");
  static final myfriends = Screen("myfriends");
  static final friendrequests = Screen("friendrequests");
  static final friendsNavigation = Screen("friendsNavigation");
  static final routines = Screen("routines");
  static final tasks = Screen("tasks");
  static final projects = Screen("projects");
  static final photo = Screen("photo");
  static final motivator = Screen("motivator");
  static final createGoalTitle = Screen("createGoalTitle");
  static final motivatorMessage = Screen("motivatormessage");
}
