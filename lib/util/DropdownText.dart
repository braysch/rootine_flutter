String projectItemDropdownText(int n) {
  switch (n) {
    case 0:
      return "Edit";
    case 5:
      return "Delete";
    case 4:
      return "Renew";
    case 1:
      return "Shelve";
    case 2:
      return "Activate";
    case 3:
      return "Extend";
    default:
      return "Error";
  // you also need to update the values in the goal model (goal.dart)
  }
}
