import 'package:assignment/utils/helpers/style.dart';
import 'package:assignment/view/ContactScreen/contact_list.dart';
import 'package:assignment/widgets/custom_textform_field.dart';
import 'package:assignment/widgets/rectangle_expandable_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class AddContact extends StatefulWidget {
  const AddContact({ Key? key }) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String token = GetStorage().read("email");
  // final ProfileController _state = Get.put(ProfileController());
  var name = "";
  var email = "";
  var phone = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // Adding Contact Details

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  clearText() {
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
  }
   CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  Future<void> addUser() {
    return user
        .add({'name': name, 'email': email, 'phone': phone,'token':token})
        .then((value) =>    Get.to(() => ListPage()))
        .catchError((error) => print('Failed to Add user: $error'));
  }
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
          "Add Contact",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
         //   fontFamily: Fonts.avenir,
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
                       // fontFamily: Fonts.avenir,
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
                      "Email",
                      style: TextStyle(
                        fontSize: 18,
                      //  fontFamily: Fonts.avenir,
                        color: Colors.grey,
                      ),
                    ),
                    gapTop(30),
                    CustomTextFormField(
                      controller: _emailController,
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
                  setState(() {
                            name = _nameController.text;
                            email = _emailController.text;
                            phone = _mobileController.text;
                            addUser();
                            clearText();
                          });
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