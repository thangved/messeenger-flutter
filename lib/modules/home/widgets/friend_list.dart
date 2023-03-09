import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/user_model.dart';

import '../../../services/friend_service.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key, required this.userList});

  final List<UserModel> userList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: double.maxFinite,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withAlpha(10),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          userList[index].avatar,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
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
                                  fontSize: 14,
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
                            if (await confirm(
                              context,
                              title: Text('Cảnh báo'),
                              content: Text(
                                  'Bạn chắc chắn muốn hủy kết bạn với ${userList[index].firstName}?'),
                              textOK: Text('Hủy kết bạn'),
                              textCancel: Text('Không'),
                            )) {
                              await FriendService.removeFriend(
                                  userList[index].id);
                            }
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(e.toString()),
                                );
                              },
                            );
                          }
                        },
                        icon: const Icon(Icons.person_remove),
                        tooltip: 'Hủy kết bạn',
                      ),
                    ],
                  ),
                );
              },
              itemCount: userList.length,
            ),
          );
        },
        itemCount: userList.length,
      ),
    );
  }
}
