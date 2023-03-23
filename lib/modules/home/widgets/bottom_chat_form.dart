import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:messeenger_flutter/providers/chat_provider.dart';
import 'package:messeenger_flutter/services/message_service.dart';
import 'package:messeenger_flutter/services/upload_service.dart';
import 'package:provider/provider.dart';

class BottomChatForm extends StatefulWidget {
  const BottomChatForm({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomChatForm> createState() => _BottomChatFormState();
}

class _BottomChatFormState extends State<BottomChatForm> {
  String _messageText = "";

  final textField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatId = context.read<ChatProvider>().chatId;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.black.withAlpha(20),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              final result =
                  await FilePicker.platform.pickFiles(type: FileType.image);

              final res = await UploadService.upload(result?.files.single);

              await MessageService.sendMessage(
                groupId: chatId,
                url: res.fileUrl,
                type: 'file',
              );
            },
            icon: const Icon(
              Icons.photo_rounded,
              color: Colors.blue,
            ),
            tooltip: 'Chọn ảnh',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Aa',
                  border: InputBorder.none,
                ),
                autofocus: true,
                onChanged: (text) {
                  _messageText = text;
                },
                controller: textField,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await MessageService.sendMessage(
                  groupId: context.read<ChatProvider>().chatId,
                  content: _messageText,
                );
              } catch (error) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(error.toString()),
                      );
                    });
              } finally {
                textField.clear();
              }
            },
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
