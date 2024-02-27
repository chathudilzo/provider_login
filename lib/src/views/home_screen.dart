import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';
import 'package:provider_login/src/resources/auth_methods.dart';
import 'package:provider_login/src/views/graph_screen.dart';
import 'package:provider_login/src/views/set_budget_screen.dart';
import 'package:provider_login/src/views/view_transactions.dart';
import 'package:provider_login/src/widgets/monthly_budget.dart';
import 'package:provider_login/src/widgets/transaction_popup.dart';

import '../models/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData();
  }

  updateData()async{
   context.read<UserProvider>().refreshUser();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      //   actions: [IconButton(onPressed: (){
      //     FirebaseAuth.instance.signOut();
      //   }, icon: Icon(Icons.logout))],
      // ),
      body:Container(
        width: 360.w,
        height: 690.h,
        color: Colors.white,
        child: SafeArea(
          child: Consumer<UserProvider>(builder:(context,userProvider,child){
              if(userProvider.getUser==null){
                return const Center(child: CircularProgressIndicator(),);
              }else if(userProvider.isLoading){
                return const Center(child: CircularProgressIndicator(),);
              }else{
                return SingleChildScrollView(
                  
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Welcome, ',style:GoogleFonts.poppins(fontSize: 22.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                Text('${userProvider.getUser!.userName}!',style:GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network('https://static.vecteezy.com/system/resources/previews/021/548/095/original/default-profile-picture-avatar-user-avatar-icon-person-icon-head-icon-profile-picture-icons-default-anonymous-user-male-and-female-businessman-photo-placeholder-social-network-avatar-portrait-free-vector.jpg',width: 50,height: 50,),
                            ),
                            IconButton(onPressed: (){
                              AuthMethods().signOut();
                              
                            }, icon: Icon(Icons.logout))
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          height: 200.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/card.png',),fit: BoxFit.cover)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Remaining Budget',style: GoogleFonts.aboreto(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                Text('Rs.${userProvider.getUser!.remainingBudget.toString()}',style: GoogleFonts.poppins(fontSize: 14.sp,color: const Color.fromARGB(255, 180, 180, 180)),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        monthLyBudget(context),
                                SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                          height: 50.h,
                          width: 150.w,
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.w),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10.w
                          )],
                          color: Colors.grey.shade200,
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.arrow_circle_up_outlined,size: 30.sp,color: Colors.green,),
                              Column(
                                children: [
                                  Text('Rs.${userProvider.getUser!.totalIncome.toString()}'),
                                  Text('Total Income',style: GoogleFonts.poppins(fontSize: 12.sp,color: Colors.grey),)
                                ],
                              )
                            ],
                           ),
                         ),
                          ),
                          Container(
                          height: 50.h,
                          width: 150.w,
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.w),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10.w
                          )],
                          color: Colors.grey.shade200,
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.arrow_circle_down_sharp,size: 30.sp,color: Colors.red,),
                              Column(
                                children: [
                                  Text('Rs.${userProvider.getUser!.totalExpense.toString()}'),
                                  Text('Total Expences',style: GoogleFonts.poppins(fontSize: 12.sp,color: Colors.grey),)
                                ],
                              )
                            ],
                           ),
                         ),
                          ),
                          
                
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        
                       GestureDetector(
                        onTap: () {
                           showDialog(context: context, builder: (context)=>TransactionPopUp());
                        },
                         child: Container(
                            height: 50.h,
                            width: 360.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 36, 36, 35),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text('Add Transactions',style: GoogleFonts.poppins(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.bold,),
                                                   ),
                            )),
                       )
                                    ]
                                  ),
                      ),
                      Flexible(
                        
                        fit: FlexFit.loose,
                        child: Container(
                          width: double.infinity,
                         height: 250.h,
                          
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.grey.shade200,Colors.white],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w),topRight: Radius.circular(30.w))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h,),
                                Text('Financial Statistics',style: GoogleFonts.aclonica(fontSize: 20.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.h,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  financialItem('Set Goals', '6', Colors.blue, Icons.flag_outlined,TransactionsScreen()),
                                  financialItem('View Transactions', '10', Colors.blue, Icons.euro,TransactionsScreen())
                                ],),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    financialItem('Categories graph', '6', Colors.blue, Icons.graphic_eq,CategoryGraphScreen()),
                                    financialItem('Set Budget', '6', Colors.blue, Icons.shopping_basket_outlined,SetBudgetScreen())
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              }
              
              ),
        ),
      )
        
    );
      
    
  }


  Widget financialItem(String title,String value,Color color,IconData icon,Widget page){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>page));
      },
      child: Container(
                                  height: 70.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.w),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.5.w,
                                      offset: Offset(1, 2),
                                      blurRadius: 1.w
                                    )]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              
                                              borderRadius: BorderRadius.circular(15.w),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(icon),
                                                ),
                                                )
                                            ),
                                            Text(value,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(height: 5.h,),
                                        Text(title,style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),)
    
                                      ],
                                    ),
                                  ),
                                  ),
    );
  }

}
