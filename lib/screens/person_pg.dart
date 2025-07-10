import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:gchat/auth/login.dart';
import 'package:gchat/utils/auth_service.dart';
import 'package:gchat/utils/colors.dart';

import '../utils/chat_service.dart';
import '../widgets/buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  // Logout function
  void logout() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _authService.getCurrentUser();

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        title: GChatText(
          text: "Profile",
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _chatService.getUsersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return GChatText(text: "Error loading users");
            }

            if (!snapshot.hasData) {
              return GChatText(text: "Loading...");
            }

            final users = snapshot.data!;
            final currentUser = _authService.getCurrentUser();

            // Find the current user from the user list
            final currentUserData = users.firstWhere(
              (user) => user['email'] == currentUser?.email,
              orElse: () => {},
            );

            if (currentUserData.isEmpty) {
              return GChatText(text: "Current user not found");
            }

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: _userListTile(currentUserData, context),
                ),
                TextButton(
                  onPressed: logout,
                  child: GChatText(
                    text: "Logout",
                    fontColor: AppColors.appThemeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _userListTile(Map<String, dynamic> userData, context) {
    List<String> names = userData['displayName']?.trim().split(' ') ?? [];
    String initials = names.isNotEmpty ? names[0][0].toUpperCase() : '';
    if (names.length > 1) initials += names[1][0].toUpperCase();

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color(0xffE8C483),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GChatText(
                text: userData['displayName'] ?? 'No name',
                fontColor: const Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 8),
              GChatText(
                text: userData['email'] ?? '',
                fontColor: const Color(0xff666666),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
