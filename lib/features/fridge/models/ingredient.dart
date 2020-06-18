class Ingredient {
  final String title;
  final String useBy;

  Ingredient({this.title, this.useBy});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      title: json['title'],
      useBy: json['use-by']
    );
  }

  /// Returns `true` if `useBy` is pass by `currentDate` or is not in the correct format(YYYY-MM-DD)
  bool isPastUseBy(DateTime selectedDate) {
    DateTime useByInDateTimeFormat = _parseToDateTime(this.useBy);
    if (useByInDateTimeFormat==null || useByInDateTimeFormat.isAfter(selectedDate)) {
      return true;
    }
    return false;
  }

  /// Returns `null` if parsing String to DateTime failed
  DateTime _parseToDateTime(String dateString) {
    String dateStringWithoutSpecialChar = dateString.replaceAll('-', '');
    try{
      return DateTime.parse(dateStringWithoutSpecialChar);
    }catch(FormatException){
      return null;
    }
  }
}