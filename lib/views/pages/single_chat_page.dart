import 'package:kilimboga/data/constants.dart';
import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/provider/messaging_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SIngleChatPage extends StatefulWidget {
  final String name;
  final String id;
  final String chatroomid;
  final List tokens;
  final String? phone;
  const SIngleChatPage(
      {super.key,
      required this.name,
      required this.id,
      required this.chatroomid,
      required this.tokens,
      this.phone});

  @override
  State<SIngleChatPage> createState() => _SIngleChatPageState();
}

class _SIngleChatPageState extends State<SIngleChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  List<DisplayMessage> messages = [];

  late String chatroomId;

  @override
  void initState() {
    super.initState();

    List<String> sortedIds = [user!.id, widget.id]..sort();

    chatroomId = sortedIds.join("_");
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<MessagingProvider>(
            builder: (BuildContext context, MessagingProvider provider,
                Widget? child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.support_agent, color: Colors.blue),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            await provider.sendPushNotification(widget.tokens,
                                user!.firstName, "New notification");
                          },
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (widget.phone != null)
                          IconButton(
                            onPressed: () {
                              makingPhoneCall(widget.phone!);
                            },
                            icon: const Icon(
                              Icons.call_outlined,
                              color: Colors.blue,
                            ),
                          )
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildMessageList(context),
                  ),
                  _buildMessageInput(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return StreamBuilder<List<DisplayMessage>>(
      stream: Provider.of<MessagingProvider>(context, listen: false)
          .getMessages(chatroomId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        messages = snapshot.data!;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });

        return ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return _buildMessage(messages[index]);
          },
        );
      },
    );
  }

  Widget _buildMessage(DisplayMessage message) {
    bool isMe = message.senderid == user!.id;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<MessagingProvider>(
        builder:
            (BuildContext context, MessagingProvider provider, Widget? child) {
          if (provider.sent) {
            _messageController.clear();
          }
          return Row(
            children: [
              Expanded(
                child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        )),
                    onSubmitted: (_) async {
                      if (_messageController.text.trim().isNotEmpty) {
                        messages.add(DisplayMessage(
                            senderid: user!.id,
                            message: _messageController.text));
                        setState(() {});

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });
                        await provider.sendMessage2(
                            _messageController.text,
                            widget.id,
                            widget.name,
                            widget.tokens,
                            widget.phone);
                      }
                    }),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                color: Colors.blueAccent,
                onPressed: () async {
                  if (_messageController.text.trim().isNotEmpty) {
                    messages.add(DisplayMessage(
                        senderid: user!.id, message: _messageController.text));
                    setState(() {});

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });

                    provider.sendMessage2(_messageController.text, widget.id,
                        widget.name, widget.tokens, widget.phone);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
