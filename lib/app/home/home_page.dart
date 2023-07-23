import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklep_ze_ho_ho/app/cart/cart_page.dart';
import 'package:sklep_ze_ho_ho/app/settings/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 88, 84, 84),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YourCartPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          title: Builder(
            builder: (context) {
              if (currentIndex == 0) {
                return const Text('Produkty');
              }
              if (currentIndex == 1) {
                return const Text('Wyszukiwanie');
              }
              if (currentIndex == 2) {
                return const Text('Ulubione');
              }
              return const Text('Moje konto');
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(color: Colors.grey, height: 0.3),
          ),
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        ),
        body: Builder(
          builder: (context) {
            if (currentIndex == 0) {
              return const ProductsPageContent();
            }
            if (currentIndex == 1) {
              return const Center(
                child: Text('Szukaj'),
              );
            }

            if (currentIndex == 2) {
              return const Center(
                child: Text('Ulubione'),
              );
            }

            return MyAccountPageContent(email: widget.user.email);
          },
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 53, 53, 53),
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey,
            elevation: 0.0,
            currentIndex: currentIndex,
            onTap: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Sklep',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Szukaj',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_rounded),
                label: 'Ulubione',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Konto',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Jesteś zalogowany jako $email',
            style: const TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              // shape: const StadiumBorder(),
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
}

class ProductsPageContent extends StatelessWidget {
  const ProductsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Coś poszło nie tak');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Ładowanie');
        }

        final documents = snapshot.data!.docs;

        return GridView.count(
          crossAxisCount: 2,
          children: [
            for (final document in documents) ...[
              Container(
                child: Text(
                  document['name'],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
  // );
}
// }
