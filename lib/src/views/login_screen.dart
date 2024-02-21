

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_login/src/resources/auth_methods.dart';
import 'package:provider_login/src/views/home_screen.dart';
import 'package:provider_login/src/views/signup_screen.dart';
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
    if(res=='success'){
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
        child: Column(
          children: [
            Text("Login Screen"),
            TextInputField(hintText: 'Email', obscureText: false, textInputType: TextInputType.emailAddress,controller: emailController,),
            SizedBox(height: 30,),
            TextInputField(hintText: 'Password', obscureText: true, textInputType: TextInputType.visiblePassword,controller: passwordController,),
            
            ElevatedButton(onPressed: () {
              loginUser();
            }, child: Text("Login")),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account?'),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                }, child: Text('Sign Up'))
              ],
            )
          ],
        ),)
      ));
    
  }
}