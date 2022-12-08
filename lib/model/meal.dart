class Meals {
  Meals({
      required this.strMeal,
      required this.strMealThumb,
      required this.idMeal,});

  Meals.fromJson(dynamic json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strMeal'] = strMeal;
    map['strMealThumb'] = strMealThumb;
    map['idMeal'] = idMeal;
    return map;
  }

}