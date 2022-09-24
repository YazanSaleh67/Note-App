import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/NoteApp/auth/Component/Alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var Myusername, Mypassword, Myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          
          email: Myemail,
          password: Mypassword,

        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "error",
              body: Text("Passsword is to weak"));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "error",
              body: Text("The Email is already in use"));
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      SizedBox(
        height: 100,
      ),
      Center(
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
                          onSaved: ((newValue) {
                            Myusername = newValue;
                          }),
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Username Can't be larger than 100 letters";
                            }
                            if (value.length < 2) {
                              return "Username Can't be Less than 2 letters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Username",
                            icon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          )),
                      // SizedBox(
                      // height: 10.0,
                      //),

                      // SizedBox(
                      //height: 10.0,
                      //),
                      //   TextFormField(
                      //     obscureText: true,
                      //   decoration: InputDecoration(
                      //         hintText: "Repeat password",
                      //       icon: Icon(Icons.password),
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //         BorderRadius.all(Radius.circular(20.0))),
                      //)),
                      SizedBox(
                        height: 10.0,
                      ),
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
                            icon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormField(
                          onSaved: ((newValue) {
                            Mypassword = newValue;
                          }),
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Password Can't be longer than 100 numbers";
                            }
                            if (value.length < 4) {
                              return "Password Can't be less than 4 numbers";
                            }
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
                            Text("If you  have an account"),
                            InkWell(
                              child: Text(
                                "click here",
                                style: TextStyle(color: Colors.green),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("login");
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: ElevatedButton(
                        onPressed: () async {
                          UserCredential? response = await signUp();
                          print("===================");
                          if (response != null) {
                            await FirebaseFirestore.instance.collection("Users").add({
                              "username" : Myusername ,
                              "email"  : Myemail 
                            });
                            Navigator.of(context)
                                .pushReplacementNamed("HomePage");
                          }
                          print("===================");
                        },
                        child: Text(
                          "SignUp",
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
    ]));
  }
}
