import 'dart:convert';
import 'dart:io';
import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:chaza_wallet/presentation/screens/register_screen.dart';
import 'package:dio/io.dart';
import 'package:dio/src/adapter.dart';
import 'package:flutter/foundation.dart';

import 'package:chaza_wallet/infraestructure/models/errors_auth.dart';
import 'package:chaza_wallet/infraestructure/models/response_auth.dart';
import 'package:chaza_wallet/presentation/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iniciar sesión',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const FormLogin(),
    );
  }
}

class FormLogin extends StatefulWidget {
  const FormLogin({
    super.key,
  });

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool obs = true;
  bool value = false;
  AuthenticateUserAuth? auth;
  ErrorsAuth? authErr;
  String error = "";

  Future<String?> submitData(String user, String pass) async {
    try {
      String url;
      if (kIsWeb) {
        url = "https://localhost:82/graphql";
      } else {
        url = "http://10.0.2.2:81/graphql";
      }
      var response = await DioClient.instance.post(url, data: {
        'query': '''
            mutation {
            authenticateUserAuth(
                username: "$user"
                password: "$pass"
            ) {
                ok
                token
            }
        }
          '''
      });
      print(response.data);
      // print(response);
      auth = AuthenticateUserAuth.fromJson((response.data));
      setState(() {});

      if (auth?.data!.authenticateUserAuth?.token != null) {
        // authModel.login(auth?.data!.authenticateUserAuth?.token);
        return auth?.data!.authenticateUserAuth?.token;
      } else {
        authErr = ErrorsAuth.fromJson((response.data));
        setState(() {
          error = authErr!.errors![0].message!;
        });
        return "";
      }
    } catch (e) {
      print('Something really unknown: $e');
      setState(() {
        error = 'Something really unknown: $e';
      });
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                )),
            const Text(
              "Bienvenido a Chaza Wallet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 15),
            error != ""
                ? Text(
                    'Error: $error',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
            TextFormField(
              controller: userController,
              decoration: const InputDecoration(labelText: 'Usuario'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: obs,
              controller: passController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obs == true ? obs = false : obs = true;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext contex) =>
                                  const RegisterForm()));
                    },
                    child: const Text("¿Aun no tienes cuenta?")),
                TextButton(
                    onPressed: () {},
                    child: const Text("¿Olvidaste tu contraseña?"))
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? token = await submitData(
                        userController.text, passController.text);
                    if (token != "") {
                      DioClient().setToken(token!);
                      authModel.login(token);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext contex) =>
                                  const HomeScreen()));
                    }
                  }
                },
                child: const Text("Inciar Sesión"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
