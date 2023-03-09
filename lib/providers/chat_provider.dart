import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  String? _chatId;

  get chatId => _chatId;

  set chatId(id) {
    _chatId = id;
    notifyListeners();
  }
}
