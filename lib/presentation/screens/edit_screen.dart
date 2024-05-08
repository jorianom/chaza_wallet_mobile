import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/infraestructure/models/post_user.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:chaza_wallet/presentation/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:chaza_wallet/infraestructure/models/errors_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const FormEdit(),
    );
  }
}

class FormEdit extends StatefulWidget {
  const FormEdit({
    super.key,
  });

  @override
  State<FormEdit> createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool obs = true;
  bool value = false;
  PostUsers? postuser;
  ErrorsAuth? authErr;
  String error = "";

  Future<String?> submitData(String user, String pass, String name,
      String lastname, String phone, String number, String date) async {
    try {
      String url;
      if (kIsWeb) {
        url = "https://localhost:82/graphql";
      } else {
        url = "http://10.0.2.2:81/graphql";
      }
      var response = await DioClient.instance.post(url, data: {
        'query': '''
            mutation{
            postUsers(
              firstName:"$name",
              lastName: "$lastname",
              dateBirth:"$date",
              role:"User",
              phone:"$phone",
              documentType: "cedula",
              documentNumber:"$number", 
              password: "$pass", 
              username:"$user")
            {
              ok
              user{
                id
                firstName
              }
            }
          }
          '''
      });
      print(response.data);
      // print(response);
      postuser = PostUsers.fromJson((response.data));
      setState(() {});

      if (postuser!.data!.postUsers != null) {
        // authModel.login(auth?.data!.authenticateUserAuth?.token);
        // return auth?.data!.authenticateUserAuth?.token;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext contex) => const LoginForm()));
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
            const SizedBox(height: 10),
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
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombres'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            TextFormField(
              controller: lastnameController,
              decoration: const InputDecoration(labelText: 'Apellidos'),
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
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Volver",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await submitData(
                              userController.text,
                              passController.text,
                              nameController.text,
                              lastnameController.text,
                              phoneController.text,
                              numberController.text,
                              dateController.text);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext contex) =>
                                    const EditForm()));
                      },
                      child: Text(
                        "Editar",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
