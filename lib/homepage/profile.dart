import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/login/login.dart';
import 'package:forumapp/widget/textfield.dart';
import 'package:forumapp/widget/textwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int _selectedIndex = 0;
  final User user = FirebaseAuth.instance.currentUser!;
  String namefirebase = "";
  String phonefirebase = "";
  String emailfirebase = "";

  @override
  void initState() {
    super.initState();
    firebaseInit();
    updateFirebase();
  }

  String firebaseData = "data";
  String documentId = "";

  void firebaseInit() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();
      //log(querySnapshot.docs.toString());
      firebaseData = "";
      for (var doc in querySnapshot.docs) {
        //log(doc.data().toString());
        //print(doc.data().runtimeType);
        firebaseData = firebaseData + doc.data().toString();
        // print(doc.get("name"));
        // print(doc.get("phone"));
        // print(doc.get("email"));
        //print("email="+user.email!);
        String email = doc.get("email");
        String useremail = user.email!;
        if (useremail == email) {
          print(doc.get("name"));
          print(doc.get("phone"));
          print(doc.get("email"));
          nameController.text = doc.get("name");
          mobileController.text = doc.get("phone");
          emailController.text = doc.get("email");
          break;
        }
      }
      print(firebaseData);
    } catch (e) {}
  }

  void updateFirebase() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();

      firebaseData = "";

      for (var doc in querySnapshot.docs) {
        firebaseData = firebaseData + doc.data().toString();
        //var documentId = doc.id;
        //print(documentId);

        String email = doc.get("email");

        String useremail = user.email!;

        //print(email +" or "+ useremail);
        if (useremail == email) {
          documentId = doc.id;
          //print("yes");
          //print(email.codeUnits);

          print(doc.get("name"));
          print(doc.get("phone"));
          print(doc.get("email"));

          nameController.text = doc.get("name");
          mobileController.text = doc.get("phone");
          emailController.text = doc.get("email");
          break;
        }
      }
      print(firebaseData);
    } catch (e) {}
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: const EdgeInsets.only(left: 20, right: 60),
                  child: Text("Log out"),
                  value: 1,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                // IconButton(onPressed: (){

                //     },
                //     icon: Icon(Icons.more_vert,size: 30,)),
              ],
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("asset/images/c2.JPG"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MyTextField(
                  maxLine: 1,
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                  type: false,
                  //icon: Icons.add,
                  isIcon: true),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 20,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: MyTextField(
                        maxLine: 1,
                        controller: mobileController,
                        hintText: "Phone",
                        obscureText: false,
                        type: false,
                        //icon: Icons.add,
                        isIcon: false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: MyTextField(
                  maxLine: 1,
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  type: false,
                  //icon: Icons.add,
                  isIcon: true),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: GestureDetector(
                onTap: () async {
                  print(documentId);
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(documentId)
                      .update({
                    "name": nameController.text,
                    "phone": mobileController.text,
                  });
                  setState(() {});
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
                },
                child: Container(
                  height: 40,
                  //padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.shade800,
                  ),
                  child: const Center(
                    child: TextWidget(
                        text: "UPDATE PROFILE",
                        textSize: 16,
                        textweight: FontWeight.bold,
                        textcolor: Colors.white,
                        textAlign: TextAlign.start),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_added),
            label: 'Bookmarked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
