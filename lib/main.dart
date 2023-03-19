import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messeenger_flutter/modules/auth/screens/login_screen.dart';
import 'package:messeenger_flutter/modules/auth/screens/register_screen.dart';
import 'package:messeenger_flutter/modules/auth/screens/reset_password.dart';
import 'package:messeenger_flutter/modules/home/screens/default_home.dart';
import 'package:messeenger_flutter/providers/auth_provider.dart';
import 'package:messeenger_flutter/providers/chat_provider.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  socket.connect();
  socket.onConnect((_) {
    print('Socket is connected');
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messeenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      routes: {
        '/': (context) => context.watch<AuthProvider>().logged
            ? const DefaultHome()
            : const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
      },
    );
  }
}
