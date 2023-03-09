import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/home/widgets/user_info.dart';

import 'bottom_chat_form.dart';
import 'message_list.dart';

class MainChat extends StatelessWidget {
  const MainChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withAlpha(30)),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            appBar: AppBar(
              title: const MainChatTitle(),
            ),
            body: const MainChatBody(),
            backgroundColor: Colors.blue.withAlpha(10),
          ),
        ),
      ),
    );
  }
}

class MainChatTitle extends StatelessWidget {
  const MainChatTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            'https://yt3.ggpht.com/-4q2Qv2ST2eeXf4ZiNDQ-h7FZURUMaB8-h_mD6z0hJypffploao8K9Kj_wZhPgbtcWCdr1j8=s88-c-k-c0x00ffffff-no-rj-mo',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kim Minh Thắng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@thangved',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainChatBody extends StatelessWidget {
  const MainChatBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              MessageList(),
              BottomChatForm(),
            ],
          ),
        ),
        UserInfo()
      ],
    );
  }
}
