import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/infraestructure/models/methods_response.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:chaza_wallet/presentation/screens/recharges_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

String idUser = "";

class MethodsScreen extends StatelessWidget {
  const MethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    idUser = authModel.userId;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Añade un metodo ...',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: const FormMethods());
  }
}

class FormMethods extends StatefulWidget {
  const FormMethods({
    super.key,
  });

  @override
  State<FormMethods> createState() => _FormMethodsState();
}

class _FormMethodsState extends State<FormMethods> {
  ResponseMethods? responseMethods;
  String? dropdownValue;
  String? dropdownValueType = "Credito";
  String message = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController titularController = TextEditingController();
  TextEditingController duedateController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController sucursalController = TextEditingController();

  Future<void> submitData(String name, String titular, String duedate,
      String number, String type, String sucursal) async {
    String url;
    String mutation = """
    mutation {
      postMethod(
        user: "$idUser",
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
    responseMethods = ResponseMethods.fromJson(response.data);
    // print(methods?.message);
    setState(() {});
    if (responseMethods?.data?.postMethod?.response?.status == 202) {
      message = "Se ha guardado con exito";
      setState(() {});
      Future.delayed(const Duration(seconds: 3), () {
        message = "";
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext contex) => const RechargesScreen()));
        });
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
            // Text(methods?.status.toString() ?? "null"),
            const SizedBox(height: 15),
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
              controller: nameController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration:
                  const InputDecoration(labelText: 'Nombre de tu metodo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: titularController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Nombre titular'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: duedateController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9-]')), // Solo permite números del 0 al 9
              ],
              decoration: const InputDecoration(
                  labelText: 'Fecha de vencimiento (mm-dd-aaaa)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: numberController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              ],
              decoration: const InputDecoration(labelText: 'Número'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un valor";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: dropdownValueType,
              hint: const Text('Selecciona un tipo de metodo'),
              items: ["Credito", "Debito"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueType = newValue;
                });
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              hint: const Text('Selecciona una sucursal'),
              items: ["Visa", "MasterCard"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Volver"),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await submitData(
                              nameController.text,
                              titularController.text,
                              duedateController.text,
                              numberController.text,
                              dropdownValueType!,
                              dropdownValue!);
                        }
                      },
                      child: const Text("Guardar"),
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
