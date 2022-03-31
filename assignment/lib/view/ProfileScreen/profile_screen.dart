import 'package:assignment/utils/helpers/style.dart';
import 'package:assignment/view/AuthScreen/login_screen.dart';
import 'package:assignment/view/ContactScreen/addContactScreen.dart';
import 'package:assignment/view/ContactScreen/contact_list.dart';
import 'package:assignment/view/ProfileScreen/update_profile.dart';
import 'package:assignment/widgets/rectangle_expandable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  var user;
  ProfileScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    
    var user_details = widget.user;
     DateTime dateTime =  DateTime.parse("${user_details['dob']}");
    var formate =
        "${dateTime.day} ${DateFormat("MMMM").format(dateTime)} ${dateTime.year}";
   
    return Scaffold(
      floatingActionButton: FloatingActionButton(elevation: 0.0,
              child: Icon(Icons.logout),
              backgroundColor: new Color(0xFFE57373),
              onPressed: (){
              GetStorage().remove("token");
               Get.to(() => LoginScreen());
                
              }),
      appBar: AppBar(
         automaticallyImplyLeading: false,
       
        title: Text("User Profile"),
          actions: [
    IconButton(
      onPressed: () {
        Get.to(() => ListPage());
      },
      icon: const Icon(Icons.contact_phone,
      color: Colors.white,)
    ),
  
  ],
      ),
      body: Container(
        padding: paddingLTRB(0, 0, 0, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: defaultBoxShadow,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                     Get.to(() => UpdateProfile());

                  },
                  child: Container(
                     padding: paddingLTRB(0, 0, 20, 5),
                    alignment: Alignment.topRight,
                    child: Icon(Icons.edit))),
                _NameAndValue(
                  title: "Name:",
                  value: user_details['name'].toString(),
                  isGreyBG: true,
                  bold: true,
                ),
                _NameAndValue(
                  title: "Mobile:",
                  value: user_details['mobile_no'].toString(),
                  isGreyBG: true,
                ),
                _NameAndValue(
                  title: "Gender:",
                  value: user_details['gender'].toString(),
                ),
                _NameAndValue(
                  title: "DOB:",
                  value: formate.toString(),
                  isGreyBG: true,
                ),
                gapTop(30),
                   Padding(
                padding: const EdgeInsets.all(10.0),
                child: RectangleExpandableButton(
                  label: "Add Contacts",
                  onTap: () {
                       Get.to(() => AddContact());
                  },
                ),
              )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NameAndValue extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final bool isGreyBG;
  final bool bold;
  const _NameAndValue({
    Key? key,
    required this.title,
    required this.value,
    this.textColor = Colors.black,
    this.isGreyBG = false,
    this.bold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isGreyBG ? const Color(0xFFF3F3F3) : Colors.white,
      padding: paddingLTRB(20, 5, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              //   fontFamily: Fonts.avenir,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                //  fontFamily: Fonts.avenir,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
