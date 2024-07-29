import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/message_service/firebase_msg_service.dart';
import 'package:helperhive/constants/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class ChatTextField extends StatefulWidget {
  // final User_Details user;
  final String receiverId;
  const ChatTextField({super.key, required this.receiverId});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController msgController = TextEditingController();
  Uint8List? file;
  void initstate() {
    super.initState();
  }

  // @override
  @override
  void dispose() {
    super.dispose();
    msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: msgController,
                  hintText: "Add Message..",
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.lightBlueAccent,
                radius: 20,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () => _sendText(context),
                  // onPressed: () {},
                ),
              ),
              const SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: Colors.lightBlueAccent,
                radius: 20,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: _sendImage,
                  // onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<void> _sendText(BuildContext context) async {
    if (msgController.text.isNotEmpty) {
      await FirebaseFirestoreServiceMessages.addTextMessage(
          content: msgController.text, receiverId: widget.receiverId);
      msgController.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _sendImage() async {
    // late Uint8List file;
    final pickimage = await pickImage(ImageSource.gallery);
    setState(() => file = pickimage);
    if (file != null) {
      await FirebaseFirestoreServiceMessages.addImageMessage(
          receiverId: widget.receiverId, file: file!);
    }
  }
}

//text field for the chats
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.onPressedSuffixIcon,
    this.obscureText,
    this.onChanged,
  });

  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final VoidCallback? onPressedSuffixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onPressedSuffixIcon,
                  icon: Icon(suffixIcon),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      );
}
