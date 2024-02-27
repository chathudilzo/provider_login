import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyBudget {
  final double budgetAmount;
  final String startDate;
  final double monthlyExpense;
  final String endDate ;


  MonthlyBudget({required this.budgetAmount, required this.startDate,required this.monthlyExpense, required this.endDate});

  factory MonthlyBudget.fromJson(Map<String, dynamic> json) {
    return MonthlyBudget(
    budgetAmount: json['budgetAmount'] as double,
    startDate:json['startDate'],
    monthlyExpense: json['monthlyExpense'] as double,
    endDate: json['endDate'],
  );
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetAmount': budgetAmount,
      'startDate': startDate,
      'monthlyExpense': monthlyExpense,
      'endDate': endDate
    };
  }
}
