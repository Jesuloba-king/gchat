import 'package:flutter/material.dart';

import '../utils/chat_service.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      required this.messageId,
      required this.userId});

  final String message, messageId, userId;
  final bool isCurrentUser;

  //show options

  void _showOptions(context, String messageId, String userId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                //report button
                ListTile(
                    leading: Icon(Icons.flag),
                    title: Text('Report'),
                    onTap: () {
                      Navigator.pop(context);
                      _reportMessage(context, messageId, userId);
                    }),

                //block user button
                ListTile(
                    leading: Icon(Icons.block),
                    title: Text('Block User'),
                    onTap: () {
                      Navigator.pop(context);
                      _blockUser(context, userId);
                    }),

                //cancel button
                ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text('Cancel'),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  //report message
  void _reportMessage(context, String messageId, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Report Message"),
              content: Text("Are you sure you want to report this message?"),
              actions: [
                //cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),

                //report
                TextButton(
                  onPressed: () {
                    ChatService().reportUser(messageId, userId);
                    Navigator.pop(context);
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Message Reported")));
                  },
                  child: Text("Report"),
                ),
              ],
            ));
  }

  //block user
  void _blockUser(context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Block User"),
              content: Text("Are you sure you want to block this user?"),
              actions: [
                //cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),

                //report
                TextButton(
                  onPressed: () {
                    ChatService().blockUser(userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("User Blocked!")));
                  },
                  child: Text("Block"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (!isCurrentUser) {
          //options
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
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
      ),
    );
  }
}
