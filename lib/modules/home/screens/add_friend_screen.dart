import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:messeenger_flutter/modules/home/widgets/chat_user_list.dart';
import 'package:messeenger_flutter/services/user_service.dart';

import '../../../models/user_model.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final _debouncer =
      Debouncer<String>(Duration(milliseconds: 500), initialValue: '');
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
        title: Text("Gửi yêu cầu kết bạn"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 360,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
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
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return ChatUserItem(
                              img: _userList[index].avatar,
                              name: _userList[index].firstName,
                              lastMessage: "",
                              onTap: () {},
                            );
                          },
                          itemCount: _userList.length,
                        )
                      : Center(
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
