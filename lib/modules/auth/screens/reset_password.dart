import 'package:flutter/material.dart';
import 'package:messeenger_flutter/services/auth_service.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  String _email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FittedBox(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              width: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20),
                ],
              ),
              child: Column(
                children: [
                  AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                      tooltip: 'Quay lại đăng nhập',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    width: 50,
                  ),
                  const Text(
                    "Đặt lại mật khẩu",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 3,
                    ),
                  ),
                  const Text(
                      'Vui lòng nhập địa chỉ email mà bạn đã sử dụng để đăng ký tài khoản'),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: "spiderman@marvel.com",
                        border: InputBorder.none,
                      ),
                      onChanged: (email) {
                        _email = email;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final res =
                              await AuthService.resetPassword(email: _email);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: AlertDialog(
                                    content: ListBody(
                                      children: [
                                        const Text(
                                          'Thành công',
                                          style: TextStyle(
                                            fontSize: 24,
                                            height: 3,
                                          ),
                                        ),
                                        Text(res['message']),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Đóng'),
                                      )
                                    ],
                                  ),
                                );
                              });
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: AlertDialog(
                                    content: ListBody(
                                      children: [
                                        const Text(
                                          'Thất bại',
                                          style: TextStyle(
                                            fontSize: 24,
                                            height: 3,
                                          ),
                                        ),
                                        Text(e.toString()),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Đóng'),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                      child: const Text('Xác nhận'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
