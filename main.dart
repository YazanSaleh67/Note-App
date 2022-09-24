import 'package:course_flutter/NoteApp/auth/crud/Editnotes.dart';
import 'package:course_flutter/NoteApp/auth/crud/addnotes.dart';
import 'package:course_flutter/NoteApp/auth/home/homepage.dart';
import 'package:course_flutter/NoteApp/auth/login.dart';
import 'package:course_flutter/NoteApp/auth/signup.dart';
import 'package:course_flutter/StateManagment/AddCart.dart';
import 'package:course_flutter/StateManagment/HomePageCart.dart';
import 'package:course_flutter/StateManagment/Provider1.dart';
import 'package:course_flutter/StateManagment/Provider3.dart';
import 'package:course_flutter/StateManagment/Provider4.dart';
import 'package:course_flutter/StateManagment/note.dart';
import 'package:course_flutter/StateManagment/Jsonnotes.dart';
import 'package:course_flutter/TestRestApi/TestApiRequest2.dart';
import 'package:course_flutter/TimeStamp.dart';
import 'package:course_flutter/UI/BottomNavigationBar.dart';
import 'package:course_flutter/UI/ChangePassword.dart';
import 'package:course_flutter/UI/ChangePasswordConfirm.dart';
import 'package:course_flutter/UI/ForgetPassword.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/HomePage2.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/HomePage2ChildPage.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/Homepage3.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/JsonImages.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/JsonImages2.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/JsonImages3.dart';
import 'package:course_flutter/TestRestApi/ResturantsProvider.dart';
import 'package:course_flutter/UI/HomePage(1,2,3).dart/Test1.dart';
import 'package:course_flutter/UI/OnBoarding.dart';
import 'package:course_flutter/UI/RegistrationFood.dart';
import 'package:course_flutter/UI/SuccesEmailSent.dart';
import 'package:course_flutter/UI/SuccessPaswordChange.dart';
import 'package:course_flutter/test2.dart';
import 'package:course_flutter/TestRestApi/TestApiRequest.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

bool? islogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return GetFoodImages();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return GetFoodImages2();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return GetFoodImages3();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return GetDetailRestaurants1();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return RestaurantProivder();
            },
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SignUp(),
          theme: ThemeData(
              fontFamily: "NotoSerif",
              primaryColor: Colors.green,
              //  buttonColor: Colors.green,
              //buttonTheme: ButtonThemeData(minWidth: 100.0),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0))),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(50, 183, 104, 50))),
              ),
              textTheme: TextTheme(
                  headline6: TextStyle(color: Colors.white, fontSize: 20.0),
                  headline1: TextStyle(fontSize: 25.0, color: Colors.green))),
          routes: {
            "login": (context) {
              return Login();
            },
            "signup": (context) {
              return SignUp();
            },
            "HomePage": ((context) {
              return HomePage();
            }),
            "AddNotes": (context) {
              return AddNotes();
            },
            "Test2": ((context) {
              return TestTwo();
            }),
            "EditNotes": ((context) {
              return EditNotes();
            }),
            "Onboarding": ((context) {
              return Page1();
            }),
            "RegisterFood": ((context) {
              return RegistrationFood();
            }),
            "ForgetPassword": ((context) {
              return ForgetPassword();
            }),
            "SuccessEmailSent": ((context) {
              return SuccessEmailSent();
            }),
            "ChangePassword": ((context) {
              return ChangePassword();
            }),
            "ChangePasswordConfirm": ((context) {
              return ChangePassword2();
            }),
            "SuccessPaswordChange": ((context) {
              return SuccessPaswordChange();
            }),
            "Homepage3": ((context) {
              return UserInfoPage();
            }),
            "BottomNaviagtionBar": ((context) {
              return bottomNavigationBar();
            }),
            // 'Detailed restaurant' : ((context) {
            //   return DetailRestaurants() ;
            // })
          },
        ));

    //   );
  }
}
