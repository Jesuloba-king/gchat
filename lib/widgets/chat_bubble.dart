import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isCurrentUser ? Color(0xffDEA531) : Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
