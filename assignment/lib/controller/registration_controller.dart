import 'dart:convert';

import 'package:assignment/model/user.dart';
import 'package:assignment/utils/api_url.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class RegistrationController extends GetxController {
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString dob = "".obs;
  RxString gender = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
     
  Future<Map<String, dynamic>> register() async {
    final Map<String, dynamic> registrationData = {
      'full_name': firstName.value + " "+lastName.value ,
      'email': email.value,
      'mobile_no': phoneNumber.value,
      'password': password.value,
      'c_password': confirmPassword.value,
      'gender': gender.value,
      'dob': //"2022-05-05"
       dob.value,
    };
    Response response = await post(Uri.parse(AppUrl.register),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});
    var result;
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var userData = responseData['data'];
      User authUser = User.fromJson(userData);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'user': userData
      };
      print("userdata" + userData.toString());
      print("auth" + authUser.toString());
      GetStorage().write("token", userData["token"]);
      GetStorage().write("email",email.value);
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
      };
    }
    return result;
  }
}
