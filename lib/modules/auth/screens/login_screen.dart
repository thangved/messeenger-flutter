import 'package:flutter/material.dart';
import 'package:messeenger_flutter/providers/auth_provider.dart';
import 'package:messeenger_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";

  String _password = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FittedBox(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
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
                  Image.asset(
                    "assets/logo.png",
                    width: 50,
                  ),
                  Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Tên đăng nhập hoặc Email"),
                        hintText: "user",
                        border: InputBorder.none,
                      ),
                      onChanged: (username) {
                        this._username = username;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Mật khẩu"),
                        hintText: "******",
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                      onChanged: (password) {
                        this._password = password;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final response =
                              await AuthService.login(_username, _password);

                          context.read<AuthProvider>().accessToken =
                              response['tokens']['accessToken'];

                          Navigator.of(context).pushReplacementNamed('/');
                        } catch (error) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text(
                                        'Thất bại',
                                        style: TextStyle(
                                          fontSize: 24,
                                          height: 3,
                                        ),
                                      ),
                                      Text(error.toString())
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đóng'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text("Đăng nhập"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Bạn chưa có tài khoản?"),
                      InkWell(
                        child: Text(
                          "Đăng ký ngay",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/register');
                        },
                      )
                    ],
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/reset-password');
                    },
                    child: Text(
                      "Quên mật khẩu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
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
