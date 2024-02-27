import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';
import 'package:provider_login/src/widgets/line_chart.dart';

class CategoryGraphScreen extends StatefulWidget {
  const CategoryGraphScreen({super.key});

  @override
  State<CategoryGraphScreen> createState() => _CategoryGraphScreenState();
}

class _CategoryGraphScreenState extends State<CategoryGraphScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserProvider>().calculateWeeklyIncomeAndExpenses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Graph"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child:LineChartSample1(),
      ),
    );
  }
}