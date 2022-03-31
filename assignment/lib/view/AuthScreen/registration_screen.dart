import 'dart:async';
import 'package:assignment/controller/registration_controller.dart';
import 'package:assignment/ui/custom_toast.dart';
import 'package:assignment/ui/loading.dart';
import 'package:assignment/utils/helpers/size.dart';
import 'package:assignment/utils/helpers/style.dart';
import 'package:assignment/view/ProfileScreen/profile_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:assignment/widgets/custom_date_picker.dart';
import 'package:assignment/widgets/custom_textform_field.dart';
import 'package:assignment/widgets/rectangle_expandable_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final RegistrationController _state = Get.put(RegistrationController());

  /// These Global Key's for form validation
  final GlobalKey<FormState> _phoneState = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailState = GlobalKey<FormState>();
  final GlobalKey<FormState> _genderState = GlobalKey<FormState>();
  final GlobalKey<FormState> _nameState = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordState = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordState = GlobalKey<FormState>();

  final PageController _pageController = PageController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ///  STEP: 1 -Phone Validation 
  void storePhonePage() async {
     if (_phoneState.currentState!.validate()) {
        /// Storing data in Regsitration Controller
      _state.phoneNumber.value = numberController.text;
      print("phone"+  _state.phoneNumber.value);
    nextPage();
     }
  }
  /// STEP: 2 - Email Validation
  void storeEmailPage() async {
     if (_emailState.currentState!.validate()) {
        /// Storing data in Regsitration Controller
       _state.email.value = emailController.text;
        print("email"+  _state.email.value);
    nextPage();
     }
  }


  /// STEP: 3 - Name Validation 
  void storeNameCredential(String first, String last) {
    if (_nameState.currentState!.validate()) {
      /// Storing data in Regsitration Controller
      _state.firstName.value = first;
      _state.lastName.value = last;
      print("name"+  _state.firstName.value);
      nextPage();
    }
  }

  /// STEP: 4 - Date of Birth
  void onDOBContinueTap() {

    if (_state.dob.isNotEmpty) {                    
      print("dob"+  _state.dob.value);
      nextPage();
    } else {
      showToast("Enter your date of birth");
    }

  }

  /// STEP: 5 - Gender, Password, Confirm Password,
  void onGenderNextTap() async{
   if (_passwordState.currentState!.validate()) {
     
      if (_state.gender.isNotEmpty ) {
        print("gender"+  _state.gender.value);
        print("pss"+  _state.password.value);
        print("cnf"+  _state.confirmPassword.value);
        try {
    

      /// Regsiter User
      Map<String,dynamic> _result = await _state.register();
       if (_result['status'] == true) {
        print("shreni"+_result['user'].toString());
        Get.to(() => ProfileScreen(_result['user']['user_details']));
      } else {
        print("shreni"+_result['status'].toString());
      }
    } catch (e) {
      print(e);
    }
      } else {
        showToast("Enter all information");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
             _PhoneTextField(
              formKey: _phoneState,
              controller: numberController,
              hintText: "Enter Phone No.",
              validator: (val) {
                if (val!.isEmpty || val.length != 10) {
                  return "Enter 10 digit phone number";
                }
              },
              keyboardType: TextInputType.phone,
              onChanged: (String value) {
                if (numberController.text.length == 10) {
                  dismissKeyboard(context);
                }
              },
              onContinueButtonTap:storePhonePage,
            ),
            
            _PhoneTextField(
              formKey: _emailState,
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  if (!GetUtils.isEmail(value)) {
                    return "Enter valid email address";
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter email",
              onContinueButtonTap: storeEmailPage,
            ),
            _FirstLastNamePage(

              formkey: _nameState,
              onContinueTap: storeNameCredential,
            ),
            _DOBSelection(
              onChanged: (value) {
                // The [value] returns E.g. : 2021-11-23 16:51:23.375159
                // We don't need after date i.e 16:51:23.375159

                List<String> _values = '$value'.split('.').first.split(' ');
                // The _values becomes ['2021-11-23', '16:51:23']

                // Format the Dob as per requirement.
                _state.dob.value = "${_values[0]}";
                //T${_values[1]}Z
              },
              onTap: onDOBContinueTap,
              onBackTap: previousPage,
            ),
            _GenderPassword(
              formKey: _passwordState,
              formKeyConfirm: _confirmPasswordState,
              onTap: onGenderNextTap,
              onBackTap: previousPage,
            ),
            
          ],
        ),
      ),
    );
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }
}

class _LogoCard extends StatelessWidget {
  const _LogoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        gapTop(20),
        
