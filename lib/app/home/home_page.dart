import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

var currentIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sklep Że Ho Ho'),
        backgroundColor: Colors.red,
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Jesteś zalogowany jako ${widget.user.email}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Wyloguj się'),
                ),
              ],
            ),
          );
        }
        return const Scaffold(
            body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lista Produktów'),
          ],
        )));
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify),
            label: 'Sklep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          )
        ],
      ),
    );
  }
}
