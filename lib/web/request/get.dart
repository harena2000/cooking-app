import 'package:dio/dio.dart';
import '../../const/web_service.dart';
import '../../model/recipe.dart';

class Get {
  static Future<List<Recipe>> getListRecipeMeal() async {
    var dio = Dio();
    try {
      Response response = await dio
          .get(WebService.getUrl("search.php"), queryParameters: {"s": "a"});
      return (response.data['meals'] as List)
          .map((e) => Recipe.fromJson(e))
          .toList();

    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
