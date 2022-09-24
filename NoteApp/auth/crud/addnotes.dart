import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/NoteApp/auth/home/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  Reference? ref;
  File? file;
  var title, note, Imageurl;
  DateTime? createat = DateTime.now() ;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Addnotes(context) async {
    if (file == null) {
      return AwesomeDialog(
          context: context,
          title: "important",
          body: Text("please add image for the note"),
          dialogType: DialogType.ERROR)
        ..show();
    }
    var FormData = formstate.currentState;
    if (FormData!.validate()) {
      FormData.save();
      await ref!.putFile(file!);
      Imageurl = await ref?.getDownloadURL();
      var response = await notesref.add({
        "title": title,
        "note": note,
        "Imageurl": Imageurl,
        "Create At" : DateTime.now(),
        "UserUid": FirebaseAuth.instance.currentUser?.uid,
      });
    //  print("Here we are ${response.snapshots().elementAt(0)}");
    //  Navigator.push(
    //      context,
    //      MaterialPageRoute(
    //          builder: (context) => HomePage(restraunt: recievedImages[index]
    //               )));
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add notes"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.length > 250) {
                            return "Note can't be longer than 250 letters";
                          }
                          if (value.length < 2) {
                            return "Note can't be less than 25 letters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          title = newValue;
                        },
                        minLines: 1,
                        maxLines: 1,
                        maxLength: 250,
                        decoration: InputDecoration(
                          icon: Icon(Icons.note_add),
                          filled: true,
                          label: Text("add note title"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length > 1000) {
                            return "Content can't be longer than 1000 letters";
                          }
                          if (value.length < 2) {
                            return "Content can't be less than 50 letters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          note = newValue;
                        },
                        maxLength: 1000,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          icon: Icon(Icons.note_add),
                          filled: true,
                          label: Text("add note content"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          visualDensity: VisualDensity.comfortable,
                        ),
                        onPressed: () {
                          showBottomSheet(context);
                        },
                        child: Text("add an images"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await Addnotes(context);
                          if(ref != null){
                            Navigator.pushReplacementNamed(context, "HomePage");
                          }
                        },
                        child: Text(
                          "add to the notes",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(15.0),
            height: 160.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please choose the image :",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w900),
                ),
                Row(
                  children: [
                    Icon(Icons.browse_gallery),
                    InkWell(
                        onTap: () async {
                          var picked = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (picked != null) {
                            file = File(picked.path);
                            var random = Random().nextInt(100000);
                            var imagename = "$random" + basename(picked.path);
                            ref = FirebaseStorage.instance
                                .ref("images")
                                .child("$imagename");
                            Navigator.of(context).pop();
                          }
                          ;
                        },
                        child: Text(
                          " 1) From gallery :",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Icon(Icons.camera_alt_sharp),
                    InkWell(
                        onTap: () async {
                          var picked = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (picked != null) {
                            file = File(picked.path);
                            var random = Random().nextInt(100000);
                            var imagename = "$random" + basename(picked.path);
                            ref = FirebaseStorage.instance
                                .ref("images")
                                .child("$imagename");
                          }
                          ;
                        },
                        child: Text(
                          " 2) From Camera :",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }
}
//  await ref.putFile(file!);
                           // Imageurl = await ref.getDownloadURL();