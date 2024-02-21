import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/firebase_options.dart';
import 'package:provider_login/src/provider/user_provider.dart';
import 'package:provider_login/src/views/home_screen.dart';
import 'package:provider_login/src/views/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(),)
    ],
    child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainScreen(),
        );
      }));


  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.connectionState ==ConnectionState.active){
          if(snapshot.hasData){
            return HomeScreen();
          }else if(snapshot.hasError){
            return Center(
              child: Text("Error"),
            );
          }else{
            return LoginScreen();
          }
        }else{
          return Center(
            child: Text("Error"),
          );
        }
       
     })
    ) ;
  }
}








      