import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
      body: FormLogin(
          formKey: _formKey,
          usernameController: _usernameController,
          passwordController: _passwordController),
    );
  }
}

class FormLogin extends StatefulWidget {
  const FormLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool obs = true;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
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
            TextFormField(
              controller: widget._usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              obscureText: obs,
              controller: widget._passwordController,
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
                    onPressed: () {},
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
                onPressed: () {},
                child: const Text("Inciar Sesión"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
