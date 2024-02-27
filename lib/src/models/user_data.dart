import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider_login/src/models/monthly_budget.dart';
import 'package:provider_login/src/models/transactions.dart';



class UserData{
  final String email;
  final String uid;
  final String userName;
  final List<TransactionData> transactions;
  final String remainingBudget;
  final String totalIncome;
  final String totalExpense;
  final MonthlyBudget monthlyBudget;
  

  // final List<TransactionData> transactions;
  // final List<TransactionData> transactionData;
  // final List<TransactionData> transactionData;


  // final List<TransactionData> transactionData;

   const UserData({
    required this.email,
    required this.uid,
    required this.userName,
    required this.transactions,
    required this.remainingBudget,
    required this.totalIncome,
    required this.totalExpense,
    required this.monthlyBudget
  });


  Map<String,dynamic> toJson()=>{
    'email':email,
    'uid':uid,
    'userName':userName,
    'transactions':transactions.map((transaction) => transaction.toJson()).toList(),
     'remainingBudget':remainingBudget,
    'totalIncome':totalIncome,
    'totalExpense':totalExpense,
    'monthlyBudget':monthlyBudget.toJson()
  };


  static UserData fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    List<dynamic> transactionsDynamic=snapshot['transactions'];
    print('SNAP:$transactionsDynamic');
    List<TransactionData> transactions = transactionsDynamic.map((dynamic transaction)=>TransactionData.fromJson(transaction as Map<String,dynamic>)).toList();
      print('SNAP2:${transactions.length}');

    return UserData(email: snapshot['email'], uid: snapshot['uid'], userName: snapshot['userName'], transactions:transactions, remainingBudget: snapshot['remainingBudget'].toString(), totalIncome: snapshot['totalIncome'].toString(), totalExpense: snapshot['totalExpense'].toString(),monthlyBudget: MonthlyBudget.fromJson(snapshot['monthlyBudget']));


  }



}