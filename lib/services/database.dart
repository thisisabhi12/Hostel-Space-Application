import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getcaretakerdetails() async {
    return await FirebaseFirestore.instance.collection("user-caretaker").get();
  }

  getwardendetails() async {
    return await FirebaseFirestore.instance.collection("user-warden").get();
  }

  sendStudentRequest(String enrollment, studentdetails) async {
    FirebaseFirestore.instance
        .collection("student-request")
        .doc(enrollment)
        .set(studentdetails)
        .catchError((e) {
      print(e.toString());
    });
  }

  addGatepassRequest(String enrollment, studentdetails) async {
    FirebaseFirestore.instance
        .collection("gatepass-request")
        .doc(enrollment)
        .set(studentdetails)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserByEnrollment(String enrollment) async {
    return await FirebaseFirestore.instance
        .collection("student-list")
        .where("roll", isEqualTo: enrollment)
        .get();
  }

  deleteStudentRequest(roll) async {
    return await FirebaseFirestore.instance
        .collection("student-request")
        .doc(roll)
        .delete();
  }

  acceptStudentRequest(roll, studentRequestDetail) async {
    return await FirebaseFirestore.instance
        .collection("student-list")
        .doc(roll)
        .set(studentRequestDetail);
  }

  acceptGatepassRequest(roll, gatepassRequestDetail) async {
    return await FirebaseFirestore.instance
        .collection("student-list")
        .doc(roll)
        .collection("gatepass")
        .doc()
        .set(gatepassRequestDetail);
  }

  deleteGatepassRequest(roll) async {
    return await FirebaseFirestore.instance
        .collection("gatepass-request")
        .doc(roll)
        .delete();
  }

  acceptGatepassRequestforwarden(gatepassRequestDetail) async {
    return await FirebaseFirestore.instance
        .collection("gatepass-record")
        .doc()
        .set(gatepassRequestDetail);
  }

  sendcomplaintDetailsWarden( complaintDetails) async {
    FirebaseFirestore.instance
        .collection("user-warden")
        .doc("Warden")
        .collection("student-complaint")
        .doc()
        .set(complaintDetails)
        .catchError((e) {
      print(e.toString());
    });
  }

  sendcomplaintDetailsCaretaker( complaintDetails) async {
    FirebaseFirestore.instance
        .collection("user-caretaker")
        .doc("Caretaker")
        .collection("student-complaint")
        .doc()
        .set(complaintDetails)
        .catchError((e) {
      print(e.toString());
    });
  }

  sendRoomShiftDetails(roomShiftDetails) async
  {
    FirebaseFirestore.instance
        .collection("user-warden")
        .doc("Warden")
        .collection("student-roomshift")
        .doc()
        .set(roomShiftDetails)
        .catchError((e) {
      print(e.toString());
    });
  }
}
