import 'package:flutter/material.dart';
import 'package:provider_login/src/models/user_data.dart';
import 'package:provider_login/src/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier{
  UserData? _user;

  final AuthMethods _authMethods=AuthMethods();

  UserData? get getUser=> _user;


  Future<void> refreshUser()async{
    UserData user= await _authMethods.getUserDetails();
    _user=user;
    notifyListeners();
  }
}