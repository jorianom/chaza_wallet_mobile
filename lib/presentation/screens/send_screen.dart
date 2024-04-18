import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController receiverController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> submitData(String receiver, String amount, String datetime,
      String description) async {
    DateTime ahora = DateTime.now().toUtc();
    String formateado =
        DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'').format(ahora);
    String mutation = """
    mutation {
    addTransaction(
        amount: "$amount",
        dateTime: "$formateado",
        description: "$description",
        senderId: "$receiver",
        receiverId: "$receiver",
    ) {
        transactionId
    }
}
  """;
    print(mutation);
    // final response = await Dio().post(
    //   "https://chaza-wallet-ag-ithgocyoua-uc.a.run.app/graphql",
    //   data: {"query": mutation},
    // );
    // print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            TextFormField(
              controller: receiverController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]')), // Solo permite números del 0 al 9
              ],
              decoration:
                  const InputDecoration(labelText: 'Número de documento '),
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
