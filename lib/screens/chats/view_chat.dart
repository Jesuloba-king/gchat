import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gchat/screens/chats/chats.dart';
import 'package:gchat/utils/auth_service.dart';
import 'package:gchat/utils/chat_service.dart';
import 'package:gchat/widgets/chat_bubble.dart';
import 'package:gchat/widgets/textfield.dart';

import '../../widgets/buttons.dart';

class ViewChatPage extends StatefulWidget {
  const ViewChatPage(
      {super.key,
      required this.myuser,
      required this.receiverEmail,
      required this.receiverID});

  final String receiverEmail, receiverID;
  final String myuser;

  @override
  State<ViewChatPage> createState() => _ViewChatPageState();
}

class _ViewChatPageState extends State<ViewChatPage> {
  final messageController = TextEditingController();

  //chat& auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //delay for keyboard to show and to scroll down
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  //send message
  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(
          widget.receiverID, messageController.text, widget.myuser);

      //clear textfield
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.white,
          leadingWidth: 50,
          surfaceTintColor: Colors.white,
          centerTitle: false,
          title: ChatCard2(name: widget.myuser ?? widget.receiverEmail)
          // foregroundColor: Colors.black,
          ),
      body: Column(children: [
        Expanded(
          child: _buildMessageList(),
        ),
        Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: _buildUserInput()),
      ]
          //display all messages

          ),
    );
  }

  //buuld message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          //
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  //message iitem
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to the right if sender is the current user, else left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    //
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
          ],
        ));
  }

  //message input
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: ChatTextField(
                controller: messageController, labelText: 'Type a message..')),

        //send button
        Container(
          decoration:
              BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: sendMessage,
              // color: Colors.grey,
              icon: Icon(
                Icons.send,
                color: Color(0xffDEA531),
              )),
        )
      ],
    );
  }
}

class ChatCard2 extends StatelessWidget {
  const ChatCard2({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    List<String> names =
        name.trim().split(' ').where((n) => n.isNotEmpty).toList();

    String initials = '';
    if (names.isNotEmpty) {
      initials = names[0][0].toUpperCase();
      if (names.length > 1) {
        initials += names[1][0].toUpperCase();
      }
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          // height: 45,
          // alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Color(0xffE8C483), shape: BoxShape.circle),
          child: Center(
            child: Text(initials,
                // ${names[1][0]}
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        GChatText(
          text: name,
          fontColor: Color(0xff333333),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}
