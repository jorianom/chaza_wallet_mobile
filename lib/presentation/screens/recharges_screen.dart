import 'package:chaza_wallet/infraestructure/models/methods.dart';
import 'package:chaza_wallet/infraestructure/models/post_recharges.dart';
import 'package:chaza_wallet/presentation/screens/home_screen.dart';
import 'package:chaza_wallet/presentation/screens/methods_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class RechargesScreen extends StatelessWidget {
  const RechargesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recarga tu billetera ...',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const FormRecharges(),
    );
  }
}

class FormRecharges extends StatefulWidget {
  const FormRecharges({
    super.key,
  });

  @override
  State<FormRecharges> createState() => _FormRechargesState();
}

class _FormRechargesState extends State<FormRecharges> {
  Methods? methods;
  PostRecharge? recharge;
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;
  String error = "";
  String message = "";
  TextEditingController userController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController methodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMethods();
  }

  Future<void> getMethods() async {
    final response = await Dio().post("http://127.0.0.1:8000/graphql", data: {
      'query': '''
            {
                getMethods(id: 9746498) {
                    id
                    name
                }
            }
          '''
    });
    methods = Methods.fromJson(response.data);
    setState(() {});
  }

  Future<void> submitData(
      String user, String amount, String method, String date) async {
    String url;
    DateTime ahora = DateTime.now().toUtc();
    String formateado =
        DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'').format(ahora);
    String mutation = """
    mutation {
      postRecharge(
        user: "9746498",
        amount: "$amount",
        method: "$method"
        date: "$formateado",
      ) {
        ok
        response{
          message
        }
      }
    }
  """;
    //https://chaza-wallet-ag-ithgocyoua-uc.a.run.app/graphql
    // print(mutation);

    if (kIsWeb) {
      // Some web specific code there
      url = "http://127.0.0.1:8000/graphql";
    } else {
      // Some android/ios specific code
      url = "http://10.0.2.2:8000/graphql";
    }
    final response = await Dio().post(
      url,
      data: {"query": mutation},
    );
    recharge = PostRecharge.fromJson(response.data);
    // print(recharge?.data?.postRecharge?.ok);
    if (recharge != null) {
      if (recharge?.data?.postRecharge!.ok == true) {
        message = "Tu recarga esta en proceso ...";
      } else {
        error = "Tu recarga esta en proceso ...";
      }
    } else {
      error = "Tu recarga esta en proceso ...";
    }
    setState(() {});
    Future.delayed(const Duration(seconds: 3), () {
      error = "";
      message = "";
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext contex) => const HomeScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(methods?.status.toString() ?? "null"),
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
            message != ""
                ? Text(
                    message,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
            TextFormField(
              controller: amountController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              ],
              decoration: const InputDecoration(labelText: '¿Cantidad?'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              hint: const Text('Selecciona tu metodo de recarga'),
              items: methods?.data?.getMethods
                      ?.map((e) => DropdownMenuItem<String>(
                          value: e.id, child: Text(e.name.toString())))
                      .toList() ??
                  [],
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext contex) =>
                                  const MethodsScreen()));
                    },
                    child: const Text("Agregar otro metodo de recarga"))
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (dropdownValue == null) {
                    error = "Selecciona un metodo de recarga";
                    setState(() {});
                    Future.delayed(const Duration(seconds: 3), () {
                      error = "";
                      setState(() {});
                    });
                  }
                  if (_formKey.currentState!.validate()) {
                    await submitData(userController.text, amountController.text,
                        dropdownValue!, dateController.text);
                  }
                },
                child: const Text("Recargar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
