import 'package:assignment/controller/updateProfile_controller.dart';
import 'package:assignment/utils/helpers/style.dart';
import 'package:assignment/view/ProfileScreen/profile_screen.dart';

import 'package:assignment/widgets/custom_textform_field.dart';
import 'package:assignment/widgets/rectangle_expandable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({ Key? key }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
   final ProfileController _state = Get.put(ProfileController());
  void onUpdateTap() async{    
     _state.fullName.value = _nameController.text;
      _state.phoneNumber.value = _mobileController.text;
       _state.gender.value = _genderController.text.toUpperCase();
      _state.dob.value = _dobController.text;
      print(_state.fullName.value.toString());
        try {
      /// Update User
      Map<String,dynamic> _result = await _state.updateUser();
       if (_result['status'] == true) {
        print("update"+_result['user'].toString());
        Get.to(() => ProfileScreen(_result['user']['user_details']));
      } else {
        print("shreni"+_result['status'].toString());
      }
    } catch (e) {
      print(e);
    }
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            padding: paddingAll(0),
            splashRadius: 20,
            icon: const Icon(Icons.close, color: Colors.black),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Update Profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                padding: paddingAll(10),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 18,
                     
                        color: Colors.grey,
                      ),
                    ),
                    gapTop(10),
                    CustomTextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return "Empty field not allowd";
                      },
                      maxWidth: double.infinity,
                    )
                  ],
                ),
              ),
              gapTop(10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                padding: paddingAll(10),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mobile",
                      style: TextStyle(
                        fontSize: 18,
                       // fontFamily: Fonts.avenir,
                        color: Colors.grey,
                      ),
                    ),
                    gapTop(10),
                    CustomTextFormField(
                      controller: _mobileController,
                      validator: (value) {
                        if (value!.isEmpty) return "Empty field not allowd";
                      },
                      maxWidth: double.infinity,
                    )
                  ],
                ),
              ),
              gapTop(10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                padding: paddingAll(10),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 18,
                  
                        color: Colors.grey,
                      ),
                    ),
                    gapTop(10),
                    CustomTextFormField(
                      controller: _genderController,
                      validator: (value) {
                        if (value!.isEmpty) return "Empty field not allowd";
                      },
                      maxWidth: double.infinity,
                    )
                  ],
                ),
              ),
              gapTop(10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                padding: paddingAll(10),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 18,
                        
                        color: Colors.grey,
                      ),
                    ),
                    gapTop(10),
                    CustomTextFormField(
                      hintText: "2001-05-07",
                      controller: _dobController,
                      validator: (value) {
                        if (value!.isEmpty) return "Empty field not allowd";
                      },
                      maxWidth: double.infinity,
                    )
                  ],
                ),
              ),
              gapTop(20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RectangleExpandableButton(
                  label: "Add",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      onUpdateTap();
                   
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}