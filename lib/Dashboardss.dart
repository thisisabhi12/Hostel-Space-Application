import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_space/ComplainPage.dart';
import 'package:hostel_space/additional/SplashScreen.dart';
import 'package:hostel_space/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MyApps(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber[500],
      ),
    ),
  );
}

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  // ====================================================== //
  String ConName, Tarrif;
  double ConNum,MeterNum,SdoCode;

  getconsumername(name) {
    this.ConName = name;
  }

  gettarrif(id) {
    this.Tarrif = id;
  }

  getMeterNum(results) {
    this.MeterNum = double.parse(results);
  }

  getconsumernumber(resultss) {
    this.ConNum = double.parse(resultss);
  }

  getsdonumber(result) {
    this.SdoCode = double.parse(result);
  }

  // TODO Create Data
  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(ConName);

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "ConsumerName": ConName,
      "Tarrif": Tarrif,
      "MeterNumber":MeterNum,
      "ConsumerNumber": ConNum,
      "SDOCOE": SdoCode,
    });

    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('$ConName created'));
  }

  // TODO Read Data
  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(ConName);
  }

  // TODO Update Data
  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(ConName);

    Map<String, dynamic> students = ({
      "ConsumerName": ConName,
      "Tarrif": Tarrif,
      "MeterNumber":MeterNum,
      "ConsumerNumber": ConNum,
      "SDOCOE": SdoCode,
    });

    // update data to Firebase
    documentReference
        .update(students)
        .whenComplete(() => print('$ConName updated'));
  }

  // TODO Delete Data
  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(ConName);

    // delete data from Firebase
    documentReference.delete().whenComplete(() => print('$ConName deleted'));
  }
  // ====================================================== //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComplainPage())),
              icon: Icon(Icons.help)),
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SplashScreen())),
              icon: Icon(Icons.logout))
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
                  'Consumer Number',
                  Icon(Icons.numbers_outlined),
                ),
                onChanged: (String number) {
                    getconsumernumber(number);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Consumer Name',
                  Icon(Icons.perm_identity_outlined),
                ),
                onChanged: (String sID) {
                  getconsumername(sID);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Tarrif',
                  Icon(Icons.account_balance),
                ),
                onChanged: (String sID) {
                  gettarrif(sID);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'Meter Number',
                  Icon(Icons.confirmation_number_outlined),
                ),
                onChanged: (String gpa) {
                  getMeterNum(gpa);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration(
                  'SDO CODE',
                  Icon(Icons.code),
                ),
                onChanged: (String sID) {
                  getsdonumber(sID);
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
                        primary: Colors.blue,
                        textStyle: TextStyle(color: Colors.white),
                        shape: raisedButtonBorder(),
                      ),
                      onPressed: () => readData(),
                      child: Text('Read',
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
                      'Consumer Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Consumer Number',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tarrif',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Meter Number',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      'SDO CODE',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('crud').snapshots(),
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
                                documentSnapshot.get('ConsumerName'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot.get('ConsumerNumber').toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot.get('Tarrif'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot.get('MeterNumber').toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot.get('SDOCOE').toString(),
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
