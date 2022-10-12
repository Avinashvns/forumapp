

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/homepage/homepage.dart';
import 'package:forumapp/homepage/profile.dart';
import 'package:forumapp/widget/textwidget.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child:ListView(
        children: [
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              //color: Colors.green,
            ),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.account_circle_rounded, color: Colors.black,size: 120,),
                  const SizedBox(height: 40,),
                  TextWidget(
                    text: "text", 
                    textSize: 20, 
                    textweight: FontWeight.w400, 
                    textcolor: Colors.grey, 
                    textAlign: TextAlign.start
                    ),
                  const SizedBox(height: 15,),
                  Text(
                    user.email!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                  ),
                  
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),

          ListTile(
            
            title: TextWidget(
                    text: "Profile", 
                    textSize: 20, 
                    textweight: FontWeight.bold, 
                    textcolor: Colors.black87, 
                    textAlign: TextAlign.start
                    ),
                    
            leading: IconButton(
              icon: Icon(Icons.account_circle,size: 40,color: Colors.black,),
              
              onPressed: () {},
            ),
            onTap: ()
            {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));  
            },
          ),
          SizedBox(height: 10,),
          ListTile(
           selected: true,
            title: TextWidget(
                    text: "Home", 
                    textSize: 20, 
                    textweight: FontWeight.bold, 
                    textcolor: Colors.black87, 
                    textAlign: TextAlign.start
                    ),
            leading: IconButton(
              icon: Icon(Icons.home,size: 40,color: Colors.black,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())); 
            },
          ),

          SizedBox(height: 10,),
          ListTile(
            
            title: TextWidget(
                    text: "Saved", 
                    textSize: 20, 
                    textweight: FontWeight.bold, 
                    textcolor: Colors.black87, 
                    textAlign: TextAlign.start
                    ),
            leading: IconButton(
              icon: Icon(Icons.list,size: 40,color: Colors.black,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              
            },
          ),
          SizedBox(height: 10,),
          ListTile(
           
            title: TextWidget(
                    text: "Bookmarks", 
                    textSize: 20, 
                    textweight: FontWeight.bold, 
                    textcolor: Colors.black87, 
                    textAlign: TextAlign.start
                    ),
            leading: IconButton(
              icon: Icon(Icons.bookmark_added,size: 40,color: Colors.black,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              
            },
          ),

          SizedBox(height: 10,),
          ListTile(
            
            
            title: TextWidget(
                    text: "Favorite", 
                    textSize: 20, 
                    textweight: FontWeight.bold, 
                    textcolor: Colors.black87, 
                    textAlign: TextAlign.start
                    ),
            leading: IconButton(
              icon: Icon(Icons.favorite,size: 40,color: Colors.black,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              
            },
          ),

          SizedBox(height: 10,),
          ListTile(
            
            title: TextWidget(
                    text: "Privacy Policy", 
                    textSize: 20, 
                    textweight: FontWeight.bold, 
                    textcolor: Colors.black87, 
                    textAlign: TextAlign.start
                    ),
            leading: IconButton(
              icon: Icon(Icons.security,size: 40,color: Colors.black,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              
            },
          ),

         

            ],
      ) ,
    );
  }
}