import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/infraestructure/models/errors_auth.dart';
import 'package:chaza_wallet/infraestructure/models/product.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:chaza_wallet/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

String idUser = "";

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    idUser = authModel.userId;
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
  Product? product;
  String error = "";
  String message = "";
  String? dropdownValue;
  String? dropdownValueType = "Credito";
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController installmentsController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();

  Future<void> submitData(
      String amount, String datetime, String installments) async {
    String url;
    // print(authModel.token);
    if (kIsWeb) {
      // Some web specific code there
      url = "https://35.238.88.129:82/graphql";
    } else {
      // Some android/ios specific code
      url = "http://10.0.2.2:81/graphql";
    }
    DateTime ahora = DateTime.now().toUtc();
    String formateado =
        DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'').format(ahora);

    String mutation = """
    mutation {
                  postProduct(
                      id: ""
                      userID: "$idUser"
                      kind: "loan"
                      ea: "2.9"
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
    var response =
        await DioClient.instance.post(url, data: {"query": mutation});
    print(response);
    product = Product.fromJson(response.data);
    print(product?.data?.postProduct?.ok);
    if (product?.data?.postProduct?.product?.id != null) {
      message = "Solicitud exitosa";
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
            const Row(
              children: [
                Text('La tasa actual es de 3.1%',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold)), // Add the static text label
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
                    await submitData(amountController.text,
                        datetimeController.text, installmentsController.text);
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
