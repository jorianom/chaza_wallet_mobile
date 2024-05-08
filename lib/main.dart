// import 'package:chaza_wallet/presentation/screens/counter_screen.dart';
import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/presentation/screens/home_screen.dart';
import 'package:chaza_wallet/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthModel())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          home: Consumer<AuthModel>(builder: (_, authModel, __) {
            return authModel.isAuthenticate
                ? const HomeScreen()
                : const LoginForm();
          })),
    );
  }
}
