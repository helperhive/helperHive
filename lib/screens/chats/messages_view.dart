import 'package:flutter/material.dart';
import 'package:helperhive/model/user_model.dart';

class MessagesView extends StatefulWidget {
  final UserModel user;
  const MessagesView({super.key, required this.user});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
