class WebService {

  static const baseUrl = "https://www.themealdb.com/api/json/v1/1/";
  static String getUrl(String endPoint) => baseUrl + endPoint;

}