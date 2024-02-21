import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  final String email;
  final String uid;
  final String userName;

  const UserData({
    required this.email,
    required this.uid,
    required this.userName,
  });


  Map<String,dynamic> toJson()=>{
    'email':email,
    'uid':uid,
    'userName':userName
  };

  static UserData fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    return UserData(email: snapshot['email'], uid: snapshot['uid'], userName: snapshot['userName']);
    
  }



}