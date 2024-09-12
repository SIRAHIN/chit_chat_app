import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //get collection of notes
  final CollectionReference messages =
      FirebaseFirestore.instance.collection("Chit-Chat-Message");

  Future<void> send_messages(String message) async {
    await firebaseFirestore.collection('Chit-Chat-Message').add({
      'message': message,
      'user-email': auth.currentUser?.email ?? 'No email',
      'date-time': DateTime.now().microsecondsSinceEpoch
    });
  }
  
  // Get all Message // 
  Stream<QuerySnapshot<Object?>> get_messages() {
    final messageStream =
        messages.orderBy("date-time", descending: true).snapshots();
    return messageStream;
  }
}
