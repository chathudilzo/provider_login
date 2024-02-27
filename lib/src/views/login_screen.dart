

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_login/src/resources/auth_methods.dart';
import 'package:provider_login/src/views/home_screen.dart';
import 'package:provider_login/src/views/signup_screen.dart';
import 'package:provider_login/src/widgets/social_row.dart';
import 'package:provider_login/src/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser()async{
    String res= await AuthMethods().loginUser(email: emailController.text, password: passwordController.text);
    if(res=='Register successed'){
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Occured')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Container(
        color: Colors.white,
        width: 360.w,
        height: 690.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                SizedBox(
                  width: 300.w,
                  child: Column(
                    children: [
          
                      Container(
                        width: 200.w,
                        height: 200.h,
                        child: Image.asset('assets/login.png'),
                      ),
                      TextInputField(hintText: 'Email', obscureText: false, textInputType: TextInputType.emailAddress,controller: emailController,),
                SizedBox(height: 30,),
                TextInputField(hintText: 'Password', obscureText: true, textInputType: TextInputType.visiblePassword,controller: passwordController,),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                GestureDetector(
                  onTap: () {
                    loginUser();
                  },
                  child: Container(
                    width: 300.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.w),
                      color: Colors.yellow,
                      boxShadow: [BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0,5)
                
                      )]
                    ),
                    child: Center(
                      child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                    }, child: Text('Sign Up'))
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 300.w,
                  child: socialRow())
              ],
            ),
          ),
        ),)
      ));
    
  }
}