import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';

Widget monthLyBudget(BuildContext context){
  final userProvider = Provider.of<UserProvider>(context);
  return Container(
    width: 360.w,
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(
        blurRadius: 1,spreadRadius: 1,offset: Offset(1, 2)
      )],
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(colors: [Colors.purple,Colors.black])
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
            
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Expanded(
            //fit: FlexFit.loose,
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monthly Statistic',style: TextStyle(fontSize: 16.sp,color: Colors.amberAccent,fontWeight: FontWeight.bold),),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: [
                    Text('Monthly Budget:',style: TextStyle(fontSize: 14.sp,color: Colors.grey),),Text('Rs.${userProvider.getUser!.monthlyBudget.budgetAmount.toString()}',style: TextStyle(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                     

                  ]),
                  SizedBox(height: 10.h,),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: [
                      Text('Monthly Expences:',style: TextStyle(fontSize: 14.sp,color: Colors.grey),),Text('Rs.${userProvider.getUser!.monthlyBudget.monthlyExpense.toString()}',style: TextStyle(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),],),
                     
                
                  SizedBox(height: 10.h,),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: [
                    Text('Monthly Remaining:',style: TextStyle(fontSize: 14.sp,color: Colors.grey),),Text('Rs.151515515515151515',style: TextStyle(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),)
                     
                    ],)
                
                ],
      
              ),
            
          ),
          SizedBox(width: 20.w,),
          SizedBox(
            child: Container(
              //color: Colors.white,
              width: 100.w,
              height: 100.w,
              child: Center(
                child: CircularPercentIndicator(
                  backgroundColor:Colors.green ,
                  progressColor: Colors.amberAccent,
                  radius: 54.0,
                lineWidth: 20.0,
                center: Text('MB',style: TextStyle(color: Colors.white),),
                percent: 0.8,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                ),
              )
            ),
          )
          ]
      ),
    )
        
   
  );
}