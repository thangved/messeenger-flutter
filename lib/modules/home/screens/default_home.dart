import 'dart:math';

import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/home/widgets/chat_user_list.dart';
import 'package:messeenger_flutter/modules/home/widgets/desktop_navigation.dart';
import 'package:messeenger_flutter/modules/home/widgets/main_chat.dart';

class DefaultHome extends StatelessWidget {
  const DefaultHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            DesktopNavigation(),
            ChatUserList(),
            MainChat(),
          ],
        ),
      ),
    );
  }
}
