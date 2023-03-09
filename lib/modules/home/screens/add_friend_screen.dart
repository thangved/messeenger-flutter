import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:messeenger_flutter/services/user_service.dart';

import '../../../models/user_model.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final _debouncer =
      Debouncer<String>(const Duration(milliseconds: 500), initialValue: '');
  List<UserModel> _userList = [];
  bool _searched = true;

  @override
  void initState() {
    _debouncer.values.listen((event) async {
      final res = await UserService.find(_debouncer.value);

      setState(() {
        _userList = res;
        _searched = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gửi yêu cầu kết bạn"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 360,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        label: Text('Nhập email hoặc tên người dùng'),
                        hintText: "spiderman",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _searched = false;
                        });
                        _debouncer.value = text;
                      },
                    ),
                  ),
                  _searched
                      ? Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                        _userList[index].avatar,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${_userList[index].lastName} ${_userList[index].firstName}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            Text(
                                              '@${_userList[index].username}',
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
                                      onPressed: () {},
                                      icon: const Icon(Icons.person_add),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: _userList.length,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
