import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_ze_ho_ho/app/home/home_page.dart';
import 'package:sklep_ze_ho_ho/app/settings/setting_page.dart';

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
              leading: BackButton(
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
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.grey),
                        onPressed: () => Navigator.of(context).pop(
                          SettingsPage(),
                        ),
                        // {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SettingsPage(),
                        //     ),
                        //   );
                        // },
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.shopping_cart, color: Colors.grey),
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
                    ],
                  ),
                ),
              ],
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
