import 'package:flutter/material.dart';
import 'package:gchat/widgets/buttons.dart';

import '../../utils/auth_service.dart';
import '../../utils/chat_service.dart';
import 'view_chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  //chat and atuh service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        title: GChatText(
          text: "Chats",
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        // foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Expanded(child: _userLiist()),
        ],
      ),
    );
  }

  //list of users
  Widget _userLiist() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return GChatText(text: "No user found");
          }

          //if loadinig
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GChatText(text: "Loadinig ...");
          }

          //return list of user
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _userListTile(userData, context))
                .toList(),
          );
        });
  }

  //individual list tile for user
  Widget _userListTile(Map<String, dynamic> userData, context) {
    //display all users except the current user

    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return ChatCard(
        name: userData['email'],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ViewChatPage(
                myuser: userData['displayName'].toString(),
                receiverEmail: userData['email'],
                receiverID: userData['uid']);
          }));
        },
      );
    }
    //
    else {
      return Container();
    }
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final void Function() onTap;

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: Colors.white)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                // height: 45,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xffE8C483), shape: BoxShape.circle),
                child: Center(
                  child: Text(initials,
                      // ${names[1][0]}
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GChatText(
                text: name,
                fontColor: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )
            ],
          )),
    );
  }
}
