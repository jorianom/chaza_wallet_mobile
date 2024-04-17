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
              items: list
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
                print(dropdownValue);
              },
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
