import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_login/src/resources/auth_methods.dart';
import 'package:provider_login/src/views/login_screen.dart';
import 'package:provider_login/src/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

@override
  void dispose(){
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();
  nameController.dispose();
  super.dispose();
}

void registerUser()async{
  String resp=await AuthMethods().registerUser(email: emailController.text, password: passwordController.text, name: nameController.text, confirmPassword: confirmPasswordController.text);

  if(resp=='Register successed'){
    
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resp)));
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 690.h,
      child: SafeArea(child: Scaffold(
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
               Container(
                      width: 200.w,
                      height: 200.h,
                      child: Image.asset('assets/signup.png'),
                    ),
                SizedBox(
                  width: 300.w,
                  child:Column(
                    children: [
                      TextInputField(hintText: 'Email', obscureText: false, textInputType: TextInputType.emailAddress,controller: emailController,),
                SizedBox(height: 30,),
                TextInputField(hintText: 'Name', obscureText: false, textInputType:TextInputType.name, controller: nameController),
                  
                SizedBox(height: 30.w,),
                TextInputField(hintText: 'Password', obscureText: true, textInputType: TextInputType.visiblePassword,controller: passwordController,),
                SizedBox(height: 30,),
                
                  
                TextInputField(hintText: 'Confirm Password', obscureText: true, textInputType: TextInputType.visiblePassword, controller: confirmPasswordController),  
                    ],
                  ),
                ),
                  SizedBox(height: 30.h,),
                GestureDetector(
                onTap: () {
                  registerUser();
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
                    child: Text('Sign Up',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),  
                  
                  
               
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }, child: Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}