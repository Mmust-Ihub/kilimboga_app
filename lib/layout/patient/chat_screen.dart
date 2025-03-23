import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/layout/patient/single_chat_screen.dart';
import 'package:kilimboga/provider/messaging_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<MessagingProvider>(
            builder: (BuildContext context, MessagingProvider provider,
                Widget? child) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Recent Chats",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Container(
                            width: double.infinity,
                            color: Colors.grey.shade100,
                            child: const Center(
                              child: Text("No scheduled appointments"),
                            ),
                          );
                        }

                        var chatData = snapshot.data!.docs
                            .map((doc) {
                              var data = doc.data() as Map<String, dynamic>;
                              return {
                                'id': doc.id,
                                'participants': data['participants'] ?? [],
                                'messages': data['messages'] ?? [],
                                "tokens": data["tokens"] ?? [],
                              };
                            })
                            .where((chat) => chat['participants']
                                .any((p) => p['id'] == user!.id))
                            .toList();

                        return ListView.separated(
                          itemCount: chatData.length,
                          itemBuilder: (context, index) {
                            return _buildChatItem(context, chatData[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic>? getOtherParticipant(List participants) {
  return participants.firstWhere((p) => p['id'] != user!.id,
      orElse: () => null);
}

Widget _buildChatItem(BuildContext context, Map chat) {
  var otherParticipant = getOtherParticipant(chat['participants']);
  String otherName = otherParticipant?['name'] ?? "Unknown User";
  String chatroomid = chat['id'];

  var messages = chat['messages'];
  var lastMessage = messages.isNotEmpty ? messages.last : null;
  String lastMessageText = lastMessage?['message'] ?? "";
  String lastMessageTime = lastMessage?['timestamp'] != null
      ? DateFormat('h:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(lastMessage['timestamp'].toString())))
          .toString()
      : "";

  return ListTile(
    title: Text(otherName, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(lastMessageText),
    tileColor: Colors.grey.shade300,
    trailing: Text(lastMessageTime),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SIngleChatScreen(
            name: otherName,
            id: otherParticipant?['id'],
            chatroomid: chatroomid,
            tokens: otherParticipant?['tokens'],
            phone: otherParticipant?['phone'],
          ),
        ),
      );
    },
  );
}
