import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BottomChatForm extends StatelessWidget {
  const BottomChatForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              await FilePicker.platform.pickFiles(type: FileType.image);
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
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
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