        Container(
          height: 250,
          width: 400,
          padding: paddingAll(20),
          margin: paddingLTRB(0, 20, 0, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: defaultBoxShadow,
          ),
          child: Column(
            children: <Widget>[
              
              Lottie.asset("assets/splash.json"),
              
              
            ],
          ),
        ),
      ],
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  final Key? formKey;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function()? onContinueButtonTap;
  final String? hintText;
  final TextInputType? keyboardType;

  const _PhoneTextField({
    this.formKey,
    this.controller,
    this.onContinueButtonTap,
    this.onChanged,
    this.hintText,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: paddingLTRB(20, 0, 20, 0),
            child: Column(
              children: <Widget>[
                const _LogoCard(),
                gapTop(10),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomTextFormField(
                      controller: controller,
                      maxWidth: double.infinity,
                      validator: validator,
                      onChanged: onChanged,
                      keyBoardType: keyboardType,
                      hintText: hintText,
                    ),
                  ),
                ),
                gapTop(20),
                RectangleExpandableButton(
                  onTap: onContinueButtonTap,
                  label: "Continue",
                  borderRadius: 100,
                  width: 250,
                ),
                gapTop(10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FirstLastNamePage extends StatefulWidget {
  final Key? formkey;
  final Function()? onBackTap;
  final void Function(String fisrtName, String lastName)?
      onContinueTap;

  const _FirstLastNamePage({this.formkey, this.onContinueTap,this.onBackTap});
  @override
  __FirstLastNamePageState createState() => __FirstLastNamePageState();
}

class __FirstLastNamePageState extends State<_FirstLastNamePage> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  final RegistrationController _state = Get.find<RegistrationController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    firstName.text = _state.firstName.value;
    lastName.text = _state.lastName.value;
    return SingleChildScrollView(
      child: Padding(
        padding: paddingLTRB(20, 0, 20, 0),
        child: Column(
          children: <Widget>[
            const _LogoCard(),
           /* const SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  "Enter your Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Avenir-Next",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),*/

            SizedBox(
              height: 50,
              //  width: double.infinity,
              child: Row(

                children: [
                  IconButton(
                    onPressed: widget.onBackTap,
                    padding: EdgeInsets.zero,
                    splashRadius: 25,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Flexible(
                    child: Center(
                      child: Text(
                        "Enter your Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Avenir-Next",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.08,
                  ),
                ],
              ),
            ),
            gapTop(20),
            Container(
              padding: paddingLTRB(30, 0, 30, 0),
              child: Form(
                key: widget.formkey,
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      controller: firstName,
                      validator: (value) {
                        if (value!.length < 2) {
                          return "Name should be alteast 2 characters";
                        }
                      },
                      hintText: "First Name",
                    ),
                   
                    gapTop(20),
                    CustomTextFormField(
                      controller: lastName,
                      validator: (value) {
                        if (value!.length < 3) {
                          return "Name should be alteast 3 characters";
                        }
                      },
                      hintText: "Last Name",
                    ),
                    gapTop(20),
                    RectangleExpandableButton(
                      label: "Continue",
                      backgrounColor:Colors.red,
                      borderRadius: 100,
                      width: 200,
                      onTap: () {
                        // It will retuns the First, Middle, Last name
                        // to main widget i.e [ PhoneRegistration ]
                        widget.onContinueTap!(
                            firstName.text, lastName.text);
                      },
                    ),
                    gapTop(10)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DOBSelection extends StatelessWidget {
  final ValueChanged<DateTime?> onChanged;
  final VoidCallback onTap;
  final VoidCallback? onBackTap;

  const _DOBSelection(
      {Key? key, required this.onChanged, required this.onTap, this.onBackTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _state = Get.find<RegistrationController>();

    return WillPopScope(
      onWillPop: () {
        return Future.delayed(
          const Duration(microseconds: 100),
          () {
            Get.back();
            return true;
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            child: Padding(
              padding: paddingLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                 
                 const _LogoCard(),
                
                  gapTop(20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onBackTap,
                          padding: EdgeInsets.zero,
                          splashRadius: 25,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        const Flexible(
                          child: Center(
                            child: Text(
                              "Enter your date of birth",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Avenir-Next",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.08,
                        ),
                      ],
                    ),
                  ),
                  gapTop(30),
                  Container(
                    width: 400,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: paddingLTRB(20, 0, 20, 0),
                    margin: paddingLTRB(30, 0, 30, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColor2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                     
                      () => CustomDatePicker(
                        textColor: Colors.red,
                        backGroundColor: Colors.red,
                        hintText: _state.dob.value.isEmpty
                            ? "Select dob"
                            : "${DateTime.parse(_state.dob.value).year}-${DateTime.parse(_state.dob.value).month}-${DateTime.parse(_state.dob.value).day}",
                            
                              
                        onChanged: onChanged,
                      ),
                    ),
                  ),
                  gapTop(20),
                  RectangleExpandableButton(
                    label: "Continue",
                    backgrounColor: Colors.red,
                    borderRadius: 100,
                    width: 200,
                    onTap: onTap,
                  ),
                  gapTop(20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GenderPassword extends StatefulWidget {
  final Key? formKey;
  final Key? formKeyConfirm;
  final VoidCallback onTap;
  final VoidCallback? onBackTap;

  const _GenderPassword(
      {this.formKey,this.formKeyConfirm, required this.onTap, this.onBackTap});

  @override
  __GenderPasswordState createState() => __GenderPasswordState();
}

class __GenderPasswordState extends State<_GenderPassword> {
  final _state = Get.find<RegistrationController>();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    _password.text = _state.password.value;
    _confirmPassword.text = _state.confirmPassword.value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.delayed(
          const Duration(microseconds: 100),
          () {
            Get.back();
            return true;
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            child: Padding(
              padding: paddingLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                   
                 const _LogoCard(),
                
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: widget.onBackTap,
                          padding: EdgeInsets.zero,
                          splashRadius: 25,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        const Flexible(
                          child: Center(
                            child: Text(
                              "Select your Gender",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Avenir-Next",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.08,)
                      ],
                    ),
                  ),
                  gapTop(20),
                  Padding(
                    padding: paddingLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _CustomRadioButton(
                                    isSelected: _state.gender.value == "MALE"
                                        ? true
                                        : false,
                                    title: "Male",
                                    onPressed: () {
                                      
                                        _state.gender.value = "MALE";
                                        
                                } 
                                  ),
                                  _CustomRadioButton(
                                    isSelected: _state.gender.value == "FEMALE"
                                        ? true
                                        : false,
                                    title: "Female",
                                    onPressed: () {
                                     
                                      _state.gender.value = "FEMALE";
                                     
                                    },
                                  ),
                                  _CustomRadioButton(
                                    isSelected: _state.gender.value == "OTHER"
                                        ? true
                                        : false,
                                    title: "Other",
                                    onPressed: () {
                                     
                                      _state.gender.value = "OTHER";
                                       
                                    },
                                  ),
                                ],
                              ),
                              gapTop(30),
                              const Center(
                                child: Text(
                                  "Enter Password",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Avenir-Next",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              gapTop(10),
                              Form(
                                key: widget.formKey,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: CustomTextFormField(
                                        controller: _password,
                                        keyBoardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) return "Required";
                                        },
                                        onChanged: (_value) =>
                                            _state.password.value = _value,
                                        hintText: "Password",
                                        hintFontSize: 14,
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ),
                              gapTop(30),
                              const Center(
                                child: Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Avenir-Next",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              gapTop(10),
                               
                              Form(
                                key: widget.formKeyConfirm,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: CustomTextFormField(
                                        controller: _confirmPassword,
                                        keyBoardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) return "Required";
                                        },
                                        onChanged: (_value) =>
                                            _state.confirmPassword.value = _value,
                                        hintText: "Confirm Password",
                                        hintFontSize: 14,
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ),
                              gapTop(20),
                              RectangleExpandableButton(
                                label: "Next",
                                backgrounColor: Colors.red,
                                borderRadius: 100,
                                width: 200,
                                onTap: widget.onTap,
                              ),
                            ],
                          ),
                        ),
                        gapTop(20)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final String? title;
  final Function()? onPressed;
  final bool isSmallRadio;
  const _CustomRadioButton({
    Key? key,
    this.isSelected = true,
    this.title,
    this.onPressed,
    this.isSmallRadio = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeHelper size = SizeHelper(context);
    return Container(
      height: 40,
      width: isSmallRadio ? size.widthCustom(15) : size.widthCustom(20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red : Colors.white,
        border: isSelected ? null : Border.all(color: greyColor2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CupertinoButton(
        padding: paddingAll(0),
        child: FittedBox(
          child: Text(
            "$title",
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "Avenir-Next",
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _LastScreen extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onBackTap;
  const _LastScreen({Key? key, this.onTap, this.onBackTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const RangeMaintainingScrollPhysics(),
          child: Padding(
            padding: paddingLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onBackTap,
                        padding: EdgeInsets.zero,
                        splashRadius: 25,
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      const Flexible(
                        child: Center(
                          child: Text(
                            "Tell us about your Medical History",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Avenir-Next",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                RectangleExpandableButton(
                  label: "Continue",
                  backgrounColor: Colors.red,
                  borderRadius: 100,
                  width: 200,
                  onTap: onTap,
                ),
                gapTop(20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
