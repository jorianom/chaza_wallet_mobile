import 'dart:convert';

import 'package:chaza_wallet/infraestructure/models/methods.dart';
import 'package:chaza_wallet/presentation/screens/methods_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    getMethods();
  }

  Future<void> getMethods() async {
    final response = await Dio()
        .post("https://chaza-wallet-ag-ithgocyoua-uc.a.run.app/graphql", data: {
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

  Future<void> submitData(String name, String titular, String duedate,
      String number, String type, String sucursal) async {
    String mutation = """
    mutation {
      postMethod(
        user: "9746498",
        duedate: "$duedate",
        number: "$number",
        sucursal: "$sucursal",
        type: "$type",
        titular: "$titular",
        name: "$name",
      ) {
        ok
        response{
            id 
            status
        }
      }
    }
  """;
    print(mutation);
    final response = await Dio().post(
      "https://chaza-wallet-ag-ithgocyoua-uc.a.run.app/graphql",
      data: {"query": mutation},
    );
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(methods?.status.toString() ?? "null"),
            const SizedBox(height: 15),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              ],
              decoration: const InputDecoration(labelText: '¿Cantidad?'),
              validator: (value) {
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
                onPressed: () {},
                child: const Text("Recargar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
