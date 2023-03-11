import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/message_model.dart';
import 'package:messeenger_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'message_item.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: messages.map((e) {
            if (e.createdBy.id == context.read<AuthProvider>().currentUser.id) {
              return MyMessage(
                message: e,
              );
            }
            return OtherUserMessage(
              message: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
