import 'package:chaza_wallet/infraestructure/models/add_transactions.dart';
import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/infraestructure/models/errors_auth.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:chaza_wallet/presentation/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

String phoneUser = "";

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    phoneUser = authModel.phoneUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Envía Dinero ...',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const FormSend(),
    );
  }
}

class FormSend extends StatefulWidget {
  const FormSend({
    super.key,
  });

  @override
  State<FormSend> createState() => _FormSendState();
}

class _FormSendState extends State<FormSend> {
  AddTransaction? transaction;
  String error = "";
  String message = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController receiverController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> submitData(String receiver, String amount, String datetime,
      String description) async {
    String url;
    DateTime ahora = DateTime.now().toUtc();
    String formateado =
        DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'').format(ahora);
    String mutation = """
    mutation {
    addTransaction(
        amount: $amount,
        dateTime: "$formateado",
        description: "$description",
        senderPhone: "$phoneUser",
        receiverPhone: "$receiver",
    ) {
        transactionId
    }
}
  """;
    if (kIsWeb) {
      // Some web specific code there
      url = "https://35.238.88.129:82/graphql";
    } else {
      // Some android/ios specific code
      url = "http://10.0.2.2:81/graphql";
    }
    final response = await DioClient.instance.post(
      url,
      data: {"query": mutation},
    );
    print(response);
    transaction = AddTransaction.fromJson(response.data);
    print(transaction?.data?.addTransaction?.transactionId);
    if (transaction?.data?.addTransaction?.transactionId != null) {
      message = "Envio exitoso";
      setState(() {});
      Future.delayed(const Duration(seconds: 2), () {
        error = "";
        message = "";
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext contex) => const HomeScreen()));
        });
      });
    } else {
      ErrorsAuth message = ErrorsAuth.fromJson(response.data);
      error = "Ups hubo un error: ${message.errors![0].message!}";
      setState(() {});
      Future.delayed(const Duration(seconds: 2), () {
        error = "";
        setState(() {});
      });
    }
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
              controller: receiverController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]')), // Solo permite números del 0 al 9
              ],
              decoration: const InputDecoration(labelText: 'Celular '),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
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
            TextFormField(
              controller: descriptionController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              // ],
              decoration: const InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await submitData(
                        receiverController.text,
                        amountController.text,
                        datetimeController.text,
                        descriptionController.text);
                  }
                },
                child: const Text("Transferir"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
