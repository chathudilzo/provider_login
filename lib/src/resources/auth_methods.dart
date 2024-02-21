import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider_login/src/models/transactions.dart';
import 'package:provider_login/src/models/user_data.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<String> registerUser({required String email, required String password,required String name,required String confirmPassword})async{
    String resp='failed';
    try{
      if(email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && confirmPassword.isNotEmpty){
        if(password==confirmPassword){
          List<TransactionData> transactions=<TransactionData>[];
          //register user
          UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
          UserData userData=UserData(email: email,userName: name,uid:cred.user!.uid,transactions:transactions,remainingBudget: '0.0',totalIncome: '0.0',totalExpense: '0.0');
          

          await _firestore.collection('users').doc(cred.user!.uid).set(userData.toJson());
          resp ='success';
        }else{
          print('Passwords do not match');
        }
      }else{
        print('Please enter all the fields');
      }
    }catch(e){
      print(e.toString());
    }
    return resp;

  }

  Future<String> loginUser({required String email,required String password})async{
    String res='failed';
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res='success';
        print('success');
      }else{
        print('Please enter all the fields');
      }
    }catch(e){
      print(e.toString());
    }
    return res;
  }


  Future <UserData> getUserDetails()async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    print(snap.data());
    return UserData.fromSnap(snap);
  }
}