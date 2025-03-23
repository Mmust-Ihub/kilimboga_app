import 'dart:convert';

import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/data/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kilimboga/data/constants.dart';

class MessagingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ChatRoom> _chatrooms = [];
  List<ChatRoom> get chatrooms => _chatrooms;
  bool _sent = false;

  bool get sent => _sent;

  Future<String> sendMessage(String nurseId, String message) async {
    debugPrint("sending Message");
    Message newMessage = Message(receiverId: nurseId, message: message);

    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/chat/users"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer ${user!.token!}",
        },
        body: jsonEncode(newMessage.toMap()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());

        return data["chatid"];
      } else {
        throw Exception("Failed to send message: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error sending message: $e");
      return "";
    }
  }

  Stream<List<DisplayMessage>> getMessages(String chatroomId) {
    return _firestore
        .collection("chats")
        .doc(chatroomId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        var chatData = snapshot.data() as Map<String, dynamic>;

        List messagesList = chatData["messages"] ?? [];

        return messagesList
            .map((msg) => DisplayMessage(
                  senderid: msg["senderid"] ?? "",
                  message: msg["message"] ?? "",
                ))
            .toList();
      } else {
        return [];
      }
    });
  }

  Future<void> fetchChatrooms() async {
    debugPrint("fetching chats");
    try {
      QuerySnapshot chatroomsSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('participants', arrayContains: user!.id)
          .get();

      debugPrint(chatroomsSnapshot.toString());

      _chatrooms = chatroomsSnapshot.docs
          .map((doc) => ChatRoom.fromFirestore(doc))
          .toList();

      debugPrint(chatrooms.toString());

      notifyListeners();
    } catch (error) {
      debugPrint("Error fetching chatrooms: $error");
    }
  }

  Future<void> sendMessage2(String message, String receiverid,
      String receiverName, List tokens, String? phone) async {
    _sent = false;
    notifyListeners();
    if (message.trim().isEmpty) return;

    List<String> sortedIds = [user!.id, receiverid]..sort();

    String chatroomId = sortedIds.join("_");

    try {
      DocumentReference chatRef =
          _firestore.collection("chats").doc(chatroomId);

      DocumentSnapshot chatSnap = await chatRef.get();
      if (!chatSnap.exists) {
        await chatRef.set({
          "messages": [
            {
              "message": message,
              "senderid": user!.id,
              "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
            }
          ],
          "participants": [
            {
              "id": user!.id,
              "name": "${user!.firstName} ${user!.lastName}",
              "tokens": fcm != null ? [fcm] : [],
              "phone": "unkown"
            },
            {
              "id": receiverid,
              "name": receiverName,
              "tokens": tokens,
              "phone": phone,
            }
          ],
          "participantsId": [user!.id, receiverid],
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
        });

        _sent = true;
        notifyListeners();

        sendPushNotification(tokens, user!.firstName, message);
      } else {
        _sent = true;
        notifyListeners();
        await chatRef.update({
          "messages": FieldValue.arrayUnion([
            {
              "message": message,
              "senderid": user!.id,
              "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
            }
          ]),
        });

        sendPushNotification(tokens, user!.firstName, message);

        List<Map<String, dynamic>> updatedParticipants = [];
        List<dynamic> existingParticipants = chatSnap["participants"];

        for (var participant in existingParticipants) {
          if (participant["id"] == user!.id) {
            List<String> userTokens =
                List<String>.from(participant["tokens"] ?? []);

            if (fcm != null && !userTokens.contains(fcm)) {
              userTokens.add(fcm!);
            }

            participant["tokens"] = userTokens;
          } else if (participant["id"] == receiverid) {
            participant["tokens"] = tokens;
          }
          updatedParticipants.add(participant);
        }
        await chatRef.update({
          "participants": updatedParticipants,
        });
      }
    } catch (e) {
      debugPrint("Error sending message: $e");
    }
  }

  Future<void> sendPushNotification(
      List tokens, String title, String body) async {
    String fcmServerKey = dotenv.env['SERVER_KEY']!;
    const String expoPushURL = "https://exp.host/--/api/v2/push/send";

    RegExp expoRegex = RegExp(r'^ExponentPushToken\[[a-zA-Z0-9_-]+\]$');

    for (String token in tokens) {
      if (expoRegex.hasMatch(token)) {
        final Map<String, dynamic> expoData = {
          "to": token,
          "title": title,
          "body": body,
          "sound": "default",
          "priority": "high",
        };

        try {
          await http.post(
            Uri.parse(expoPushURL),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(expoData),
          );
        } catch (error) {
          debugPrint("Expo Error: $error");
        }
        continue;
      }

      final Map<String, dynamic> fcmData = {
        "to": token,
        "notification": {
          "title": title,
          "body": body,
        },
        "priority": "high",
      };

      try {
        await http.post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "key=$fcmServerKey",
          },
          body: jsonEncode(fcmData),
        );
      } catch (error) {
        debugPrint("FCM Error: $error");
      }
    }
  }
}
