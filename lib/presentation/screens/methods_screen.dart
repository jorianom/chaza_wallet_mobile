import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodsScreen extends StatelessWidget {
  const MethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              keyboardType: TextInputType.text,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              // ],
              decoration:
                  const InputDecoration(labelText: 'Nombre de tu metodo'),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              // ],
              decoration: const InputDecoration(labelText: 'Nombre titular'),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.datetime,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              // ],
              decoration:
                  const InputDecoration(labelText: 'Fecha de vencimiento'),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]')), // Solo permite números del 0 al 9
              ],
              decoration: const InputDecoration(labelText: 'Número'),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              hint: const Text('Selecciona un tipo de metodo'),
              items: ["Credito", "Debito"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
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
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
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
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
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
