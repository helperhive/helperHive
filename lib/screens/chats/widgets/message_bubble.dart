import 'package:flutter/material.dart';
import 'package:helperhive/constants/utils.dart';
import 'package:helperhive/model/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isImage,
    required this.message,
  });

  final bool isMe;
  final bool isImage;
  final Message message;

  @override
  Widget build(BuildContext context) => Align(
        alignment: !isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: !isMe ? Colors.blue : Colors.grey,
            borderRadius: !isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
          ),
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment:
            //     isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isImage
                  ? GestureDetector(
                      onTap: () {
                        _showImageDialog(context, message.content);
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(message.content),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      message.content,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
              const SizedBox(height: 5),
              Text(
                textAlign: isMe ? TextAlign.right : TextAlign.left,
                DateTimeManager.formatDateTime(message.sentTime),
                // timeago.format(message.sentTime),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
