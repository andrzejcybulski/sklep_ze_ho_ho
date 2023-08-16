import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_ze_ho_ho/app/features/home/home_page.dart';

class YourCartPage extends StatefulWidget {
  const YourCartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<YourCartPage> createState() => _YourCartPageState();
}

class _YourCartPageState extends State<YourCartPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 88, 84, 84),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(
                  HomePage(user: user!),
                ),
              ),
              title: const Text('Koszyk'),
              backgroundColor: const Color.fromARGB(255, 53, 53, 53),
            ),
            body: Center(
              child: Text('Twój koszyk ${user!.email}'),
            ),
          );
        });
  }
}
