import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //get collection of notes
  final CollectionReference messages =
      FirebaseFirestore.instance.collection("Chit-Chat-Message");


  Future<void> sendMessage(String message) async {
    await FirebaseFirestore.instance.collection('Chit-Chat-Message').add({
      'message': message,
      'user-email': FirebaseAuth.instance.currentUser?.email ?? 'No email',
      'date-time': DateTime.now().microsecondsSinceEpoch,
      'imageUrl': null, // Ensure that this field is null for text messages
    });
  }

  Future<void> sendImageMessage(String imageUrl) async {
    await FirebaseFirestore.instance.collection('Chit-Chat-Message').add({
      'message': null, // No text message
      'user-email': FirebaseAuth.instance.currentUser?.email ?? 'No email',
      'date-time': DateTime.now().microsecondsSinceEpoch,
      'imageUrl': imageUrl, // URL of the uploaded image
    });
  }

  // Get all Message //
  Stream<QuerySnapshot<Object?>> get_messages() {
    final messageStream =
        messages.orderBy("date-time", descending: true).snapshots();
    return messageStream;
  }
}
