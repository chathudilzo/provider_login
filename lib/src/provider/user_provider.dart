import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider_login/src/models/transactions.dart';
import 'package:provider_login/src/models/user_data.dart';
import 'package:provider_login/src/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier{
  UserData? _user;
  List<TransactionData> _transactions=[];
  bool  _isLoading=false;

  bool get isLoading=>_isLoading;

  List<TransactionData> get transactions=>_transactions;

  final AuthMethods _authMethods=AuthMethods();

  UserData? get getUser=> _user;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;


  Future<void> refreshUser()async{
    UserData user= await _authMethods.getUserDetails();
    _user=user;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionData transaction)async{
    try{
      _isLoading=true;
      notifyListeners();
      _transactions.add(transaction);
      await _firestore.collection('users').doc(_user!.uid).update({'transactions':_transactions.map((e) => e.toJson()).toList()});
      notifyListeners();
      updateFinancialOverview();

    }catch(error){
      print(  error.toString() );
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future<void> updateFinancialOverview()async{
    try{
      _isLoading=true;
      notifyListeners();

      double totalIncome=0;
      double totalExpense=0;

      for(TransactionData transactionData in _transactions){
        if(transactionData.type=='income'){
          totalIncome+=double.parse(transactionData.amount);
        }else{
          totalExpense+=double.parse(transactionData.amount);
        }
      }

      double remainingBudget=totalIncome-totalExpense;

      _firestore.collection('users').doc(_user!.uid).update({
        'totalIncome':totalIncome.toString(),
        'totalExpense':totalExpense.toString(),
        'remainingBudget':remainingBudget.toString()
      });
      _isLoading=false;
      notifyListeners();

    }catch(error){
      print('error');
    }finally{
      _isLoading=false;
      notifyListeners();
      refreshUser();
    }
  }



}