import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solicitar producto...',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const FormProduct(),
    );
  }
}

class FormProduct extends StatefulWidget {
  const FormProduct({
    super.key,
  });

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  String? dropdownValue;
  String? dropdownValueType = "Credito";
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController installmentsController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();

/*
  Future<void> submitData(String amount, String datetime,
      String installments) async {
    DateTime ahora = DateTime.now().toUtc();
    String formateado =
    DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'').format(ahora);
    String mutation = """
    mutation{
    postProduct(
        id: ""
        userID: "huye122"
        kind: "loan"
        ea: "3.1"
        amount: $amount
        installments: $installments
        dateTime: "$formateado"
    ){
        ok
        product{
            id
            userID
            kind
            ea
            amount
            installments
            dateTime
        }
        
        }
}
  """;
    print(mutation);
     //final response = await Dio().post(
     //  "http://127.0.0.1:8000/graphql",
     //  data: {"query": mutation},
     //);
     //print(response);
  }
*/

  Future<void> submitData(String amount, String datetime,
      String installments) async {
    var url = Uri.parse("http://10.0.2.2:8000/graphql");

    if (kIsWeb) {
      // Some web specific code there
      url = Uri.parse("http://127.0.0.1:8000/graphql");
    } else {
      // Some android/ios specific code
      url = Uri.parse("http://10.0.2.2:8000/graphql");
    }

    var response = await http.post(url, body: {
        'query': '''
              mutation {
                  postProduct(
                      id: ""
                      userID: "prueba"
                      kind: "loan"
                      ea: "2.9"
                      amount: $amount
                      installments: $installments
                      dateTime: "2024-04-01T08:56:25.317Z"
                  ){
                      ok
                      product{
                          id
                          userID
                          kind
                          ea
                          amount
                          installments
                          dateTime
                      }
        
                      }
              }
        
        '''

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
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                    'La tasa actual es de 3.1%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Add the static text label
              ],
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
              controller: installmentsController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              inputFormatters: [
                 FilteringTextInputFormatter.allow(
                     RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
               ],
              decoration: const InputDecoration(labelText: 'Cuotas'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa número de cuotas";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              hint: const Text('Selecciona el tipo de producto'),
              items: ["Credito"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueType = newValue;
                });
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
                        amountController.text,
                        datetimeController.text,
                        installmentsController.text);
                  }
                },
                child: const Text("Solicitar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
