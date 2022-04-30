import 'package:get/get_connect.dart';

class Reqres extends GetConnect {
  Future<Response> getUser(int id) =>
      get("https://reqres.in/api/users?page=2$id");
}
