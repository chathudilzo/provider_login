import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_login/src/models/transactions.dart';
import 'package:provider_login/src/models/user_data.dart';
import 'package:provider_login/src/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier{




  String _searchKeyword='';

  List<TransactionData> get getFilteredTransactions =>_filtedTransactions;

  List<TransactionData> _filtedTransactions=[];

  UserData? _user;

  List<TransactionData> _transactions=[];

  bool  _isLoading=false;

  bool get isLoading=>_isLoading;

  List<TransactionData> get getTransactions=>_transactions;

  final AuthMethods _authMethods=AuthMethods();

  UserData? get getUser=> _user;

  FirebaseFirestore _firestore=FirebaseFirestore.instance;


  String _selectedDate='ALL';
  String _selectedType='ALL';
  String _selectedCategory='ALL';

String get selectedType => _selectedType;
  String? get selectedDate => _selectedDate;
  String get selectedCategory => _selectedCategory;






  Future<void> refreshUser()async{
    UserData user= await _authMethods.getUserDetails();
    _user=user;
    _transactions=user.transactions??[];
    notifyListeners();
  }

void filterTransactions(String keyword){
  _isLoading=true;
  notifyListeners();
  print('$_selectedCategory $_selectedDate $_selectedType');
  if(keyword.isEmpty){
    _searchKeyword='';
  }
      _searchKeyword=keyword.toLowerCase();
    _filtedTransactions=_transactions.where((transaction)=>
    (transaction.type.toLowerCase().contains(_searchKeyword) ||
                transaction.description.toLowerCase().contains(_searchKeyword) ||
                transaction.category.toLowerCase().contains(_searchKeyword) ||
                transaction.date.toLowerCase().contains(_searchKeyword) ||
                transaction.amount.toString().toLowerCase().contains(_searchKeyword)) 
             //   &&
            // (transaction.type.toLowerCase() == _selectedType.toLowerCase() || _selectedType == 'All') &&
            // (transaction.date == _selectedDate || _selectedDate == 'ALL') &&
            // (transaction.category.toLowerCase() == _selectedCategory.toLowerCase() || _selectedCategory == 'All')
            )
        .toList();
    _isLoading=false;
    notifyListeners();
}

void clearFilter(){
  _searchKeyword='';
  _selectedCategory='ALL';
  _selectedDate='ALL';
  _selectedType='ALL';
  _filtedTransactions=_transactions;
  _isLoading=false;
  notifyListeners();
}




  Future<void> addTransaction(TransactionData transaction)async{
    try{
      _isLoading=true;
      notifyListeners();
      _transactions.add(transaction);
      
      if(transaction.type=='expense'){
        double budgetAmount=_user!.monthlyBudget.budgetAmount;
        if(budgetAmount>0.0){
          double monthlyExpence=_user!.monthlyBudget.monthlyExpense;
          monthlyExpence+=double.parse(transaction.amount);
          await _firestore.collection('users').doc(_user!.uid).update({'monthlyBudget.monthlyExpense':monthlyExpence.toString()});
        }
      }
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

void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void setSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

 List<Map<String, dynamic>> calculateWeeklyIncomeAndExpenses() {
    
     DateTime today = DateTime.now();
    
     
     DateTime startOfWeek = today.subtract(Duration(days: 6));

      
     List<Map<String, dynamic>> weeklyData = [];

 
     for (int i = 0; i < 7; i++) {
       DateTime currentDate = startOfWeek.add(Duration(days: i));
      
        //Filter transactions for the current date
       List<TransactionData> transactionsForDate = _transactions
           .where((transaction) =>
               DateTime.parse(transaction.date).year == currentDate.year &&
               DateTime.parse(transaction.date).month == currentDate.month &&
               DateTime.parse(transaction.date).day == currentDate.day)
           .toList();

        //Calculate daily income and expenses
       double dailyIncome = transactionsForDate
           .where((transaction) => transaction.type == 'income')
           .fold(0, (sum, transaction) => sum + double.parse(transaction.amount));

       double dailyExpense = transactionsForDate
           .where((transaction) => transaction.type == 'expense')
           .fold(0, (sum, transaction) => sum + double.parse(transaction.amount));

        //Add the data to the list
       weeklyData.add({
         'date': currentDate,
         'income': dailyIncome,
         'expense': dailyExpense,
       });
     }
    print(weeklyData);
     return weeklyData;
   }

Future<void> setMonthlyBudget(

     double budgetAmount, DateTime startDate,double monthlyExpense) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update({
      'monthlyBudget': {
        'budgetAmount': budgetAmount,
        'startDate': DateFormat('yyyy-MM-dd').format(startDate).toString(),
        'endDate': DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: 30))),
        'monthlyExpense':monthlyExpense
      },
    });
    refreshUser();
  } catch (e) {
    print('Error setting monthly budget: $e');
    // Handle error as needed
  }
}


}