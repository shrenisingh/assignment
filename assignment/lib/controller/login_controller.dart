import 'dart:convert';
import 'package:assignment/model/user.dart';
import 'package:assignment/utils/api_url.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' ;
import 'dart:async';
class LoginController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
    Future<Map<String, dynamic>> login() async {
      print("email"+email.value);
      print("pass"+password.value);
    var result;
    Map<String, dynamic> loginData = {
        'email': email.value,
        'password': password.value
    };
    Response response = await post(
      Uri.parse(AppUrl.login),
      body: loginData,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var userData = responseData['data'];
      var authUser = User.fromJson(responseData);
      result = {'status': true, 'message': 'Successful', 'user': userData};
       GetStorage().write("token",userData["token"]);
       GetStorage().write("email",email.value);
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

}
