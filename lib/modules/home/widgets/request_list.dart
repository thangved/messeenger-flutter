import 'package:flutter/material.dart';
import 'package:messeenger_flutter/services/friend_service.dart';

import '../../../models/user_model.dart';

class RequestList extends StatelessWidget {
  const RequestList({super.key, required this.userList, required this.refresh});

  final List<UserModel> userList;
  final dynamic refresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                  color: Colors.black.withAlpha(20),
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].avatar),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userList[index].lastName} ${userList[index].firstName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '@${userList[index].username}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      await FriendService.acceptAddFriend(userList[index].id);
                      refresh();
                    } catch (error) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(error.toString()),
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline_outlined),
                  tooltip: 'Chấp nhận',
                )
              ],
            ),
          );
        },
        itemCount: userList.length,
      ),
    );
  }
}
