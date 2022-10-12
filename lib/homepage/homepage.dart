

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/login/login.dart';
import 'package:forumapp/widget/drawer.dart';
import 'package:forumapp/widget/textfield.dart';
import 'package:forumapp/widget/textwidget.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  int _selectedIndex = 0;
  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    //final User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Home",style: TextStyle(fontSize: 30),),
        actions: [
          PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    padding: const EdgeInsets.only(left: 20,right: 60),
                    child: Text("Log out"),
                    value: 1,
                    onTap: ()async{
                      await FirebaseAuth.instance.signOut(); 
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                  ),
                ]
            )
          // IconButton(onPressed: (){

          //     }, 
          //     icon: Icon(Icons.more_vert,size: 30,)),
        ],
      ),
      drawer: Mydrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          
          Center(
            child: TextWidget(
              text: "Welcome", 
              textSize: 40, 
              textweight: FontWeight.w400, 
              textcolor: Colors.black, 
              textAlign: TextAlign.start
              ),
          ),
      
            
              

              // Padding(
              // padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              // child: GestureDetector(
              //   onTap: (){
              //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
              //   },
              //   child: Container(
              //     height: 40,
              //     //padding: const EdgeInsets.symmetric(horizontal: 20),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.blue,
              //     ),
              //     child: const Center(
              //       child: TextWidget(
              //         text: "LOGIN", 
              //         textSize: 16, 
              //         textweight: FontWeight.w500, 
              //         textcolor: Colors.white, 
              //         textAlign: TextAlign.start
              //         ),
              //     ),
              //   ),
              // ),
              // ),

              
              
        ],
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