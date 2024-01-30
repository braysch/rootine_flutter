String validateEndDate(String endDateString) {
  try {
    DateTime endDate = DateTime.parse(endDateString);
    return endDate.isAfter(DateTime.now()) ? '' : 'End date must be in the future';
  } catch (e) {
    return 'Improperly formatted date';
  }
}