import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'role_manager.dart'; // ✅ For checking user role
import 'chat_page.dart';

class ChatListPage extends StatelessWidget {
  final bool isClient;

  const ChatListPage({super.key, required this.isClient}); // ✅ Make sure this exists

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {
        "name": isClient ? "K Ruthwick (Driver)" : "Client: M Karthikeya",
        "lastMessage": "",
        "time": "11:30 AM"
      },

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isClient ? "Your Professionals" : "Your Clients",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF123458),
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];

          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              chat['name']!,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              chat['lastMessage']!,
              style: GoogleFonts.poppins(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chat['time']!,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatPage(
                    isClient: isClient,
                    participantName: chat['name']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
