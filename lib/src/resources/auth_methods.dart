import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider_login/src/models/monthly_budget.dart';
import 'package:provider_login/src/models/transactions.dart';
import 'package:provider_login/src/models/user_data.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool isLoading=false;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<void> signOut()async{
    await _auth.signOut();
  }


  Future<String> registerUser({required String email, required String password,required String name,required String confirmPassword})async{
    isLoading=true;
    String resp='failed';
    try{
      if(email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && confirmPassword.isNotEmpty){
        if(password==confirmPassword){
          List<TransactionData> transactions=<TransactionData>[];
          //register user
          UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
          MonthlyBudget emptyMonthlyBudget = MonthlyBudget(budgetAmount: 0.0, startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()), endDate:DateFormat('yyyy-MM-dd').format(DateTime.now()),monthlyExpense: 0.0);
          UserData userData=UserData(email: email,userName: name,uid:cred.user!.uid,transactions:transactions,remainingBudget: '0.0',totalIncome: '0.0',totalExpense: '0.0',monthlyBudget: emptyMonthlyBudget);
          

          await _firestore.collection('users').doc(cred.user!.uid).set(userData.toJson());
          resp ='Register successed';
          



        }else{
          resp='passwords do not match';
          print('passwords do not match');
        }
      }else{
        resp='Please enter all the fields';
        print('Please enter all the fields');
      }
    }catch(e){
      resp=e.toString();
      print(e.toString());
    }
    isLoading=false;
    return resp;

  }

  Future<String> loginUser({required String email,required String password})async{
    isLoading=true;
    String res='failed';
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res='Register successed';
        print('success');
      }else{
        res='Please enter all the fields';
        print('Please enter all the fields');
      }
    }catch(e){
      res=e.toString();
      print(e.toString());
    }
    isLoading=false;
    return res;
  }


  Future <UserData> getUserDetails()async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    print(snap.data());
    return UserData.fromSnap(snap);
  }
}