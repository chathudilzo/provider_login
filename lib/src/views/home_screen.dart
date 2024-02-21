import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';

import '../models/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData();
  }

  updateData()async{
    UserProvider userProvider=Provider.of(context,listen:false);
    await userProvider.refreshUser();
    
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
        }, icon: Icon(Icons.logout))],
      ),
      body:  
      userData==null?
        const Center(child: CircularProgressIndicator(),)
      
        :Column(
          children: [
            Text(userData!.userName),
            Text(userData.email)
          ]
        )
    );
      
    
  }
}