import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("The Garage"),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: Consumer<TransactionProvider>(
          builder: (context, provider, Widget? child) {
            if (provider.transactions.isEmpty) {
              return const Center(
                child: Text('ไม่มีรายการ'),
              );
            } else {
              return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  var statement = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Brand: ${statement.brand}'),
                          Text('Model: ${statement.model}'),
                          Text('Year: ${statement.year}'),
                          Text('HP: ${statement.hp}'),
                          Text('Torque: ${statement.torque}'),
                          Text('Date: ${DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date)}'),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 40,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteTransaction(statement.keyID);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditScreen(statement: statement);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}
