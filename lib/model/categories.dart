class Categories {
  Categories({
      required this.idCategory,
      required this.strCategory,
      required this.strCategoryThumb,
      required this.strCategoryDescription,});

  Categories.fromJson(dynamic json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }
  late final String? idCategory;
  late final String? strCategory;
  late final String? strCategoryThumb;
  late final String? strCategoryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idCategory'] = idCategory;
    map['strCategory'] = strCategory;
    map['strCategoryThumb'] = strCategoryThumb;
    map['strCategoryDescription'] = strCategoryDescription;
    return map;
  }

}