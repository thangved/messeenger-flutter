
import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({
    Key? key,
  }) : super(key: key);

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
            onLongPress: () {},
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Ê đâu rồi',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OtherUserMessage extends StatelessWidget {
  const OtherUserMessage({
    Key? key,
  }) : super(key: key);

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
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://yt3.ggpht.com/-4q2Qv2ST2eeXf4ZiNDQ-h7FZURUMaB8-h_mD6z0hJypffploao8K9Kj_wZhPgbtcWCdr1j8=s88-c-k-c0x00ffffff-no-rj-mo',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onLongPress: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Đây nè bà',
              ),
            ),
          )
        ],
      ),
    );
  }
}