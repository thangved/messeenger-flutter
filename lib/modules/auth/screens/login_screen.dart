import 'package:flutter/material.dart';
import 'package:messeenger_flutter/providers/auth-provider.dart';
import 'package:messeenger_flutter/services/auth-service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  String _username = "";
  String _password = "";

  LoginScreen({super.key});

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
                        } catch (error) {
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
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/register');
                        },
                      )
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
