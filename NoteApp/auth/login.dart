import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:course_flutter/NoteApp/auth/Component/Alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var Mypassword, Myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);

        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Myemail,
          password: Mypassword,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context, title: "Error", body: Text("User Not Found"))
            ..show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("Wrong Password"),
            dialogBackgroundColor: Colors.green,
          )..show();
          print('Wrong password provided for that user.');
        }
      }
    } else {
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("IMAGES/1.jpg"),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                          onSaved: (newValue) {
                            Myemail = newValue;
                          },
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Email can't be longer than 100 letters";
                            }
                            if (value.length < 2) {
                              return "Email can't be less than 2 letters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            icon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          onSaved: (newValue) {
                            Mypassword = newValue;
                          },
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Password Can't be longer than 100 numbers";
                            }
                            if (value.length < 4) {
                              return "Password Can't be less than 4 numbers";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "password",
                            icon: Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          )),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text("If you dont have an account"),
                            InkWell(
                              child: Text(
                                "click here",
                                style: TextStyle(color: Colors.green),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed("signup");
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: ElevatedButton(
                        onPressed: () async {
                          UserCredential user = await login();

                          Navigator.of(context)
                              .pushReplacementNamed("HomePage");
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: "NotoSerif", fontSize: 20.0),
                        ),
                      ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
