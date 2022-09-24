import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/StateManagment/Jsonnotes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  var note;
  HomePage({Key? key, this.note = null}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List Notes = [];
  Query<Map<String, dynamic>> Notesref = FirebaseFirestore.instance
      .collection("notes")
      .orderBy("Create At", descending: true);

  //GetData() async {
  // QuerySnapshot response = await Notesref.orderBy().get();
  //QuerySnapshot response = await Notesref.get();
  //response.docs.forEach((element) {
  //setState(() {
  // print(element.toString());
  // Notes.add(element.data());
  //});
  //});
  //print(Notes);
  //}

  GetUser() async {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.email);
  }

  addnewNote() {
    if (widget.note != null) {
      // Notes.add(widget.note);
    }
  }

  @override
  void initState() {
    addnewNote();
    // GetData();

    // getNotesData();
    GetUser();
    // TODO: implement initState
    super.initState();
  }

  getNotesData() async {
    return await Provider.of<Notes>(context).Getdata();
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("homepage"),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("login");
              },
              icon: Icon(Icons.exit_to_app)),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pushNamed("AddNotes");
            },
            child: Icon(Icons.add)),
        body: FutureBuilder(
          future: Provider.of<Notes>(context).Getdata(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: Provider.of<Notes>(context).RecievedNotes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Row(
                  children: [
                    Container(
                      width: mdw - 100.0,
                      child: ListTile(
                        title: Text(
                            "${Provider.of<Notes>(context).RecievedNotes[index].title}"),
                        subtitle: Text(
                            "${Provider.of<Notes>(context).RecievedNotes[index].note}"),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Image.network(
                            "${Provider.of<Notes>(context).RecievedNotes[index].Imageurl}"),
                        // Text("${value.recievedNotes[index].toDate().toString()}"),
                      ],
                    ))
                  ],
                ));
              },
            );
          },
        ));
  }
}

//class ListNotes extends StatelessWidget {
  //const ListNotes({Key? key, this.Notes, this.mdw}) : super(key: key);
  //final Notes;
  //final mdw;

 // @override
  //Widget build(BuildContext context) {
    //return Card(
      //  child: Row(
      //children: [
        //Container(
          //width: mdw - 100.0,
          //          //child: ListTile(
//            title: Text("${Notes['title']}"),
  //          subtitle: Text("${Notes["note"]}"),
    //        trailing: IconButton(
      //        icon: Icon(Icons.edit),
        //      onPressed: () {},
          //  ),
          //),
        //),
 //       Expanded(
   //       child: Image.network(
     //       "${Notes['Imageurl']}",
       //     fit: BoxFit.fill,
         //   height: 80,
          //),
        //)
      //],
    //));
  //}
//}
