import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {


  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();

  final yearController = TextEditingController();
  final hpController = TextEditingController();
  final torqueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มเพิ่มข้อมูล'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อรายการ',
                  ),
                  autofocus: false,
                  controller: titleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
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
                  },
                ),
                TextButton(
                    child: const Text('บันทึก'),
                    onPressed: () {
                          if (formKey.currentState!.validate())
                            {
                              // create transaction data object
                              var statement = Transactions(
                                  keyID: null,
                                  brand: brandController.text,
                                  model: modelController.text,
                                  year: int.parse(yearController.text),
                                  hp: double.parse(hpController.text),
                                  torque: double.parse(torqueController.text),
                                  date: DateTime.now()
                                  );
                            
                              // add transaction data object to provider
                              var provider = Provider.of<TransactionProvider>(context, listen: false);
                              
                              provider.addTransaction(statement);

                              Navigator.push(context, MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context){
                                  return MyHomePage();
                                }
                              ));
                            }
                        })
              ],
            )));
  }
}
