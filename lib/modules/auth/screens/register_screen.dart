import 'package:flutter/material.dart';
import 'package:messeenger_flutter/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _firstName = "";

  String _lastName = "";

  String _email = "";

  String _username = "";

  String _password = "";

  String _confirmPassword = "";

  bool _success = false;

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
              child: _success
                  ? Column(
                      children: [
                        const Center(
                          child: Icon(
                            Icons.mail,
                            color: Colors.grey,
                            size: 36,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Vui lòng kiểm tra email của bạn để kích hoạt tài khoản ($_email)',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Quay lại trang đăng nhập'),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: 50,
                        ),
                        const Text(
                          "Đăng ký",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 3,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Họ"),
                              hintText: "Parker",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              _lastName = text;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Tên"),
                              hintText: "Peter",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              _firstName = text;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "spiderman@maverl.com",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              _email = text;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Tên đăng nhập"),
                              hintText: "spiderman",
                              prefix: Text('@'),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              _username = text;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Mật khẩu"),
                              hintText: "******",
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                            onChanged: (text) {
                              _password = text;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Nhập lại mật khẩu"),
                              hintText: "******",
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                            onChanged: (text) {
                              _confirmPassword = text;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await AuthService.register(
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  email: _email,
                                  username: _username,
                                  password: _password,
                                );

                                setState(() {
                                  _success = true;
                                });
                              } catch (error) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            const Text(
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
                                          child: const Text('Đóng'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Đăng ký"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text("Bạn đã có tài khoản?"),
                            InkWell(
                              child: const Text(
                                "Đăng nhập ngay",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              },
                            )
                          ],
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
