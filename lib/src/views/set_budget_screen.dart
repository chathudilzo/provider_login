import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';
import 'package:provider_login/src/views/home_screen.dart';

class SetBudgetScreen extends StatefulWidget {
  const SetBudgetScreen({super.key});

  @override
  State<SetBudgetScreen> createState() => _SetBudgetScreenState();
}

class _SetBudgetScreenState extends State<SetBudgetScreen> {
double minLimit = 0;
  double maxLimit = 1000;
  double currentBudget = 500;

  TextEditingController maxBudgetController=TextEditingController();
  TextEditingController minBudgetController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Budget'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10)]),
                  height: 200.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      
                      SizedBox(height: 150.h,width: 300.w,
                      child: Image.asset('assets/budget.png'),),
                      Text('want to save?',style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold),),
                   ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10)]),
                    child: Center(child: Text('Limit your spending with MySaver',
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400,color: Colors.grey),)),
                ),
                 Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10)]),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                      children: [
                        Text(minLimit.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Colors.green),),
                        Slider(
                      value: currentBudget,
                      onChanged: (value) {
                        setState(() {
                          currentBudget = value;
                        });
                      },
                      min: minLimit,
                      max: maxLimit,
                      divisions: (maxLimit - minLimit).toInt(),
                      label: currentBudget.toStringAsFixed(2),
                                 ),
                                 Text(maxLimit.toStringAsFixed(2),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Colors.orange),)
                      ],
                     ),
                   ),
                 ),
                 Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10)]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Current Budget: Rs. ',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                          Text(currentBudget.toStringAsFixed(2),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.black),)
                        ],
                      ),
                    ),
                 ),
                 SizedBox(height: 10.h,),
                 TextField(
                  keyboardType: TextInputType.number,
                  controller: maxBudgetController,
                  decoration: InputDecoration(
                    hintText: 'Enter Max Budget',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                 ),
                                  SizedBox(height: 10.h,),

                 TextField(
                                    keyboardType: TextInputType.number,

                  controller: minBudgetController,
                  decoration: InputDecoration(
                    hintText: 'Enter Min Budget',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                 ),
                 SizedBox(height: 10.h,),
                 ElevatedButton(onPressed: (){
                  setState(() {
                    if(maxBudgetController.text.isNotEmpty && minBudgetController.text.isNotEmpty)
                    {
                      maxLimit = double.parse(maxBudgetController.text);
                      minLimit = double.parse(minBudgetController.text);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Max and Min Budget')));
                    }
                  });
                 }, child: Text('Set Min and Max Budget')),

                 GestureDetector(
                  onTap: () {
                    context.read<UserProvider>().setMonthlyBudget(currentBudget,DateTime.now(),0.0);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                   child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple,
                      boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10)]),
                      child: Center(
                        child: Text('Set Budget',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                   ),
                 )
          
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}