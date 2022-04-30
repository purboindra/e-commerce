import 'package:app_8april_2022/app/data/models/makeup_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future fetchMakeUp() async {
    var uri = Uri.parse(
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=marienatie");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }
}
