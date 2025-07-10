import 'package:flutter/material.dart';

import '../../utils/auth_service.dart';
import '../../utils/chat_service.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/buttons.dart';
import '../chats/chats.dart';

class BlockedUserPage extends StatelessWidget {
  BlockedUserPage({super.key});

//chat and atuh service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //dialog for unblock
  void _showUnblockBox(context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Unblock User"),
              content: Text("Are you sure you want to unblock this user?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),

                //report
                TextButton(
                  onPressed: () {
                    _chatService.unblockUser(userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User unblocked")));
                  },
                  child: Text("Unblock"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    String userId = _authService.getCurrentUser()!.uid;
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        title: GChatText(
          text: "Blocked Users",
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        // foregroundColor: Colors.black,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _chatService.getBlockedUsersStream(userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error loadinig .."),
              );
            }

            //loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: AppLoader(),
              );
            }

            //
            final blockedUsers = snapshot.data ?? [];

//no users
            if (blockedUsers.isEmpty) {
              return Center(child: Text("No blocked Users!!"));
            }

            //complete loading
            return ListView.builder(
                itemCount: blockedUsers.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final user = blockedUsers[index];
                  return ChatCard(
                    name: user['displayName'].toString().isNotEmpty
                        ? user['displayName']
                        : user['email'],
                    onTap: () => _showUnblockBox(context, user['uid']),
                  );
                });
          }),
    );
  }
}
