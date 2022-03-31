import 'dart:convert';

import 'package:assignment/model/user.dart';
import 'package:assignment/utils/api_url.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';


class ProfileController extends GetxController {
  RxString phoneNumber = "".obs;
  RxString fullName = "".obs;
  RxString dob = "".obs;
  RxString gender = "".obs;
 
  Future<Map<String, dynamic>> updateUser() async {
     String token = GetStorage().read("token");
     print("token"+token);

    final Map<String, dynamic> updateData = {
        'full_name':fullName.value,
        'mobile_no': phoneNumber.value,
        'gender': gender.value,
        'dob': 
       dob.value.toString(),
    };
    Response response = await post(Uri.parse(AppUrl.updateProfile),
        body: json.encode(updateData),
        headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        });
    var result;
    print(response.statusCode);
  final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
     
      var userData = responseData['data'];
      User authUser = User.fromJson(userData);
      result = {
        'status': true,
        'message': 'Successfully Updated',
        'user': userData
      };
      print("result"+result.toString());
    } else {
      result = {
        'status': false,
        'message': 'Update failed',
       'user': responseData
      };
       print("result"+result.toString());
    }
    return result;
  

}
}