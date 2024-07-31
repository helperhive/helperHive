import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/message_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/message.dart';

import 'package:provider/provider.dart';

import '../widgets/chat_field.dart';
import '../widgets/message_bubble.dart';

class MessagesView extends StatefulWidget {
  final String uid;
  // final String userId;
  final Function(bool)? onBack;
  const MessagesView({
    super.key,
    required this.uid,
    this.onBack,
  });

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchMessages(widget.uid);
  }

  // @override
  // void didUpdateWidget(MessagesView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.uid != widget.uid) {
  //     WidgetsBinding.instance.addObserver(this);
  //     fetchMessages(widget.uid);
  //   }
  // }

  void fetchMessages(String userId) {
    Provider.of<MessageProvider>(context, listen: false).getUserById(userId);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: messageCardAppBar(widget.onBack),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(
                receiverId: widget.uid,
              ),
            ),
            // const Spacer(),
            // ChatTextField(),
          ],
        ),
      ),
      bottomNavigationBar: ChatTextField(
        receiverId: widget.uid,
      ),
    );
  }

  AppBar messageCardAppBar(Function(bool)? onBack) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          if (onBack != null) {
            onBack(false);
          }
          // onBack?.call(false);
          // Go back to the previous screen
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      automaticallyImplyLeading: true,
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: blueColor,
      title: Consumer<MessageProvider>(builder: (context, provider, child) {
        return provider.user != null
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    foregroundImage: provider.user!.profileUrl != ''
                        ? NetworkImage(provider.user!.profileUrl)
                        : null,
                    child: provider.user!.profileUrl == ''
                        ? Text(provider.user!.name[0])
                        : null,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.user!.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        provider.user!.service!.toService(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                ],
              )
            : const SizedBox();
      }),
    );
  }
}

class ChatMessages extends StatelessWidget {
  final String receiverId;
  const ChatMessages({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, provider, child) {
      return StreamBuilder<List<Message>>(
        stream: provider.fetchMessages(receiverId: receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyWidget(
                icon: Icons.waving_hand, text: 'Say Hello!');
          } else {
            final messages = snapshot.data!;
            return ListView.builder(
              controller: provider.scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isTextMessage =
                    messages[index].messageType == MessageType.text;
                final isMe = receiverId != messages[index].senderId;
                return isTextMessage
                    ? MessageBubble(
                        message: messages[index],
                        isMe: isMe,
                        isImage: false,
                      )
                    : MessageBubble(
                        message: messages[index],
                        isMe: isMe,
                        isImage: true,
                      );
              },
            );
          }
        },
      );
    });
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
}
