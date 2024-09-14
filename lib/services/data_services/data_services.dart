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

   //delete
 Future<bool>  deleteMessage (String docId,) async{
   await messages.doc(docId).delete();
   return true;
  }

  // Get all Message //
  Stream<QuerySnapshot<Object?>> get_messages() {
    final messageStream =
        messages.orderBy("date-time", descending: true).snapshots();
    return messageStream;
  }
}


/// ------------- Checking OwnserShip For Query ------------- ///
// Future<bool> deleteMessage(String docID) async {
//   try {
//     // Fetch the message document to check ownership
//     DocumentSnapshot messageDoc = await messages.doc(docID).get();
//     Map<String, dynamic> messageData = messageDoc.data() as Map<String, dynamic>;

//     // Check if the current user is the owner of the message
//     if (messageData['user-email'] == auth.currentUser!.email) {
//       await messages.doc(docID).delete();
//       return true; // Return true if the deletion is successful
//     } else {
//       return false; // Return false if the user is not authorized
//     }
//   } catch (e) {
//     print("Error deleting message: $e");
//     return false; // Return false if there was an error
//   }
// }
