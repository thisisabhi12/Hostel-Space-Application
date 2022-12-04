import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_space/widgets.dart';

class ComplainPage extends StatefulWidget {
  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  // ====================================================== //
  String Complain, Category;

  getconsumercomplain(name) {
    this.Complain = name;
  }

  getcomplaincategory(id) {
    this.Category = id;
  }

  // TODO Create Data
  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('complain').doc(Complain);

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Complain": Complain,
      "Category": Category,
    });

    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('$Complain created'));
  }

  // TODO Read Data
  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('complain').doc(Complain);
  }

  // TODO Update Data
  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('complain').doc(Complain);

    Map<String, dynamic> students = ({
      "Complain": Complain,
      "Category": Category,
    });

    // update data to Firebase
    documentReference
        .update(students)
        .whenComplete(() => print('$Complain updated'));
  }

  // TODO Delete Data
  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('complain').doc(Complain);

    // delete data from Firebase
    documentReference.delete().whenComplete(() => print('$Complain deleted'));
  }
  // ====================================================== //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ComplainPage())),
            icon: Icon(Icons.help),
          )
        ],
        centerTitle: true,
        title: Center(child: Text('MGVCL')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Complain',
                  Icon(Icons.numbers_outlined),
                ),
                onChanged: (String number) {
                  getconsumercomplain(number);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Category',
                  Icon(Icons.perm_identity_outlined),
                ),
                onChanged: (String sID) {
                  getcomplaincategory(sID);
                },
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        primary: Colors.green,
                        textStyle: TextStyle(color: Colors.white),
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: () => createData(),
                      child: Text('Create',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        primary: Colors.orange,
                        textStyle: TextStyle(color: Colors.white),
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: () => updateData(),
                      child: Text('Update',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 8.0,
                        primary: Colors.purple,
                        textStyle: TextStyle(color: Colors.white),
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: () => deleteData(),
                      child: Text('Delete',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1.0, height: 25.0, color: Colors.green),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Complain',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Category',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('complain')
                    .snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                documentSnapshot.get('Complain'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot.get('Category'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
