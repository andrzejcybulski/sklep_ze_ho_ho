import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_ze_ho_ho/app/cart/cart_page.dart';
import 'package:sklep_ze_ho_ho/app/home/home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              leading: const BackButton(),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.grey),
                        onPressed: () => Navigator.of(context).pop(
                          HomePage(user: user!),
                        ),
                        // {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomePage(user: user!),
                        //     ),
                        //   );
                        // },
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.shopping_cart, color: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const YourCartPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
              title: const Text('Ustawienia'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: Container(color: Colors.grey, height: 0.3),
              ),
              backgroundColor: const Color.fromARGB(255, 53, 53, 53),
            ),
            body: const Center(
              child: Text('Ustawienia'),
            ),
          );
        });
  }
}
