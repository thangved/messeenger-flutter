import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/message_model.dart';
import 'package:messeenger_flutter/services/message_service.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onLongPress: () async {
              if (message.deletedAt != null) return;
              if (await confirm(
                context,
                title: const Text('Thu hồi tin nhắn'),
                content: const Text('Bạn muốn thu hồi tin nhắn này?'),
              )) {
                await MessageService.delete(message.id);
              }
            },
            child: Column(
              children: [
                message.deletedAt != null
                    ? const DeletedMessage()
                    : message.type == 'text'
                        ? Container(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              message.content,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ImageMessage(message: message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OtherUserMessage extends StatelessWidget {
  const OtherUserMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(message.createdBy.avatar),
            radius: 16,
          ),
          InkWell(
            onLongPress: () {},
            child: message.deletedAt != null
                ? const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DeletedMessage(),
                  )
                : message.type == 'text'
                    ? Container(
                        margin: const EdgeInsets.only(left: 5),
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message.content,
                        ),
                      )
                    : ImageMessage(message: message),
          )
        ],
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        message.url ?? '',
        width: 240,
      ),
    );
  }
}

class DeletedMessage extends StatelessWidget {
  const DeletedMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Text('Tin nhắn này đã bị xóa'),
    );
  }
}
