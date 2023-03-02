import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/home/widgets/chat_user_list.dart';
import 'package:messeenger_flutter/services/chat_group_service.dart';

class ChatUserScreen extends StatefulWidget {
  const ChatUserScreen({super.key});

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.black.withAlpha(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tin nhắn',
              style: TextStyle(
                fontSize: 20,
                height: 2,
              ),
            ),
            Flexible(
              flex: 1,
              child: FutureBuilder(
                future: ChatGroupService.getAll(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return snapshot.hasData
                      ? ChatUserList(chatList: snapshot.data)
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
