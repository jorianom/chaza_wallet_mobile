import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/infraestructure/models/user.dart';
import 'package:chaza_wallet/presentation/screens/edit_screen.dart';
import 'package:chaza_wallet/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    // idUser = authModel.userId;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/logo.png"),
          ),
        ),
        title: Text(
          'Perfil: ${authModel.username}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, size: 40),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('¿Quieres cerrar sesión?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sí'),
                        onPressed: () {
                          authModel.logout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginForm()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: const UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    if (authModel.user == null) {
      return Container();
    }
    DateTime fechaDateTime =
        DateTime.parse(authModel.user!.data!.getUser!.dateBirth!.toString());
    String fechaFormateada = fechaDateTime.toIso8601String().substring(0, 10);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.abc,
              size: 40,
            ),
            title: const Text(
              'Nombres: ',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Center(
              child: Text(
                authModel.user!.data!.getUser!.firstName!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Divider(),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.abc,
              size: 40,
            ),
            title: const Text(
              'Apellidos: ',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Center(
              child: Text(
                authModel.user!.data!.getUser!.lastName!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Divider(),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.abc,
              size: 40,
            ),
            title: const Text(
              'Cédula: ',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Center(
              child: Text(
                authModel.user!.data!.getUser!.documentNumber!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Divider(),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.abc,
              size: 40,
            ),
            title: const Text(
              'Celular: ',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Center(
              child: Text(
                authModel.user!.data!.getUser!.phone!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Divider(),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.abc,
              size: 40,
            ),
            title: const Text(
              'Fecha de Nacimiento: ',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Center(
              child: Text(
                fechaFormateada,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext contex) =>
                                const EditForm()));
                  },
                  child: Text(
                    "Editar",
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .redAccent[400], // Este es el color de fondo del botón
                  ),
                  onPressed: () async {},
                  child: Text(
                    "Borrar cuenta",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ],
    );
  }
}
