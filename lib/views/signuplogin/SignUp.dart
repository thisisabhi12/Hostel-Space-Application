import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_space/Dashboardss.dart';
import 'package:hostel_space/services/database.dart';
import 'SignIn.dart';

class HostelerSignUp extends StatefulWidget {
  @override
  HostelerSignUpState createState() => HostelerSignUpState();
}

class HostelerSignUpState extends State<HostelerSignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ConsumerNo = TextEditingController();
  TextEditingController Password = TextEditingController();
  QuerySnapshot querySnapshot;

  DateTime selectedDate = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2022),
        initialDatePickerMode: DatePickerMode.year,
        context: context);
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String collage = 'Select Your College';
  String branch = 'Select Your Branch';
  String year = 'Select Your Year';
  String hostel = 'Select Your Hostel';
  DatabaseMethods databaseMethods = DatabaseMethods();

  addStudentDetails() async {
    if (formKey.currentState.validate()) {
      await databaseMethods.getUserByEnrollment(ConsumerNo.text).then((val) {
        setState(() {
          querySnapshot = val;
        });
      });
      if (querySnapshot.docs.length == 0) {
        Map<String, String> studentDetails = {
          "name": name.text,
          "Consumer Number": ConsumerNo.text,
          "mobile": "+91" + mobileNo.text,
          "email": email.text,
          "Password": Password.text,
          "dob": selectedDate.toString(),
        };

        try {
          await databaseMethods.sendStudentRequest(
              ConsumerNo.text, studentDetails);
        } catch (e) {
          print(e.toString());
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApps()));
      } else {
        print("Already Registered");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text("Create an Account!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: "FredokaOne")),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Form(
              key: formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            controller: name,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Full Name",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                            validator: (value) => value.isEmpty
                                ? 'Enter Your Name'
                                : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(value)
                                    ? 'Enter a Valid Name'
                                    : value.length < 3
                                        ? 'Name must contain more than 3 characters'
                                        : null,
                          ),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            controller: mobileNo,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                          ),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            controller: email,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "E-mail",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: Text(
                            selectedDate.toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                selectDate(context);
                                print(selectedDate.toString());
                              },
                              child: Icon(Icons.calendar_today_sharp)),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            controller: ConsumerNo,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Consumer Number",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                          ),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            obscureText: true,
                            controller: Password,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                          ),
                        )),
                    SizedBox(
                      height: 7.0,
                    ),
                    Card(
                        elevation: 2,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "RGPU",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                          ),
                        )),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApps(),
                            ),
                          ),
                          child: Icon(Icons.ads_click),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
