import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  // final String receiverEmail;
  final String message;
  final String senderName;
  // final String receiverName;
  final Timestamp timestamp;

  Message(
      {
      //   required this.receiverEmail,
      required this.senderName,
      // required this.receiverName,
      required this.senderID,
      required this.senderEmail,
      required this.receiverID,
      required this.message,
      required this.timestamp});

  //map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
      // 'receiverEmail' : receiverEmail,
      // 'receiverName' : receiverName,
      'senderName': senderName,
    };
  }
}
