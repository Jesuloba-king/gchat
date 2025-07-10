import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'model/message_model.dart';

class ChatService extends ChangeNotifier {
  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get all users
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //check through avvailable users
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  //get all users stream except blocked users
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;

    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      //get blocked iids
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      //get all users
      final userSnapshot = await _firestore.collection('Users').get();

      //return list, except current user and blocked users
      return userSnapshot.docs
          .where((doc) =>
              doc.data()['email'] != currentUser.email &&
              !blockedUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message, username) async {
    //get current user info

    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final String username = _auth.currentUser?.displayName ?? "";
    final Timestamp timestamp = Timestamp.now();

    //create message
    Message newMessage = Message(
      // receiverEmail: '',
      senderName: username,
      // receiverName: '',
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //chat room ID for the two users..sorted
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort chatroomsID is the same
    String chatRoomID = ids.join('_');

    //add new meesage to db
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //chatrroom ID for two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

//report user
  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection("Reports").add(report);
  }

  // block user
  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .doc(userId)
        .set({});

    notifyListeners();
  }

  //unblock user
  Future<void> unblockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .doc(userId)
        .delete();
  }

  //get blocked users
  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userID) {
    return _firestore
        .collection('Users')
        .doc(userID)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap((snapshot) async {
      //list of blocked user ids
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      //
      final userDocs = await Future.wait(blockedUserIds
          .map((id) => _firestore.collection('Users').doc(id).get()));

      //return as list
      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
