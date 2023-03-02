import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  int _chatIndex = -1;

  get chatIndex => _chatIndex;

  set chatIndex(index) {
    _chatIndex = index;
    notifyListeners();
  }
}
