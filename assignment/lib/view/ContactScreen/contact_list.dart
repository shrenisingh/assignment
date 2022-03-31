import 'package:assignment/view/ContactScreen/addContactScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String token = GetStorage().read("email");
  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('user').snapshots();

  // For Deleting User
  CollectionReference user =
      FirebaseFirestore.instance.collection('user');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return user
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
      GestureDetector(
        onTap: ()=>Get.back(),
        child:const Text("Contact List")
        ),),
      body: StreamBuilder<QuerySnapshot>(
          stream: userStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Something went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List storedocs = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              storedocs.add(a);
              a['id'] = document.id;
            }).toList();
        

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    1: FixedColumnWidth(140),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            color: Color.fromARGB(255, 211, 154, 178),
                            child: const Center(
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color:Color.fromARGB(255, 211, 154, 178),
                            child:const Center(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                       TableCell(
                          child: Container(
                            color:Color.fromARGB(255, 211, 154, 178),
                            child: const Center(
                              child: Text(
                                'Mobile',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.greenAccent,
                            child:const Center(
                              child: Text(
                                'Action',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  
                    for (var i = 0; i < storedocs.length; i++) ...[
                        if(token ==  storedocs[i]['token'].toString()) ...[
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['name'].toString(),
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['email'].toString(),
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['phone'].toString(),
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                            child: 
                              
                                IconButton(
                                  onPressed: () =>
                                      {deleteUser(storedocs[i]['id'])},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              
                          ),
                        ],
                      ),
                    ],
                    ],
                  ],
                ),
              ),
            );
          }),
    );
  }
}