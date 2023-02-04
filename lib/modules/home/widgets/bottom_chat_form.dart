import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BottomChatForm extends StatelessWidget {
  const BottomChatForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
            onPressed: () async {},
            icon: Icon(
              Icons.add_circle_rounded,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () async {
              final result =
                  await FilePicker.platform.pickFiles(type: FileType.image);
            },
            icon: Icon(
              Icons.photo_rounded,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Aa',
                  border: InputBorder.none,
                ),
                autofocus: true,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send_rounded,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
