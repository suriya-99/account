import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();

  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final hpController = TextEditingController();
  final torqueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with statement data
    brandController.text = widget.statement.brand;
    modelController.text = widget.statement.model;
    yearController.text = widget.statement.year.toString();
    hpController.text = widget.statement.hp.toString();
    torqueController.text = widget.statement.torque.toString();
  }

  @override
  void dispose() {
    // Clean up controllers
    brandController.dispose();
    modelController.dispose();
    yearController.dispose();
    hpController.dispose();
    torqueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ยี่ห้อ',
                ),
                autofocus: false,
                controller: brandController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null; // Add return null if no error
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'รุ่น',
                ),
                autofocus: false,
                controller: modelController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ปี',
                ),
                keyboardType: TextInputType.number,
                controller: yearController,
                validator: (String? input) {
                  try {
                    int year = int.parse(input!);
                    if (year < 0) {
                      return 'กรุณากรอกข้อมูลมากกว่า 0';
                    }
                  } catch (e) {
                    return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'แรงม้า',
                ),
                keyboardType: TextInputType.number,
                controller: hpController,
                validator: (String? input) {
                  try {
                    double hp = double.parse(input!);
                    if (hp < 0) {
                      return 'กรุณากรอกข้อมูลมากกว่า 0';
                    }
                  } catch (e) {
                    return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'แรงบิด',
                ),
                keyboardType: TextInputType.number,
                controller: torqueController,
                validator: (String? input) {
                  try {
                    double torque = double.parse(input!);
                    if (torque < 0) {
                      return 'กรุณากรอกข้อมูลมากกว่า 0';
                    }
                  } catch (e) {
                    return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                  }
                  return null;
                },
              ),
              TextButton(
                  child: const Text('แก้ไขข้อมูล'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Create transaction data object
                      var statement = Transactions(
                        keyID: widget.statement.keyID,
                        brand: brandController.text,
                        model: modelController.text,
                        year: int.parse(yearController.text),
                        hp: double.parse(hpController.text),
                        torque: double.parse(torqueController.text),
                        date: DateTime.now(), // Use current date or use a date picker for more flexibility
                      );
                      // Add transaction data object to provider
                      var provider = Provider.of<TransactionProvider>(context, listen: false);

                      provider.updateTransaction(statement);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return MyHomePage();
                              }));
                    }
                  })
            ],
          ),
        ));
  }
}
